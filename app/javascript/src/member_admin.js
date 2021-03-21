import Rails from '@rails/ujs';

class MemberAdminPaginator {
  constructor(members_per_page = 50) {
    this.members = document.getElementsByClassName('admin_members_table_row');
    this.members_per_page = members_per_page;
    this.pages = Math.ceil(this.members.length / this.members_per_page);
    this.paginationElems = document.querySelector('.pagination');

    this.current_page = 0;

    this._generate_pages();
    this.show_page(0);
  }

  _show_row(params) {
    for (let idx = 0; idx < this.members.length; idx++) {
      if (idx >= params['start'] && idx <= params['end']) {
        this.members[idx].removeAttribute('style');
      } else {
        this.members[idx].style.display = 'none';
      }
    }
  }

  show_page(page_number) {
    this._show_row({
      start: page_number * this.members_per_page,
      end: (page_number + 1) * this.members_per_page - 1
    });
    this._select_page(page_number);
  }

  _prev_elem() {
    const prev = document.createElement('li');
    prev.textContent = '«';
    prev.classList.add('page-link');
    prev.setAttribute('data-page', 'previous');

    return prev;
  }

  _next_elem() {
    const next = document.createElement('li');
    next.textContent = '»';
    next.classList.add('page-link');
    next.setAttribute('data-page', 'next');

    return next;
  }

  _page_elem(idx) {
    const page = document.createElement('li');
    page.textContent = `${idx + 1}`;
    page.classList.add('page-link');
    page.id = `page_link_${idx}`;
    page.setAttribute('data-page', idx);

    return page;
  }

  _generate_pages() {
    const prev = this._prev_elem();
    const next = this._next_elem();

    const pagination_list = [];

    for (let i = 0; i < this.pages; i++) {
      pagination_list.push(this._page_elem(i));
    }

    this.paginationElems.appendChild(prev);

    pagination_list.forEach((elem, idx) => {
      this.paginationElems.appendChild(elem);

      if (idx == this.current_page) {
        elem.classList.add('page-link--active');
      }
    });

    this.paginationElems.appendChild(next);

    prev.addEventListener('click', () => {
      if (this.current_page > 0) this.current_page--;
      this._select_page(this.current_page);
      this._show_page(this.current_page);
    });

    next.addEventListener('click', () => {
      if (this.current_page < this.pages - 1) this.current_page++;
      this._select_page(this.current_page);
      this._show_page(this.current_page);
    });

    this.paginationElems.addEventListener(
      'click',
      function (e) {
        if (
          e.target.hasAttribute('data-page') &&
          !isNaN(e.target.getAttribute('data-page')) &&
          e.target.getAttribute('data-page') != null
        ) {
          this.current_page = Number(e.target.getAttribute('data-page'));
        }

        this.show_page(this.current_page);
      }.bind(this)
    );
  }

  _select_page(page_number) {
    for (const el of this.paginationElems.children) {
      el.classList.remove('page-link--active');
    }

    document
      .querySelector(`.page-link[data-page='${page_number}']`)
      .classList.add('page-link--active');
  }
}

class MemberAdminSearch {
  constructor() {
    this.members;
    this.tableElem = document.getElementById('search-result-table');
    this.tableBodyElem = document.getElementById('search-result-body');
    this.language = window.location.pathname.split('/')[1];

    const searchForm = document.getElementById('member_search_form');
    const formField = document.getElementById('member_search');

    formField.addEventListener(
      'input',
      function (e) {
        e.preventDefault();
        if (
          formField.value.length > 2 ||
          (isFinite(Number(formField.value)) && formField.value != '')
        ) {
          Rails.fire(searchForm, 'submit');
        } else {
          this._clearTable();
        }
      }.bind(this)
    );

    searchForm.addEventListener('ajax:before', this._waitingSpinner.bind(this));

    searchForm.addEventListener('ajax:success', (ev) => {
      this.tableElem.classList.remove('hidden');
      this.members = ev.detail[0]; // Object with the member data
      this._renderResponse();
    });
  }

  _waitingSpinner() {
    this.tableElem.classList.remove('hidden');
    this.tableBodyElem.innerHTML = `
      <tr id="spinner-tr">
        <td colspan="4"class="spinner-border" id="spinner" role="status">
          <span class="visually-hidden">Loading...</span> 
        </td>
      </tr>
    `;
  }

  _clearTable() {
    this.tableBodyElem.innerHTML = '';
  }

  _renderResponse() {
    let html = '';

    if (this.members == 0) {
      this.tableBodyElem.innerHTML = 'No results';
      return;
    }

    this.members.forEach((member) => {
      let member_number;

      if (member.member_number == undefined) {
        member_number = '---';
      } else {
        member_number = member.member_number;
      }

      html += `
      <tr>
        <th scope="row">
          <a href="/${this.language}/member_admin/${member.id}">
            ${member_number}
          </a>
        </th>
        <td>${member.email}</td>
        <td>${member.name}</td>
        <td>${member.surname1} ${member.surname2}</td>
      </tr>
      `;
    });

    this.tableBodyElem.innerHTML = html;
  }
}

document.addEventListener('turbolinks:load', function () {
  if (window.location.pathname.split('/').slice(2)[0] == 'member_admin') {
    const map = new MemberAdminPaginator(50);
    const mas = new MemberAdminSearch();
  }
});

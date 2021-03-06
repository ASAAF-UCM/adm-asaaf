if (window.location.pathname.split('/').slice(2)[0] == 'member_admin') {
  document.addEventListener('turbolinks:load', function (e) {
    const members = document.getElementsByClassName('admin_members_table_row');
    const pages = Math.ceil(members.length / 50);
    const paginationElems = document.querySelector('.pagination');
    const members_per_page = 50;

    let current_page = 0;

    // Functions

    function show_row(params) {
      for (let idx = 0; idx < members.length; idx++) {
        if (idx >= params['start'] && idx <= params['end']) {
          members[idx].removeAttribute('style');
        } else {
          members[idx].style.display = 'none';
        }
      }
    }

    function show_page(page_number) {
      show_row({
        start: page_number * members_per_page,
        end: (page_number + 1) * members_per_page - 1
      });
    }

    function generate_pages() {
      const pagination = document.getElementsByClassName('pagination')[0];

      const prev = document.createElement('li');
      prev.textContent = '«';
      prev.classList.add('page-link');
      prev.setAttribute('data-page', 'previous');

      const next = document.createElement('li');
      next.textContent = '»';
      next.classList.add('page-link');
      next.setAttribute('data-page', 'next');

      const pagination_list = [];

      for (let i = 0; i < pages; i++) {
        const page = document.createElement('li');
        page.textContent = `${i + 1}`;
        page.classList.add('page-link');
        page.id = `page_link_${i}`;
        page.setAttribute('data-page', i);
        pagination_list.push(page);
      }

      paginationElems.appendChild(prev);

      pagination_list.forEach((elem, idx) => {
        pagination.appendChild(elem);
        if (idx == current_page) {
          elem.classList.add('page-link--active');
        }
      });

      pagination.appendChild(next);

      prev.addEventListener('click', (el) => {
        if (current_page > 0) current_page--;
        select_page(current_page);
        show_page(current_page);
      });

      next.addEventListener('click', (el) => {
        if (current_page < pages - 1) current_page++;
        select_page(current_page);
        show_page(current_page);
      });
    }

    function select_page(page_number) {
      for (const el of paginationElems.children) {
        el.classList.remove('page-link--active');
      }

      document
        .querySelector(`.page-link[data-page='${page_number}']`)
        .classList.add('page-link--active');
    }

    generate_pages();
    show_row({ start: 0, end: members_per_page - 1 });

    paginationElems.addEventListener('click', function (e) {
      if (
        e.target.hasAttribute('data-page') &&
        !isNaN(e.target.getAttribute('data-page')) &&
        e.target.getAttribute('data-page') != null
      ) {
        current_page = Number(e.target.getAttribute('data-page'));
      }

      select_page(current_page);
      show_page(current_page);
    });
  });
}

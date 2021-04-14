import Rails from '@rails/ujs';
import Paginator from './paginator.js';
import 'bootstrap';

/**
 *  Class for managing the asynchronous loading of the members
 */
class MemberAdminController {
  // With this class we manage the get petitions to the web. What this should do
  // is:
  //   - Generate paginators for members and for non-members
  //   - Make get petition to the server and update the view
  constructor() {
    const elements_with_data = document.querySelector('#js-memberadmindata');
    this._numberOfMembers = elements_with_data.dataset.numberOfMembers;
    this._numberOfNotMembers = elements_with_data.dataset.numberOfNotMembers;

    this._memberPaginator = new Paginator(
      Math.ceil(this._numberOfMembers / 25 - 1),
      'members'
    );
    this._notMemberPaginator = new Paginator(
      Math.ceil(this._numberOfNotMembers / 25 - 1),
      'notMembers'
    );

    // Get the page number the user has clicked on
    this._memberPaginator.addHandlerClick((...args) => this._selectPage(...args, 'members'));
    this._notMemberPaginator.addHandlerClick((...args) => this._selectPage(...args, 'notMembers'));

    this._selectPage(0, 'members');
    this._selectPage(0, 'notMembers');

  }

  /**
   * Returns the HTMLElement of the table body that corresponds to selected type of members.
   * @param {String} type The type ('members' or 'notMembers') of the members to retrieve.
   * @return {HTMLElement} The table element
   */
  _tableBodyElement (type) {
    switch (type) {
    case 'members':
      return document.querySelector('.admin_members_table_body')
    case 'notMembers':
      return document.querySelector('.admin_not_members_table_body')
    }
  }

  /**
   * Change to some page
   */

  async _selectPage (pageNumber, type) {
    const members = await this._getMembers(pageNumber, type);
    if (type === 'members') {
      this._memberPaginator.changePage(pageNumber);
    } else {
      this._notMemberPaginator.changePage(pageNumber);
    }
    this._renderMembers(members, type);
  }


  /**
   * Get all the members at a given page
   * @param {Number} page The page the members are at;
   */
  async _getMembers(page, type) {
    // We want to make petitions only if we are on the index of memberadmin
    if (window.location.pathname.split('/').slice(3).length !== 0) return;

    const body = {
      page: page,
      opts: {
        type: type
      }
    };
    const opts = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.getElementsByName('csrf-token')[0].content
      },
      body: JSON.stringify(body)
    };

    try {
      const data = await fetch(window.location.pathname + '/page', opts)
        .then( function(res) {
          if (!res.ok) throw new Error(`An error ${res.status} happened!`);
          return res.json();
        })
        .then( function(data) {
          return data;
        });
      return data;
    } catch {
      console.error('An error happened!');
    }
  }

  /**
   * Renders a spinning button in the table used to display the results
   */
  _renderSpinner(type) {
    const tableBodyElement = this._tableBodyElement(type);

    tableBodyElement.innerHTML = `
      <tr id="spinner-tr">
        <td colspan="4" class="spinner-border" id="spinner" role="status">
          <span class="visually-hidden">Loading...</span> 
        </td>
      </tr>
    `;
  }

  /**
   * Return the markup for rendering a column for a member
   * @param {Object} member The data of a member
   */
  _markupMemberRow(member) {
    return `
        <th scope="row">
          <a href="${window.location.pathname}/${member.id}">
            ${member.member_number}
          </a>
        </th>
        <td>${member.email}</td>
        <td>${member.name}</td>
        <td>${member.surname1} ${member.surname2}</td>
      `;

  }

  /**
   * Return the markup for rendering a column for a not member
   * @param {Object} member The data of a member
   */
  _markupNotMemberRow(member) {
    return `
        <td>
          <a href="${window.location.pathname}/${member.id}">
            ${member.email}
          </a>
        </td>
        <td>${member.name}</td>
        <td>${member.surname1} ${member.surname2}</td>
      `;
  }

  /**
   *  Given an array with member data, place it in the table
   *  @param {Array} members Array with all the members
   */
  _renderMembers (members, type) {
    const tableBodyElement = this._tableBodyElement(type);
    tableBodyElement.innerHTML = '';
    
    members.forEach( (member, idx) => {
      const row = document.createElement('tr');
      row.classList.add('admin_members_table_row');
      row.innerHTML = (type == 'members') ? 
        this._markupMemberRow(member) : 
        this._markupNotMemberRow(member);
      tableBodyElement.appendChild(row);
    });
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
  const currentLocation = window.location.pathname.split('/').slice(2);
  if (
    currentLocation[0] === 'member_admin' &&
    currentLocation.length === 1
  ) {
    const adminController = new MemberAdminController();
    const mas = new MemberAdminSearch();
  }
});

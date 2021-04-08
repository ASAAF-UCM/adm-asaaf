/**
 *  Provides a paginator around a div with pagination class.
 */
export default class Paginator {
  /**
   * Constructor for the paginator
   * @param {Number} pages The number of pages to render
   */
  constructor(pages, parentElementName = '', start_page = 1) {
    this._parentElement = (!parentElementName) ?
      document.querySelector('.pagination') :
      document.querySelector(`.pagination--${parentElementName}`);
    this.parentElementName = parentElementName;
    this.currentPage = start_page;
    this.pages = pages;

    this._render();
  }

  changePage(page) {
    this.currentPage = page;
    this._clear();
    this._render();
  }

  _clear() {
    this._parentElement.innerHTML = '';
  }

  /**
   * Render the paginator at the bottom of the parentElement
   * @return {nil}
   */
  _render() {
    // Do not render a paginator if there's only one page
    if (this.pages == 1) return;

    // We want to show the first page, three pages before the current page,
    // three pages after the current page and the last page.
    let pagesToShow = [];

    pagesToShow.push(1);

    // If there is a gap betweeen the first page and the second page, we want
    // to render a button with dots inside in order to show this gap
    if (this.currentPage - 3 > 2) pagesToShow.push('.');

    for (let idx = this.currentPage - 3; idx <= this.currentPage + 3; idx++) {
      if (idx <= 1) continue;
      if (idx >= this.pages) continue;
      pagesToShow.push(idx);
    }

    if (this.currentPage + 3 < this.pages - 1) pagesToShow.push('.');

    pagesToShow.push(this.pages);

    // Render all the buttons
    if (this.currentPage !== 1)
      this._parentElement.appendChild(this._renderButton('previous'));

    pagesToShow.forEach((currValue) => {
      if (currValue == '.') {
        this._parentElement.appendChild(this._renderButton('dots'));
      } else {
        this._parentElement.appendChild(
          this._renderButton('number', currValue)
        );
      }
    });

    if (this.currentPage !== this.pages)
      this._parentElement.appendChild(this._renderButton('next'));
  }

  /**
   * Render a button
   * @param {String} type Define the button type to render
   * @param {String=} [page_number=''] The page number to render
   * @return {HTMLElement} The list element
   */
  _renderButton(type, page_number = '') {
    const button = document.createElement('li');
    const text = document.createElement('span');

    button.classList.add('page-item');
    text.classList.add('page-link');

    // prettier-ignore
    switch (type) {
    case 'previous':
    {
      text.textContent = '«';
      button.setAttribute('data-page', this.currentPage - 1);
      break;
    }
    case 'next':
    {
      text.textContent = '»';
      button.setAttribute('data-page', this.currentPage + 1);
      break;
    }
    case 'dots':
    {
      text.textContent = '...';
      button.classList.add('disabled');
      break;
    }
    default:
    {
      text.textContent = page_number;
      button.setAttribute('data-page', page_number);
      if (page_number === this.currentPage)
        text.classList.add('page-link--active');
      break;
    }
    }
    button.append(text);

    return button;
  }

  /**
   * Handler for passing the clicked page
   * @param {function} handler The action to be executed when clicked
   */
  addHandlerClick(handler) {
    this._parentElement.addEventListener('click', function (e) {
      const btn = e.target.closest('.page-item');

      if (!btn) return;
      if (btn.classList.contains('disabled')) return;

      const goToPage = +btn.dataset.page;
      handler(goToPage);
    });
  }
}

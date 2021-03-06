const allowedPathRegex = /\/(?:en|es)\/member_admin\/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/;

if (allowedPathRegex.test(window.location.pathname)) {
  class DropDownMember {
    constructor() {
      // prettier-ignore
      this.dropDownButton = document
        .getElementById('drop-down-member-button')
        .parentElement;
      // prettier-ignore
      this.dropDownButtonStatus = document
        .getElementById('drop-down-member-button');
      this.nameInput = document.getElementById('memberName');

      this.nameInput.addEventListener(
        'input',
        this._authorizeDelete.bind(this)
      );
    }

    _authorizeDelete() {
      if (this.nameInput.value === this.nameInput.placeholder) {
        this._unlockButton();
      } else {
        this._lockButton();
      }
    }

    _unlockButton() {
      this.dropDownButtonStatus.disabled = false;
    }

    _lockButton() {
      this.dropDownButtonStatus.disabled = true;
    }
  }

  document.addEventListener('turbolinks:load', function () {
    const d = new DropDownMember();
  });
}

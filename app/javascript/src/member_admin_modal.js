const allowedPathRegex = /\/(?:en|es)\/member_admin\/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/;

class MemberAdminModal {
  constructor(buttonId, textFieldId) {
    // prettier-ignore
    this.button = document
      .getElementById(buttonId)
      .parentElement;
    // prettier-ignore
    this.buttonStatus = document
      .getElementById(buttonId);
    this.nameInput = document.getElementById(textFieldId);

    this.nameInput.addEventListener('input', this._authorizeDelete.bind(this));
  }

  _authorizeDelete() {
    if (this.nameInput.value === this.nameInput.placeholder) {
      this._unlockButton();
    } else {
      this._lockButton();
    }
  }

  _unlockButton() {
    this.buttonStatus.disabled = false;
  }

  _lockButton() {
    this.buttonStatus.disabled = true;
  }
}

document.addEventListener('turbolinks:load', function () {
  if (allowedPathRegex.test(window.location.pathname)) {
    const dropDownModal = new MemberAdminModal(
      'drop-down-member-button',
      'memberName'
    );
    const convertIntoMemberModal = new MemberAdminModal(
      'convert-into-member-button',
      'memberNameConvert'
    );
  }
});

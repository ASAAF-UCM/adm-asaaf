// Añadir listener que resalte los campos que están mal y por qué.

function fieldValid(field) {
  field.classList.replace('is-invalid', 'is-valid') ||
    field.classList.add('is-valid');
}

function fieldNotValid(field) {
  field.classList.replace('is-valid', 'is-invalid') ||
    field.classList.add('is-invalid');
}

function resetValid(field) {
  field.classList.remove('is-valid');
  field.classList.remove('is-invalid');
}

function toggleValidity(field_id, condition) {
  condition ? fieldValid(field_id) : fieldNotValid(field_id);
}

function checkField(field_id, field_regex) {
  field_id.addEventListener('change', () => {
    field_regex.test(field_id.value)
      ? fieldValid(field_id)
      : fieldNotValid(field_id);
  });
}

function validatesName() {
  const name = document.getElementById('member_name');
  const name_regex = /^.{2,256}$/;
  checkField(name, name_regex);
}

function validatesSurname1() {
  const surname1 = document.getElementById('member_surname1');
  const surname1_regex = /^.{2,256}$/;
  checkField(surname1, surname1_regex);
}

function validatesSurname2() {
  const surname2 = document.getElementById('member_surname2');
  const surname2_regex = /^.{0,256}$/;
  checkField(surname2, surname2_regex);
}

function validatesEmail() {
  const email = document.getElementById('member_email');
  const email_regex = /(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/;
  checkField(email, email_regex);
}

function validatesPassword() {
  const password = document.getElementById('member_password');
  const password_regex = /^.{8,}$/;
  checkField(password, password_regex);
}

function doPasswordsMatch() {
  const password = document.getElementById('member_password');
  const password_confirmation = document.getElementById(
    'member_password_confirmation'
  );

  password_confirmation.addEventListener('change', () => {
    if (
      password.value === password_confirmation.value &&
      password_confirmation.value.length >= 8
    ) {
      fieldValid(password_confirmation);
    } else if (password_confirmation.value.length < 8) {
      resetValid(password_confirmation);
    } else {
      fieldNotValid(password_confirmation);
    }
  });
}

function validateBirthdate() {
  const birthdate_elem = document.getElementById('member_birthdate');

  const today = new Date();
  const minimum = new Date(
    today.getFullYear() - 14,
    today.getMonth(),
    today.getDate() - 1
  );

  birthdate_elem.addEventListener('change', () => {
    const birthdate = new Date(birthdate_elem.value);

    if (birthdate < minimum) {
      fieldValid(birthdate_elem);
    } else {
      fieldNotValid(birthdate_elem);
    }
  });
}

function validateExpirationDate() {
  const expiration_date_elem = document.getElementById(
    'member_id_document_expiration_date'
  );

  const today = new Date();
  const minimum = new Date(
    today.getFullYear(),
    today.getMonth(),
    today.getDate() + 1
  );

  expiration_date_elem.addEventListener('change', () => {
    const expiration_date = new Date(expiration_date_elem.value);

    if (expiration_date > minimum) {
      fieldValid(expiration_date_elem);
    } else {
      fieldNotValid(expiration_date_elem);
    }
  });
}

function checksumDNI(dni_number) {
  const number = dni_number.split('-')[0];
  const letter = dni_number.split('-')[1];
  const dni_array = [
    'T',
    'R',
    'W',
    'A',
    'G',
    'M',
    'Y',
    'F',
    'P',
    'D',
    'X',
    'B',
    'N',
    'J',
    'Z',
    'S',
    'Q',
    'V',
    'H',
    'L',
    'C',
    'K',
    'E',
    'T'
  ];

  if (
    /^\d+$/.test(number) &&
    /^[a-zA-Z]{1}$/.test(letter) &&
    dni_array[number % 23] === letter
  ) {
    return true;
  } else {
    return false;
  }
}

function validateID() {
  const id_type_elem = document.getElementById('member_id_document_type_id');
  const id_number_elem = document.getElementById('member_id_document_number');
  const elems = [id_type_elem, id_number_elem];
  const dni_regex = /^\d{1,8}-?[a-zA-Z]{1}$/;

  elems.forEach(function (elem) {
    elem.addEventListener('change', () => {
      if (id_number_elem.value === '') {
        fieldNotValid(id_number_elem);
        return;
      }

      if (
        id_type_elem.value == 1 &&
        (!dni_regex.test(id_number_elem.value) ||
          !checksumDNI(id_number_elem.value))
      ) {
        fieldNotValid(id_number_elem);
        return;
      }

      fieldValid(id_number_elem);
    });
  });
}

function validatesRegistration() {
  validatesName();
  validatesSurname1();
  validatesSurname2();
  validatesEmail();
  validatesPassword();
  doPasswordsMatch();
  validateBirthdate();
  validateID();
  validateExpirationDate();
}

document.addEventListener('turbolinks:load', () => {
  const actualPath = window.location.pathname;
  const registrationPathRegex = /\/(?:en|es)\/members\/new/;
  const newMemberPathRegex = /\/(?:en|es)\/member_admin\/new/;

  if (
    registrationPathRegex.test(actualPath) ||
    newMemberPathRegex.test(actualPath)
  ) {
    validatesRegistration();
  }
});

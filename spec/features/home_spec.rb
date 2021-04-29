# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User registration', type: :feature do
  it 'Loads root' do
    visit root_path
  end

  it 'User enters home page in Spanish and register' do
    visit '/es'

    click_on 'Registrarse'

    attach_file 'Imagen del documento de identidad',
                'spec/fixtures/DNI_test_image.jpg'

    fill_in 'Nombre', with: 'Benito'
    fill_in 'Primer apellido', with: 'Hurtado'
    fill_in 'Segundo apellido', with: 'Hurtado'
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Contraseña', with: 'thisisaverysafepassword'
    fill_in 'Confirmar contraseña', with: 'thisisaverysafepassword'
    fill_in 'Fecha de nacimiento', with: '01/01/2000'
    select 'DNI', from: 'member_id_document_type_id'
    fill_in 'Número del documento de identidad', with: '12345678-Z'
    fill_in 'Fecha de caducidad del documento de identidad', with: Time.zone.today + 1.day
    click_button 'Enviar'

    expect(page).to have_text('Acabamos de mandarte un mensaje con un enlace para confirmar tu dirección de correo electrónico a tu dirección de email. Por favor, sigue el link para activar tu cuenta
')
  end

  it 'User enters home page in English and register' do
    visit '/en'

    click_on 'Sign up'

    attach_file 'Image of the ID document', 'spec/fixtures/DNI_test_image.jpg'

    fill_in 'Name', with: 'Benito'
    fill_in 'First surname', with: 'Hurtado'
    fill_in 'Second surname', with: 'Hurtado'
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: 'thisisaverysafepassword'
    fill_in 'Password confirmation', with: 'thisisaverysafepassword'
    fill_in 'Date of birth', with: '01/01/2000'
    select 'DNI', from: 'member_id_document_type_id'
    fill_in 'ID document number', with: '12345678-Z'
    fill_in 'Expiration date of ID document', with: Time.zone.today + 1.day
    click_button 'Submit'

    expect(page).to have_text('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')
  end
end

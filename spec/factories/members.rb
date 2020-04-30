# frozen_string_literal: true

FactoryBot.define do
  factory :random_member, class: 'Member' do
    name                { Faker::Name.first_name }
    surname1            { Faker::Name.last_name }
    surname2            { Faker::Name.last_name }
    birthdate           { Faker::Date.birthday(min_age: 14, max_age: 115) }
    id_document_type_id { 1 }
    id_document_expiration_date { Faker::Date.forward(days: 10 * 365) }
    id_document_number  { Faker::IDNumber.spanish_citizen_number }
    member_number       { Faker::Number.number(digits: 4) }
    member_type_id      { 1 }
    member_since        do
      Faker::Date.between(
        from: Date.new(1994),
        to: Time.zone.today
      )
    end
    last_active_member_confirmation { Faker::Date.backward(days: 10 * 365) }
    moodle_name do
      Faker::Name.first_name +
        Faker::Name.last_name +
        Faker::Name.last_name
    end
    email { Faker::Internet.email(domain: 'example') }
    password { '97khj89ds7fd9ihu' }
  end
end

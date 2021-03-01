# frozen_string_literal: true

FactoryBot.define do
  factory :member, class: 'Member' do
    name                { Faker::Name.first_name }
    surname1            { Faker::Name.last_name }
    surname2            { Faker::Name.last_name }
    birthdate           { Faker::Date.birthday(min_age: 14, max_age: 115) }
    id_document_type_id { 1 }
    id_document_expiration_date { Faker::Date.forward(days: 10 * 365) }
    id_document_number { Faker::IDNumber.spanish_citizen_number }

    moodle_name { name + surname1 + surname2 }

    email { Faker::Internet.email(domain: 'example') }
    password { '97khj89ds7fd9ihu' }

    factory :random_member do
      member_number       { Faker::Number.number(digits: 4) }
      member_type_id      { 3 }
      member_since        do
        Faker::Date.between(
          from: Date.new(1994),
          to: Time.zone.today
        )
      end
      last_active_member_confirmation { Faker::Date.backward(days: 10 * 365) }

      factory :admin_member do
        after(:create) do |member, _evaluator|
          ra = RoleAllocation.new
          ra.promote_to_admin! member
        end
      end

      factory :accounting_member do
        after(:create) do |member, _evaluator|
          ra = RoleAllocation.new
          ra.promote_to({
                          role_type_id: 2,
                          member_id: member.id
                        })
        end
      end

      after(:create) do |member, _evaluator|
        member.update confirmed_at: DateTime.now
      end

      factory :secretary_member do
        after(:create) do |member, _evaluator|
          ra = RoleAllocation.new
          ra.promote_to({
                          role_type_id: 3,
                          member_id: member.id
                        })
        end
      end

      factory :loan_member do
        after(:create) do |member, _evaluator|
          ra = RoleAllocation.new
          ra.promote_to({
                          role_type_id: 4,
                          member_id: member.id
                        })
        end
      end
    end
  end
end

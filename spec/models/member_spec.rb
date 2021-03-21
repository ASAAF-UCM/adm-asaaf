# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Member, type: :model do
  context 'when validating tests' do
    let(:member) { build(:random_member) }

    it 'is valid with valid attributes' do
      expect(member.save).to eq(true)
    end

    it 'is invalid with name too short' do
      member.name = 'a'
      expect(member.save).to eq(false)
    end

    it 'is invalid with name too long' do
      member.name = 'a' * 257
      expect(member.save).to eq(false)
    end

    it 'is invalid with surname1 too short' do
      member.surname1 = 'a'
      expect(member.save).to eq(false)
    end

    it 'is invalid with surname1 too long' do
      member.surname1 = 'a' * 257
      expect(member.save).to eq(false)
    end

    it 'is invalid with surname2 too long' do
      member.surname2 = 'a' * 257
      expect(member.save).to eq(false)
    end

    it 'is invalid with birthdate not present' do
      member.birthdate = nil
      expect(member.save).to eq(false)
    end

    it 'is invalid with birthdate less than 14 years ago' do
      member.birthdate = 14.years.ago + 1.day
      expect(member.save).to eq(false)
    end

    it 'is invalid with id_document_type_id not present' do
      member.id_document_type_id = nil
      expect(member.save).to eq(false)
    end

    it 'is invalid with id_document_number not present' do
      member.id_document_number = nil
      expect(member.save).to eq(false)
    end

    it 'is invalid with id_document_expiration_date expired' do
      member.id_document_expiration_date = Time.zone.today
      expect(member.save).to eq(false)
    end

    it 'is invalid with member_since date being after today' do
      member.member_since = Time.zone.today + 1.day
      expect(member.save).to eq(false)
    end

    it 'is invalid with last_active_member_confirmation date being after today' do
      member.last_active_member_confirmation = Time.zone.today + 1.day
      expect(member.save).to eq(false)
    end
  end

  context 'when member exists and id has expired' do
    let(:member) { create(:random_member) }

    it 'is valid if using update_password' do
      member.id_document_expiration_date = Time.zone.today + 1.day
      update_params = { password: '12341234', password_confirmation: '12341234' }

      expect(member.update_password(update_params)).to eq(true)
    end

    it 'is not valid if password do not match and using update_password' do
      member.id_document_expiration_date = Time.zone.today + 1.day
      update_params = { password: '12341234', password_confirmation: '23452345' }

      expect(member.update_password(update_params)).to eq(false)
    end

    it 'is not valid if password is not valid and using update_password' do
      member.id_document_expiration_date = Time.zone.today + 1.day
      update_params = { password: '1234', password_confirmation: '1234' }

      expect(member.update_password(update_params)).to eq(false)
    end
  end

  context 'when a member is not a member anymore' do
    member = FactoryBot.create(:random_member)
    member.drop_out

    it 'is valid if name is --removed--' do
      expect(member.name).to eq('--removed--')
    end

    it 'is valid if surname1 is --removed--' do
      expect(member.surname1).to eq('--removed--')
    end

    it 'is valid if surname2 is blank' do
      expect(member.surname2).to be_blank
    end

    it 'is valid birthdate is 1900-01-01' do
      expect(member.birthdate).to eq(Date.new(1900, 1, 1))
    end

    it 'is valid if id_document_expiration_date is 1900-01-01' do
      expect(member.id_document_expiration_date).to eq(Date.new(1900, 1, 1))
    end

    it 'is valid if id_document_number is 13-J' do
      expect(member.id_document_number).to eq('13-J')
    end

    it 'is valid if member_number is 0' do
      expect(member.member_number).to eq(0)
    end

    it 'is valid if member_type_id is 4' do
      expect(member.member_type_id).to eq(4)
    end

    it 'is valid if member_since is nil' do
      expect(member.member_since).to eq(nil)
    end

    it 'is valid if last_active_member_confirmation is nil' do
      expect(member.last_active_member_confirmation).to eq(nil)
    end

    it 'is valid if moodle_name is nil' do
      expect(member.moodle_name).to eq(nil)
    end

    it 'is valid if email is the member id@example.com' do
      expect(member.email).to eq("#{member.id}@example.com")
    end

    it 'is valid if reset_password_token is nil' do
      expect(member.reset_password_token).to eq(nil)
    end

    it 'is valid if reset_password_sent_at is nil' do
      expect(member.reset_password_sent_at).to eq(nil)
    end

    it 'is valid if remember_created_at is nil' do
      expect(member.remember_created_at).to eq(nil)
    end

    it 'is valid if current_sign_in_at is nil' do
      expect(member.current_sign_in_at).to eq(nil)
    end

    it 'is valid if last_sign_in_at is nil' do
      expect(member.last_sign_in_at).to eq(nil)
    end

    it 'is valid if current_sign-in_ip is nil' do
      expect(member.current_sign_in_ip).to eq(nil)
    end

    it 'is valid if last_sign_in_ip is nil' do
      expect(member.last_sign_in_ip).to eq(nil)
    end

    it 'is valid if confirmation_token is nil' do
      expect(member.confirmation_token).to eq(nil)
    end

    it 'is valid if confirmed_at is nil' do
      expect(member.confirmed_at).to eq(nil)
    end

    it 'is valid if confirmation_sent_at is nil' do
      expect(member.confirmation_sent_at).to eq(nil)
    end

    it 'is valid if unconfirmed_email is nil' do
      expect(member.unconfirmed_email).to eq(nil)
    end

    it 'is valid if unlock_token is nil' do
      expect(member.unlock_token).to eq(nil)
    end

    it 'is valid if locked_at is NOT nil' do
      expect(member.locked_at).not_to eq(nil)
    end
  end
end

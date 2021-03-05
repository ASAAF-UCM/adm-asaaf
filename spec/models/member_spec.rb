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
end

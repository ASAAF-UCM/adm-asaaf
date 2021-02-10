# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DNIValidator, type: :model do
  context 'when a DNI number is supplied' do
    with_model :ObjectWithDNI do
      model do
        attr_accessor :DNI_number
        validates :DNI_number, DNI: true
      end
    end

    let(:model) { ObjectWithDNI.new }

    it 'is valid when control character is valid' do
      expect(model).to allow_value(Faker::IDNumber.spanish_citizen_number)\
        .for(:DNI_number)
    end

    it 'is valid when writing less than 8 digits' do
      expect(model).to allow_value('123-P').for(:DNI_number)
    end

    it 'is valid when not writing the hyphen' do
      expect(model).to allow_value('123P').for(:DNI_number)
    end

    # Correct format is 8 or less digits, an optional hyphen an a letter
    it 'is not valid when having more than 8 digits' do
      expect(model).not_to allow_value('123456789-B').for(:DNI_number)
    end

    it 'is not valid when control character does not exists' do
      expect(model).not_to allow_value('12345678').for(:DNI_number)
    end

    it 'is not valid when control character not matching' do
      expect(model).not_to allow_value('12345678-A').for(:DNI_number)
    end
  end
end

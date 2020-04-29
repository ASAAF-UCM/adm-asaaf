# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EarlierThanValidator, type: :model do
  context 'when a date is supplied' do
    with_model :ObjectWithDate do
      model do
        attr_accessor :date
        validates :date, earlier_than: { time_interval: 10.years }
      end
    end

    let(:model) { ObjectWithDate.new }

    it 'nil values should be valid' do
      expect(model).to allow_value(nil).for(:date)
    end

    it '10 years ago should be invalid' do
      expect(model).not_to allow_value(10.years.ago).for(:date)
    end

    it '10 years ago plus one day should be invalid' do
      expect(model).not_to allow_value(10.years.ago + 1.day).for(:date)
    end

    it '10 years ago minus one should be valid' do
      expect(model).to allow_value(10.years.ago - 1.day).for(:date)
    end
  end
end

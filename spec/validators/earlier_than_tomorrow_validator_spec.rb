# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EarlierThanTomorrowValidator, type: :model do
  context 'when a date is supplied' do
    with_model :ObjectWithDate do
      model do
        attr_accessor :date
        validates :date, earlier_than_tomorrow: true
      end
    end

    let(:model) { ObjectWithDate.new }

    it 'nil values should be valid' do
      expect(model).to allow_value(nil).for(:date)
    end

    it 'today should be valid' do
      expect(model).to allow_value(Time.zone.today).for(:date)
    end

    it 'yesterday should be valid' do
      expect(model).to allow_value(Time.zone.today - 1).for(:date)
    end

    it 'tomorrow should be invalid' do
      expect(model).not_to allow_value(Time.zone.today + 1).for(:date)
    end
  end
end

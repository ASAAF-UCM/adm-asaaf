# frozen_string_literal: true

class EarlierThanTomorrowValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value && (value > Time.zone.today)

    message = I18n.t 'activerecord.errors.validators.earlier_than_tomorrow'
    record.errors.add attribute, message
  end
end

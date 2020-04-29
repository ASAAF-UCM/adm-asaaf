# frozen_string_literal: true

class LaterThanYesterdayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value && (value < Time.zone.today)

    message = I18n.t 'activerecord.errors.validators.later_than_yesterday'
    record.errors.add attribute, message
  end
end

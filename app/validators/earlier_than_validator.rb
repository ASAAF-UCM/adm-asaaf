# frozen_string_literal: true

class EarlierThanValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value && (value >= Time.zone.today - options[:time_interval])

    message = I18n.t 'activerecord.errors.validators.earlier_than'
    record.errors.add attribute, message
  end
end

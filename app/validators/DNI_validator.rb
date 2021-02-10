# frozen_string_literal: true

class DNIValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    control_character_list = %w[T R W A G M Y F P D X B N J Z S Q V H L C K E]
    dni_regex = /^\d{1,8}[-]?[a-zA-Z]$/
    if value.match(dni_regex).nil?
      message = I18n.t 'activerecord.errors.validators.dni.format'
      record.errors.add attribute, message
      return
    end

    number = value[/\d{1,8}/].to_i
    control_character = value[/[a-zA-Z]/].capitalize
    return if control_character_list[number % 23] == control_character

    message = I18n.t 'activerecord.errors.validators.dni.control_character'
    record.errors.add attribute, message
  end
end

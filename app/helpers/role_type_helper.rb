# frozen_string_literal: true

module RoleTypeHelper
  def translate_role_type_name(element)
    I18n.t('models.role.names.' + element.role_name)
  end
end

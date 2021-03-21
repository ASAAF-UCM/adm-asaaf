# frozen_string_literal: true

module RoleTypeHelper
  def translate_role_type_name(role_name)
    role_name = role_name.role_name if role_name.is_a? RoleType
    I18n.t('models.role.names.' + role_name)
  end
end

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :get_user_roles
  helper_method :member_allowed?

  def get_user_roles(member)
    roles = []
    member.role_allocation_ids.each do |role_allocation|
      roles.append RoleType.find(RoleAllocation.find(role_allocation)\
                                 .role_type_id).role_name
    end
    roles
  end

  def member_allowed?(roles)
    if member_signed_in?
      get_user_roles(current_member).each do |member_role|
        return true if member_role.in? roles
      end
    end

    false
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[
                                        name
                                        surname1
                                        surname2
                                        birthdate
                                        id_document_type_id
                                        id_document_expiration_date
                                        id_document_number
                                        moodle_name
                                        image
                                      ])
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end

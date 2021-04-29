# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :get_user_roles
  helper_method :member_allowed?

  # Get the active roles for a given member
  #
  # @param member [Member]
  # @returns [Array] The active roles of the member
  def get_user_roles(member)
    RoleAllocation
      .joins(:member, :role_type)
      .where(member_id: member.id, is_active: true)
      .pluck(:role_name)
  end

  # Check if current_member is allowed to make this controller action
  #
  # @param roles [Array] Array with a string for each accepted role
  # @return [true, flase]
  def member_allowed?(roles)
    if member_signed_in?
      current_member.roles.each do |member_role|
        return true if member_role.in? roles
      end
    end

    false
  end

  # Select the desired language for the user after sign in
  def after_sign_in_path_for(_resource)
    I18n.with_locale current_member.member_setting.locale do
      home_path
    end
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
                                        id_image
                                        moodle_name
                                      ])
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    options.merge({ locale: I18n.locale })
  end
end

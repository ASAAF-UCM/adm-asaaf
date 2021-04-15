# frozen_string_literal: true

class MemberSettingsController < ApplicationController
  before_action :authenticate_member!

  def index
    @settings = MemberSetting.find_or_create_by(member_id: current_member.id)
  end

  def update
    settings = current_member.member_setting

    I18n.with_locale params[:membersetting][:locale] do
      if settings.update(update_params)
        flash[:success] = t_scoped 'success'
      else
        flash[:danger] = t_scoped 'error'
      end

      redirect_to settings_path
    end
  end

  private

  def update_params
    params.require(:membersetting).permit(:locale)
  end
end

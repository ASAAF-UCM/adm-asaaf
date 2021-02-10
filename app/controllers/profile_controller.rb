# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :authenticate_member!

  def index
    @member = current_member
  end

  def edit
    @member = current_member
  end

  def edit_password
    @member = current_member
  end

  def update_password
    @member = current_member
    if @member.update(update_params)
      bypass_sign_in(@member)
      redirect_to profile_path
      flash[:success] = t_scoped 'success'
    else
      flash.now[:danger] = @member.errors.messages.values.first.first
      render :edit_password
    end
  end

  private

  def update_params
    params.require(:member).permit(:reset_password_token, :password, :password_confirmation)
  end
end

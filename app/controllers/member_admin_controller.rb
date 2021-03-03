# frozen_string_literal: true

class MemberAdminController < ApplicationController
  before_action :authenticate_member!
  before_action do
    redirect_to root_path unless member_allowed? %w[admin accounting secretary loans]
  end

  def new; end

  def create; end

  def update
    @member = Member.find(params[:id])
    if @member.update(update_params)
      flash[:success] = t_scoped :success
      redirect_to member_admin_path(id: @member.id)
    else
      flash.now[:danger] = @member.errors.messages.values.first.first
      render :edit_member_admin
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def destroy; end

  def index
    @members = Member.where.not(member_number: nil).order(member_number: :asc)
    @not_members = Member.where(member_number: nil).order(created_at: :asc)
  end

  def show
    @member = Member.find(params[:id])
  end

  def confirm_email
    @member = Member.find(params[:id])
    @member.confirm unless @member.confirmed?
    redirect_to member_admin_path(id: @member.id)
  end

  def reset_email
    @member = Member.find(params[:id])
    @member.send_reset_password_instructions
    flash.alert = t_scoped :password_instructions_sent
    redirect_to member_admin_path(id: @member.id)
  end

  def unlock_account
    @member = Member.find(params[:id])
    @member.unlock_access!
    flash.alert = t_scoped :account_was_unlocked
    redirect_to member_admin_path(id: @member.id)
  end

  def lock_account
    @member = Member.find(params[:id])
    @member.lock_access!
    flash.alert = t_scoped :account_was_locked
    redirect_to member_admin_path(id: @member.id)
  end

  private

  def update_params
    params
      .require(:member)
      .permit(:name,
              :surname1,
              :surname2,
              :email,
              :birthdate,
              :id_document_number,
              :id_document_type_id,
              :id_document_expiration_date,
              :moodle_name)
  end
end

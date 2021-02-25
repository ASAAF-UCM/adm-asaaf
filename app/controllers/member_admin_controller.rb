# frozen_string_literal: true

class MemberAdminController < ApplicationController
  before_action :authenticate_member!
  before_action do
    redirect_to root_path unless member_allowed? %w[admin accounting secretary loans]
  end

  def new; end

  def create; end

  def update; end

  def edit; end

  def destroy; end

  def index
    @members = Member.where.not(member_number: nil).order(member_number: :asc)
  end

  def show
    @member = Member.find(params[:id])
  end
end

# frozen_string_literal: true

class RoleController < ApplicationController
  before_action :authenticate_member!
  before_action do
    redirect_to root_path unless member_allowed? ['admin']
  end
  def index
    @role_allocations = RoleAllocation.all
  end

  def new
    @role_allocation = RoleAllocation.new
  end

  def create
    @role_allocation = RoleAllocation.new(create_params)
    @role_allocation.save
    redirect_to action: 'index'
  end

  def destroy
    @role_allocation = RoleAllocation.find_by(id: params[:id]).destroy
    redirect_to action: 'index'
  end

  def update
    @role_allocation = RoleAllocation.find(update_params[:id])
    @role_allocation.is_active = !@role_allocation.is_active
    @role_allocation.save
    redirect_to action: 'index'
  end

  private

  def update_params
    params.permit(:id)
  end

  def create_params
    params.require(:role_allocation).permit(:member_id, :role_type_id)
  end
end

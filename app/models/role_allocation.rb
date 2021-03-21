# frozen_string_literal: true

# This model is used to store all the role allocations stored in the database.
# Basically, each allocation is a pair of a member and the role which has been
# assigned to the user. Note that a user can have multiple roles at the same
# time.
class RoleAllocation < ApplicationRecord
  belongs_to :member
  belongs_to :role_type

  validates :member_id, presence: true
  validates :role_type_id, presence: true

  # Assign the admin role to user
  #
  # @param user [Member] Member to me promoted to admin
  # @return [RoleAllocation, nil] The RoleAllocation if all OK, false if not.
  def promote_to_admin!(user)
    self.role_type_id = 1
    self.member_id = user.id
    self.is_active = true
    save
  end

  # Assign a role to user
  #
  # @param params [hash] Params 
  # @opts params [Integer] :role_type_id  The id of the role_type to assign
  # @opts params [String] :member_id The UUID of the user
  # @return [RoleAllocation, nil] The RoleAllocation if all OK, false if not.
  def promote_to(params)
    self.role_type_id = params[:role_type_id]
    self.member_id = params[:member_id]
    self.is_active = true
    save
  end
end

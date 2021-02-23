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

  def promote_to_admin!(user)
    self.role_type_id = 1
    self.member_id = user.id
    self.is_active = true
    save
  end

  def promote_to(params)
    self.role_type_id = params[:role_type_id]
    self.member_id = params[:member_id]
    self.is_active = true
    save
  end
end

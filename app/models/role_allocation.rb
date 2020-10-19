# frozen_string_literal: true

# This model is used to store all the role allocations stored in the database.
# Basically, each allocation is a pair of a member and the role which has been assigned to the user. Note that a user can have multiple roles at the same time.
class RoleAllocation < ApplicationRecord
  belongs_to :member
  belongs_to :role_type

  validates :member_id, presence: true
  validates :role_type_id, presence: true
end

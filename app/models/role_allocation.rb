# frozen_string_literal: true

class RoleAllocation < ApplicationRecord
  belongs_to :member
  belongs_to :role_type

  validates :member_id, presence: true
  validates :role_type_id, presence: true
end

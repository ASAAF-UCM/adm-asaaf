# frozen_string_literal: true

class RoleAllocation < ApplicationRecord
  belongs_to :member
  belongs_to :role_type
end

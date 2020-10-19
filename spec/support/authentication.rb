# frozen_string_literal: true

module Helpers
  module Authentication
    def sign_in_as_user
      member = FactoryBot.create(:random_member)
      sign_in member
      member.confirm
    end

    def sign_in_as_admin
      member = FactoryBot.create(:random_member)
      sign_in member
      member.confirm
      role_alloc = RoleAllocation.new
      role_alloc.role_type_id = 1
      role_alloc.member_id = member.id
      role_alloc.is_active = true
      role_alloc.save
    end
  end
end

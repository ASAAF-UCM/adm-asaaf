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
      ra = RoleAllocation.new
      ra.promote_to_admin! member
    end
  end
end

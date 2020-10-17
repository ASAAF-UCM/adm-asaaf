# frozen_string_literal: true

class MemberController < ApplicationController
  before_action :authenticate_member!

  def showprofile
    @member = current_member
  end
end

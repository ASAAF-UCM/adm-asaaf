# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Roles', type: :request do
  context 'when not signed in' do
    it '/es/role redirects to sign_in page' do
      get '/es/role'
      expect(response).to redirect_to '/es/members/sign_in'
    end
  end

  context 'when signed in' do
    it '/es/role redirects to home if user is not admin' do
      sign_in_as_user
      get '/es/role'
      expect(response).to redirect_to :root
    end

    it '/es/role shows roles when user is admin' do
      sign_in_as_admin
      get '/es/role'
      expect(response).to render_template 'role/index'
    end
  end
end

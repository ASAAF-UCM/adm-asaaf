# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MemberAdmins', type: :request do
  let(:member) { FactoryBot.create(:admin_member) }

  before { login_as member }

  describe 'GET index' do
    it 'returns http success' do
      get '/en/member_admin/'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/en/member_admin/#{member.id}"
      expect(response).to have_http_status(:success)
    end
  end
end

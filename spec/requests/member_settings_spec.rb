# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MemberSettings', type: :request do
  let(:member) { FactoryBot.create(:random_member) }

  describe 'when not logged' do
    it 'redirects to sign_in page' do
      get settings_path
      expect(response).to redirect_to new_member_session_path
    end
  end

  describe 'when logged' do
    before { login_as member }

    it 'returns http success' do
      get settings_path
      expect(response).to have_http_status :success
    end
  end
end

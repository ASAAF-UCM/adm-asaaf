# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MemberAdmins', type: :feature do
  describe 'when not logged' do
    it 'redirects to sign_in page' do
      visit member_admin_index_path
      expect(page).to have_current_path(new_member_session_path)
    end
  end

  describe 'when logged and not having assigned roles admin, accounting or secretary' do
    # FIXME: Route shouldn't be hardcoded, but /?locale=en is not equal to /en
    it 'redirects to root page' do
      login_as(FactoryBot.create(:random_member))
      visit member_admin_index_path
      expect(page).to have_current_path('/en')
    end
  end

  describe 'when logged and being role admin' do
    it 'shows index' do
      login_as(FactoryBot.create(:admin_member))
      visit member_admin_index_path
      expect(page).to have_current_path(member_admin_index_path)
    end
  end

  describe 'when logged and being role secretary' do
    it 'shows index' do
      login_as(FactoryBot.create(:secretary_member))
      visit member_admin_index_path
      expect(page).to have_current_path(member_admin_index_path)
    end
  end

  describe 'when logged and being role accounting' do
    it 'shows index' do
      login_as(FactoryBot.create(:accounting_member))
      visit member_admin_index_path
      expect(page).to have_current_path(member_admin_index_path)
    end
  end

  describe 'when logged and being role loan' do
    it 'shows index' do
      login_as(FactoryBot.create(:loan_member))
      visit member_admin_index_path
      expect(page).to have_current_path(member_admin_index_path)
    end
  end
end

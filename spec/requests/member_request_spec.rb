# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MemberController', type: :request do
  it 'renders sign_in form if not signed in' do
    get '/es/profile'
    expect(response).to redirect_to '/es/members/sign_in'
  end

  it 'renders the profile if signed in' do
    sign_in_as_user
    get '/es/profile'
    expect(response).to render_template('profile/index')
  end
end

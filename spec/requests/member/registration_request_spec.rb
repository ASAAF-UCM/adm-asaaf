# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Member::RegistrationsController', type: :request do
  context 'when GET index' do
    it 'renders the registration template' do
      get '/es/members/new'
      expect(response).to render_template('devise/registrations/new')
    end
  end
end

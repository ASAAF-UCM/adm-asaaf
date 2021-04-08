# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Error page', type: :request do
  it 'page not found responds 404' do
    get '/es/404'
    expect(response.status).to eq(404)
  end

  it 'internal error server responds 500' do
    get '/es/500'
    expect(response.status).to eq(500)
  end
end

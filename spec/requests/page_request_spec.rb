# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Page controller', type: :request do
  it 'renderizes the home page in Spanish' do
    get '/es'
    expect(response.status).to eq(200)
  end

  it 'renderizes the home page in English' do
    get '/en'
    expect(response.status).to eq(200)
  end
end

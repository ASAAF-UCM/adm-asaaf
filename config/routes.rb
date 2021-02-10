# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    get '/:locale' => 'page#home'
    devise_for :members, skip: [:registrations]
    as :member do
      get 'members/new' => 'devise/registrations#new', :as => 'new_member_registration'
      post 'members' => 'devise/registrations#create', :as => 'member_registration'
    end

    scope :profile do
      get '', to: 'profile#index', as: :profile
      get 'password/edit', to: 'profile#edit_password', as: :profile_password
      put 'password/edit', to: 'profile#update_password'
    end

    resources :member_administration

    resources :role, only: %i[index new create destroy update]
  end

  root to: 'page#detect_locale'
end

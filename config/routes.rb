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

    resources :member_admin

    scope :member_admin do
      post 'confirm_email', to: 'member_admin#confirm_email'
      post 'send_reset_password_instructions', to: 'member_admin#reset_email'
      post 'unlock_account', to: 'member_admin#unlock_account'
      post 'lock_account', to: 'member_admin#lock_account'
      post 'honorario', to: 'member_admin#honorario'
      post 'search', to: 'member_admin#member_search', as: 'member_search'
      post 'convert_into', to: 'member_admin#convert_into_member', as: 'convert_into_member'
      post 'page', to: 'member_admin#member_page', as: 'page'
    end

    resources :role, only: %i[index new create destroy update]
  end

  root to: 'page#detect_locale'
end

# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    get '/:locale' => 'page#home'
    devise_for :members
  end

  root to: 'page#detect_locale'
end

# frozen_string_literal: true

class PageController < ApplicationController
  def home
    @home_page = true
  end

  def detect_locale
    languages = browser.accept_language.map(&:code)
    languages.map!(&:to_sym)

    if I18n.available_locales - languages == I18n.available_locales
      redirect_to("/#{languages.first}")
    else
      redirect_to "/#{I18n.default_locale}"
    end
  end
end

# frozen_string_literal: true

# Controller for managing static pages of the app
class PageController < ApplicationController
  def home
    @home_page = true
  end

  def detect_locale
    languages = browser.accept_language.map(&:code)
    languages.map!(&:to_sym)

    # Does we support any language in the ACCEPT-LANGUAGES header?
    if (I18n.available_locales - languages).empty? && languages.any?
      redirect_to("/#{languages.first}")
    else
      redirect_to "/#{I18n.default_locale}"
    end
  end
end

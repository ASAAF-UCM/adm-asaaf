# frozen_string_literal: true

class PageController < ApplicationController
  def home; end

  def detect_locale
    languages = browser.accept_language.map(&:code)
    languages.map!(&:to_sym)

    languages.each do |lan|
      if I18n.available_locales.include?(lan)
        redirect_to "/#{lan}"
      else
        redirect_to "/#{I18n.default_locale}"
      end
    end
  end
end

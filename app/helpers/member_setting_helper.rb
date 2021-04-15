# frozen_string_literal: true

module MemberSettingHelper
  def language_of(locale)
    I18n.with_locale locale do
      return I18n.t locale
    end
  end
end

# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  helper MailerHelper

  def subject_for(key)
    t "views.devise.mailer.#{key}.subject"
  end
end

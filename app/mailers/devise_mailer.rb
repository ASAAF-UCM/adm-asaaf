# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  helper MailerHelper
  layout 'mailer'

  before_action :add_inline_attachment!

  def subject_for(key)
    t "views.devise.mailer.#{key}.subject"
  end

  def add_inline_attachment!
    attachments.inline['logo.png'] =
      File.read Rails.root.join('app/javascript/images/logo_asaaf.png')
  end
end

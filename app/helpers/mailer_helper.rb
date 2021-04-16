# frozen_string_literal: true

module MailerHelper
  def email_changed(resource)
    resource.try(:unconfirmed_email?) ? resource.unconfirmed_email : resource.email
  end
end

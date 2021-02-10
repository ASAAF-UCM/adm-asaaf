# frozen_string_literal: true

module FlashHelper
  def bootstrap_alert(key)
    case key
    when 'alert'
      'warning'
    when 'warning'
      'warning'
    when 'notice'
      'success'
    when 'success'
      'success'
    when 'error'
      'danger'
    when 'danger'
      'danger'
    end
  end
end

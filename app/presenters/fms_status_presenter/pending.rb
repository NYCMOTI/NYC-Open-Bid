class FmsStatusPresenter::Pending < FmsStatusPresenter::Base
  def flash_type
    :warning
  end

  def status_class
    'pending'
  end

  def admin_status_text
    'Pending'
  end

  def status_text
    'Verifying'
  end

  def message
    "You may continue to bid while your FMS number is being verified. (It usually takes less than one hour). <a href=\"/\">Click here to view the open opportunties</a>"
  end
end

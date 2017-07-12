class FmsStatusPresenter::Accepted < FmsStatusPresenter::Base
  def flash_type
    :success
  end

  def status_class
    'verified'
  end

  def status_text
    'Verified'
  end

  def message
    "Your FMS Vendor Number has been verified in NYC Checkbook.gov"
  end
end

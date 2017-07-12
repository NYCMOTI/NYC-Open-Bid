class FmsStatusPresenter::Rejected < FmsStatusPresenter::Base
  def flash_type
    :error
  end

  def status_class
    'error'
  end

  def status_text
    'Valid (inactive) '
  end

  def admin_status_text
    'Rejected'
  end

  def message
    "Your FMS Vendor Number is valid but seems to be inactive. Please visit the City’s <a href='https://a127-pip.nyc.gov/webapp/PRDPCW/SelfService'>Payee Information Portal</a> to reactivate your status. <a href='http://www1.nyc.gov/site/forward/contact/contact.page'>Contact us</a> if you need any help."
  end
end

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
    "Your FMS Vendor Number is valid but does not seem to be active. Please visit the city’s <a href='https://a127-pip.nyc.gov/webapp/PRDPCW/SelfService'>Payee Information Portal (PIP)</a> to reactivate your status. If you need any help <a href='http://www1.nyc.gov/site/forward/contact/contact.page'>contact us</a>."
  end
end

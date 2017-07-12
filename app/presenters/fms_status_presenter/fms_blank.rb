class FmsStatusPresenter::FmsBlank < FmsStatusPresenter::Base
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  def flash_type
    :warning
  end

  def admin_status_text
    'Needs FMS'
  end

  def message
    "In order to bid, you must supply a valid FMS Vendor Number. Please update
    #{link_to 'your profile', profile_path}"
  end
end

class EditUserViewModel
  def initialize(user)
    @user = user
  end

  def sam_status_icon_class
    "#{sam_status_class}-verification-status-icon"
  end

  def sam_status_text_class
    "#{sam_status_class}-verification-status-text"
  end

  def sam_status_text
    sam_status_presenter.status_text
  end

  def fms_status
    return fms_status_class
  end

  def fms_status_icon_class
    "#{fms_status_class}-verification-status-icon"
  end

  def fms_status_text_class
    "#{fms_status_class}-verification-status-text"
  end

  def fms_status_text
    fms_status_presenter.status_text
  end

  def is_mwbe
    return @user.is_mwbe
  end

  def record
    user
  end

  def subnav_view_model
    AccountSubnavViewModel.new(current_user: @user, active_tab: :profile)
  end

  def sam_status_message_for(flash)
    @user.decorate.sam_status_message_for(flash)
  end

  def fms_status_message_for(flash)
    @user.decorate.fms_status_message_for(flash)
  end

  private

  attr_reader :user

  def sam_status_class
    sam_status_presenter.status_class
  end

  def sam_status_presenter
    SamStatusPresenterFactory.new(user).create
  end

  def fms_status_class
    fms_status_presenter.status_class
  end

  def fms_status_presenter
    FmsStatusPresenterFactory.new(user).create
  end

end

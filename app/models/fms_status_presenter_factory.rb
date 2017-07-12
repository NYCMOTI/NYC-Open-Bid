class FmsStatusPresenterFactory
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def create
    Object.const_get("FmsStatusPresenter::#{fms_status.camelize}").new
  end

  private

  def fms_status
    if user.fms_status == "fms_blank"
      user.fms_status
    else
      user.fms_status.gsub('fms_', '')
    end
  end
end

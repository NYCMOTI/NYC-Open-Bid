class Admin::UserShowViewModel < Admin::BaseViewModel
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def data
    [
      { label: 'Email', data: user.email },
      { label: 'Payment URL', data: user.payment_url },
      { label: 'FMS number', data: user.fms_number },
      { label: 'GitHub username', data: user.github_login },
      { label: 'GitHub ID', data: user.github_id },
      { label: 'FMS Status', data: user.fms_status },
      { label: 'M/WBE', data: user.is_mwbe },
      #{ label: 'Small business', data: small_business },
      { label: 'Contracting officer', data: contracting_officer }
    ]
  end

  def name
    user.name
  end

  def bids_partial
    if bids?
      'bid_history'
    else
      'components/null'
    end
  end

  def user_auctions
    AuctionQuery.new.with_bid_from_user(user.id).map do |auction|
      Admin::UserAuctionViewModel.new(auction, user)
    end
  end

  private

  def bids?
    user_auctions.count.positive?
  end

  def sam_status
    SamStatusPresenterFactory.new(user).create.admin_status_text
  end

  def fms_status
    FmsStatusPresenterFactory.new(user).create.admin_status_text
  end

  def small_business
    BooleanPresenter.new(user.small_business?).to_s
  end

  def contracting_officer
    BooleanPresenter.new(user.contracting_officer?).to_s
  end
end

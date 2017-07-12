class BidStatusPresenter::Over::Vendor::Winner::WorkNotStarted < BidStatusPresenter::Base
  def header
    "Open Completed"
    #I18n.t('statuses.bid_status_presenter.over.winner.work_not_started.header')
  end

  def body
    "The Open Call has completed. Thank you for your interest in participating in this project. The agency will reach out for more information."
  end

  def action_partial
    'auctions/delivery_url'
  end
end

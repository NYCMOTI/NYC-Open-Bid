class BidStatusPresenter::Available::Vendor::Eligible < BidStatusPresenter::Base
  def body
    if auction.type == 'open_call'
      'If you\'re interested in learning more about this Open Call, register your interest by clicking the button below...'
    else
      I18n.t(
          'statuses.bid_status_presenter.available.vendor.eligible.body',
          max_allowed_bid_as_currency: max_allowed_bid_as_currency
      )
    end
  end

  def action_partial
    if auction.type == 'open_call'
      'auctions/inquire_form'
    else
      'auctions/bid_form'
    end
  end
end

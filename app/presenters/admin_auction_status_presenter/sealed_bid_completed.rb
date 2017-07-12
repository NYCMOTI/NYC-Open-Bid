class AdminAuctionStatusPresenter::SealedBidCompleted < AdminAuctionStatusPresenter::Base
  def header
    'Sealed Bid Completed'
  end

  def body
    'Please view the Bids tab to review the vendors who bid on this opportunity.'
  end

  private


end

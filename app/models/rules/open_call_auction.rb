class Rules::OpenCallAuction < Rules::BaseRules
  def winning_bid
    auction.lowest_bid || NullBid.new
  end

  def highlighted_bid(_user)
    winning_bid
  end

  def veiled_bids(_user)
    auction.bids.order(created_at: :desc)
  end

  def max_allowed_bid
    # irrelevant for open call
    1
  end

  def show_bids?
    true
  end

  def rules_label
    'Open Call'
  end

  def rules_route
    'auctions_rules_open_call'
  end
end

class BiddingStatusPresenter::Available < BiddingStatusPresenter::Base
  def start_label
    if auction.type == 'open_call'
      "Post Start Time"
    elsif
      "Bid Start Time"
    end
  end

  def deadline_label
    if auction.type == 'open_call'
      "Post End Date"
    elsif
      "Bid deadline"
    end
  end

  def relative_time
    I18n.t('bidding_status.available.relative_time',
           time: DcTimePresenter.new(auction.ended_at).relative_time)
  end

  def label_class
    'open'
  end

  def label
    I18n.t('bidding_status.available.label')
  end

  def bid_label(user)
    bid = highlighted_bid(user)
    amount = Currency.new(bid.amount)

    if bid.is_a?(NullBid)
      I18n.t('bidding_status.available.bid_label.no_bids')
    elsif auction.type == 'sealed_bid'
      I18n.t('bidding_status.available.bid_label.sealed_bid',
             amount: amount)
    elsif auction.type == 'open_call'
      "You registered interest in this Open Call"
    elsif auction.type == 'reverse' && bid.bidder == user
      I18n.t('bidding_status.available.bid_label.reverse.vendor_winning',
             amount: amount)
    else
      bidder_name = bid.bidder.name || bid.bidder.github_login
      I18n.t('bidding_status.available.bid_label.reverse.default',
             amount: amount,
             bidder_name: bidder_name)
    end
  end

  def tag_data_value_status
    "#{HumanTime.new(time: auction.ended_at).distance_of_time_to_now} left"
  end

  def tag_data_label_2
    I18n.t('bidding_status.available.tag_data_label_2')
  end

  def tag_data_value_2
    if auction.type == 'sealed_bid'
      "Sealed"
    else
      "#{winning_bid_amount_as_currency} - #{auction.bids.length} bids"
    end
  end

  private

  def rules
    @_rules ||= RulesFactory.new(auction).create
  end

  def highlighted_bid(user)
    rules.highlighted_bid(user)
  end

  def winning_bid_amount_as_currency
    Currency.new(rules.winning_bid.amount)
  end
end

class BidListItem
  attr_reader :bid, :user

  def initialize(bid:, user:)
    @bid = bid
    @user = user
  end

  def veiled_name
    if auction_available? && bidder_not_user?
      '[Name withheld until the auction ends]'
    else
      bid.bidder.name
    end
  end

  def veiled_name_mwbe_bolded
    if auction_available? && bidder_not_user?
      if bid.bidder.is_mwbe
        '[Name withheld until the auction ends]*'
      else
        '[Name withheld until the auction ends]*'
      end
    else
      if bid.bidder.is_mwbe
        bid.bidder.name + '*'
      else
        bid.bidder.name
      end
    end
  end

  def veiled_fms_number
    if auction_available? && bidder_not_user?
      '[Withheld]'
    else
      bid.bidder.fms_number
    end
  end

  def veiled_duns_number
    if auction_available? && bidder_not_user?
      '[Withheld]'
    else
      bid.bidder.duns_number
    end
  end

  def amount_to_currency_with_asterisk
    if bid == bid.auction.lowest_bid
      "#{amount_to_currency} *"
    else
      amount_to_currency
    end
  end

  def created_at
    DcTimePresenter.convert_and_format(bid.created_at)
  end

  private

  def amount_to_currency
    Currency.new(bid.amount).to_s
  end

  def auction_available?
    BiddingStatus.new(bid.auction).available?
  end

  def bidder_not_user?
    bid.bidder != user
  end
end

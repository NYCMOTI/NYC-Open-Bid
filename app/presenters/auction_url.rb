class AuctionUrl
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper
  Rails.application.routes.default_url_options[:host] = ENV['ROOT_URL']
  attr_reader :auction

  def initialize(auction:)
    @auction = auction
  end

  def to_s
    auction_url(auction)
  end
end

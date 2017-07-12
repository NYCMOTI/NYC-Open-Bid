class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to  :bidder, class_name: 'User'

  validates :amount, presence: true
  validates :auction, presence: true
  validates :bidder, presence: true

  def self.default_scope
    joins(:bidder).order('users.is_mwbe DESC')
  end

  def bidder_mwbe
    bidder.is_mwbe
  end

  def bidder_name
    bidder.name
  end

  def decorated_bidder
    UserPresenter.new(bidder)
  end

    # class << self
  #   def featured
  #     where(featured: true).limit(3)
  #   end
  # end
end

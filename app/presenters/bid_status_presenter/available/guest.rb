class BidStatusPresenter::Available::Guest < BidStatusPresenter::Base
  def body
    if auction.type == 'open_call'
      I18n.t(
          'statuses.bid_status_presenter.available.guest.open_call_body',
          end_date: end_date,
          sign_in_link: sign_in_link,
          sign_up_link: sign_up_link
      )    else
    I18n.t(
      'statuses.bid_status_presenter.available.guest.body',
      end_date: end_date,
      sign_in_link: sign_in_link,
      sign_up_link: sign_up_link
    )
    end
  end
end

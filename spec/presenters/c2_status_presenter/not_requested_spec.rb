require 'rails_helper'

describe C2StatusPresenter::NotRequested do
  describe '#body' do
    it 'returns the body for approval not requested' do
      auction = create(:auction)
      presenter = C2StatusPresenter::NotRequested.new(auction: auction)

      expect(presenter.body)
        .to eq(I18n.t('statuses.c2_presenter.not_requested.body'))
    end
  end

  describe '#header' do
    it 'returns the header for approval not requested' do
      auction = create(:auction)
      presenter = C2StatusPresenter::NotRequested.new(auction: auction)

      expect(presenter.header)
        .to eq(I18n.t('statuses.c2_presenter.not_requested.header'))
    end
  end
end

require 'rails_helper'

RSpec.describe SummaryPresenter, type: :presenter do
  let(:escort) { create(:escort) }
  subject { described_class.new(escort) }

  its(:prisoner) { is_expected.to be_kind_of PrisonerPresenter }

  its(:move) { is_expected.to be_kind_of MovePresenter }
end

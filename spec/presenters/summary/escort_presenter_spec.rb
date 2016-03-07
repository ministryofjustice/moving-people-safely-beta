require 'rails_helper'

RSpec.describe Summary::EscortPresenter, type: :presenter do
  let(:escort) { create(:escort) }
  subject { described_class.new(escort) }

  its(:prisoner) { is_expected.to be_kind_of Summary::PrisonerPresenter }

  its(:move) { is_expected.to be_kind_of Summary::MovePresenter }
end

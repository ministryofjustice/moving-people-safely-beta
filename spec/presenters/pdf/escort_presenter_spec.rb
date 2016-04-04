require 'rails_helper'

RSpec.describe Pdf::EscortPresenter, type: :presenter do
  let(:escort) { create(:escort) }
  subject { described_class.new(escort) }

  its(:not_for_release) {
    is_expected.to be_kind_of Pdf::NotForReleasePresenter
  }
  its(:front_page_markers) {
    is_expected.to be_kind_of Pdf::FrontPageMarkersPresenter
  }
  its(:prisoner)   { is_expected.to be_kind_of Pdf::PrisonerPresenter }
  its(:move)       { is_expected.to be_kind_of Pdf::MovePresenter }
  its(:risks)      { is_expected.to be_kind_of Pdf::RisksPresenter }
  its(:healthcare) { is_expected.to be_kind_of Pdf::HealthcarePresenter }
  its(:offences)   { is_expected.to be_kind_of Pdf::OffencesPresenter }
end

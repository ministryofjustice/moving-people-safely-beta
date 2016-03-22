require 'rails_helper'

RSpec.describe Pdf::OffencesPresenter, type: :presenter do
  let(:escort) { create(:escort) }
  let(:model) { escort.offence_information }

  subject { described_class.new(model) }

  it_behaves_like 'a presenter that delegates methods to the model',
    %i[ other_offences_details ]
end

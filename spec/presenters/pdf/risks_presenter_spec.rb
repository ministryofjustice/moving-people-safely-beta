require 'rails_helper'

RSpec.describe Pdf::RisksPresenter, type: :presenter do
  let(:escort) { create(:escort) }
  let(:model) { escort.risks }

  subject { described_class.new(model) }

  it_behaves_like 'a presenter that delegates methods to the model',
    %i[ to_self_details violence_details from_others_details escape_details
        intolerant_behaviour_details prohibited_items_details
        non_association_details ]
end

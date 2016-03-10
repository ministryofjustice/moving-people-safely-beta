require 'rails_helper'

RSpec.describe Pdf::RisksPresenter, type: :presenter do
  let(:escort) { create(:escort) }
  let(:risks) { escort.risk_information }

  subject { described_class.new(risks) }

  %i[ to_self_details violence_details from_others_details escape_details
      intolerant_behaviour_details prohibited_items_details
      non_association_details ].each do |method|
    it "delegates #{method} to the move model" do
      expect(risks).to receive(method)
      subject.public_send(method)
    end
  end
end

require 'rails_helper'

RSpec.describe Pdf::MovePresenter, type: :presenter do
  let(:escort) { create(:escort) }
  let(:move) { escort.move }

  subject { described_class.new(move) }

  %i[ origin destination reason ].each do |method|
    it "delegates #{method} to the move model" do
      expect(move).to receive(method)
      subject.public_send(method)
    end
  end

  %i[ day month year ].each do |method|
    it do
      is_expected.to delegate_method(method).to(:date_of_travel).with_prefix
    end
  end
end

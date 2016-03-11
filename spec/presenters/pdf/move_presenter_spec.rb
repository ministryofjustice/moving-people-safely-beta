require 'rails_helper'

RSpec.describe Pdf::MovePresenter, type: :presenter do
  let(:escort) { create(:escort) }
  let(:model) { escort.move }

  subject { described_class.new(model) }

  it_behaves_like 'a presenter that delegates methods to the model',
    %i[ origin destination reason ]

  %i[ day month year ].each do |method|
    it do
      is_expected.to delegate_method(method).to(:date_of_travel).with_prefix
    end
  end
end

require 'rails_helper'

RSpec.describe Summary::MovePresenter, type: :presenter do
  let(:escort) { create(:escort) }
  let(:model) { escort.move }

  subject { described_class.new(model) }

  describe '#edit_section_link' do
    it 'returns a path to the move form page' do
      expected_link_path = "/escort/#{escort.id}/move"
      expect(subject.edit_section_path).to eq expected_link_path
    end
  end

  it_behaves_like 'a presenter that delegates methods to the model',
    %i[ origin destination reason ]

  describe '#formatted_date_of_travel' do
    context 'when date_of_travel is present' do
      it 'returns a date in the format DD/MM/YYYY' do
        model.date_of_travel = Date.civil(2016, 10, 23)
        expect(subject.formatted_date_of_travel).to eq '23/10/2016'
      end
    end

    context 'when date_of_travel is not present' do
      it 'returns nil' do
        model.date_of_travel = nil
        expect(subject.formatted_date_of_travel).to be_nil
      end
    end
  end
end

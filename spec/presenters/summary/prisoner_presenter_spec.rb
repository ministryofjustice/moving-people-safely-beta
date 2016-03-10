require 'rails_helper'

RSpec.describe Summary::PrisonerPresenter, type: :presenter do
  let(:escort) { create(:escort) }
  let(:model) { escort.prisoner }

  subject { described_class.new(model) }

  describe '#edit_section_link' do
    it 'returns a path to the prisoner information form page' do
      expected_link_path = "/escort/#{escort.id}/prisoner-information"
      expect(subject.edit_section_path).to eq expected_link_path
    end
  end

  it_behaves_like 'a presenter that delegates methods to the model',
    %i[ family_name forenames prison_number nationality capitalized_sex
        formatted_date_of_birth age cro_number pnc_number ]
end

require 'rails_helper'

RSpec.describe PrisonerInformationPresenter, type: :presenter do
  let(:escort) { create(:escort) }
  subject { described_class.new(escort.prisoner) }

  describe '#edit_section_link' do
    it 'returns a path to the identification form page' do
      expected_link_path = "/escort/#{escort.id}/identification"
      expect(subject.edit_section_path).to eq expected_link_path
    end
  end

  %i[ family_name forenames prison_number nationality capitalized_sex
      formatted_date_of_birth age cro_number pnc_number ].each do |method|
    it "delegates #{method} to the prisoner model" do
      expect(escort.prisoner).to receive(method)
      subject.public_send(method)
    end
  end
end

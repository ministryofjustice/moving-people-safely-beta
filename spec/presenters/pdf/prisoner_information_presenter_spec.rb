require 'rails_helper'

RSpec.describe Pdf::PrisonerInformationPresenter, type: :presenter do
  let(:escort) { create(:escort) }
  subject { described_class.new(escort) }

  %i[ family_name forenames prison_number nationality capitalized_sex
      date_of_birth age cro_number pnc_number ].each do |method|
    it { is_expected.to delegate_method(method).to(:prisoner) }
  end

  %i[ day month year ].each do |method|
    it { is_expected.to delegate_method(method).to(:date_of_birth).with_prefix }
  end
end

require 'rails_helper'

RSpec.describe Pdf::PrisonerPresenter, type: :presenter do
  let(:model) { build_stubbed(:prisoner) }
  subject { described_class.new(model) }

  it_behaves_like 'a presenter that delegates methods to the model',
    %i[ prison_number
        family_name
        forenames
        nationality
        capitalized_sex
        date_of_birth
        age
        cro_number
        pnc_number ]

  %i[ day month year ].each do |method|
    it { is_expected.to delegate_method(method).to(:date_of_birth).with_prefix }
  end
end

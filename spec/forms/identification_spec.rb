require 'rails_helper'

RSpec.describe Identification, type: :form do
  let(:escort) { create(:escort) }

  subject { described_class.new(escort) }

  input_attributes = {
    family_name: 'Patti',
    forenames: 'Smith',
    sex: 'female',
    nationality: 'American',
    date_of_birth: { day: '10', month: '2', year: '1977' },
    cro_number: 'SOMECRO',
    pnc_number: 'SOMEPNC'
  }

  coercion_overrides = { date_of_birth: Date.civil(1977, 2, 10) }

  it_behaves_like 'a form that syncs to a model',
    input_attributes, coercion_overrides
  it_behaves_like 'a form that retrives or builds its target', :prisoner
  it_behaves_like 'a form that knows what template to render', 'identification'
  it_behaves_like 'a form that belongs to an endpoint', 'identification'
  it_behaves_like 'a form with dates', %i[ date_of_birth ]

  it { is_expected.to validate_inclusion_of(:sex).in_array(%w[ male female ]) }

  describe '#prison_number' do
    it 'delegates prison number to the model' do
      expect(subject.prison_number).to eq escort.prisoner.prison_number
    end
  end
end

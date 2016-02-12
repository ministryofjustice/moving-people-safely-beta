require 'rails_helper'

RSpec.describe Identification, type: :form do
  let(:escort) { create(:escort) }

  subject { described_class.new(escort) }

  it_behaves_like 'a form that syncs to a model', family_name: 'Patti',
                                                  forenames: 'Smith',
                                                  sex: 'female',
                                                  prison_number: 'F7267DF',
                                                  nationality: 'American'

  it_behaves_like 'a form that retrives or builds its target', :prisoner
  it_behaves_like 'a form that knows what template to render', 'identification'
  it_behaves_like 'a form that belongs to an endpoint', 'identification'
  it_behaves_like 'a form with dates', %i[ date_of_birth ]

  it { is_expected.to validate_presence_of(:prison_number) }
  it { is_expected.to validate_inclusion_of(:sex).in_array(%w[ male female ]) }
end

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

  describe 'validations' do
    it { is_expected.to validate_presence_of(:prison_number) }

    describe 'sex' do
      context 'when present' do
        context 'and included in the list' do
          it 'is valid' do
            subject.sex = 'male'
            subject.valid?
            expect(subject.errors[:sex]).to be_empty
          end
        end

        context 'and not included in the list' do
          it 'is not valid' do
            subject.sex = 'camel'
            subject.valid?
            expect(subject.errors[:sex]).to_not be_empty
          end
        end
      end

      context 'when not present' do
        it 'is valid' do
          subject.sex = nil
          subject.valid?
          expect(subject.errors[:sex]).to be_empty
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Prisoner, type: :model do
  it_behaves_like 'an auditable record'
  it_behaves_like 'a record with a uuid as a primary key'
  it_behaves_like 'a record that updates the escort on save'

  subject { create(:prisoner) }

  its(:full_name) { is_expected.to eq 'Bigglesworth, Tarquin' }

  context 'when date_of_birth is present' do
    its(:formatted_date_of_birth) { is_expected.to eq '13/02/1972' }
  end

  context 'when date_of_birth is not present' do
    subject { create(:prisoner, date_of_birth: nil) }
    its(:formatted_date_of_birth) { is_expected.to be_nil }
  end

  context 'when sex is present' do
    its(:capitalized_sex) { is_expected.to eq 'M' }
  end

  context 'when sex is not present' do
    subject { create(:prisoner, sex: nil) }
    its(:capitalized_sex) { is_expected.to be_nil }
  end

  describe '#age' do
    context 'when date_of_birth is present' do
      it 'returns the age' do
        travel_to(Date.new(2015, 2, 3)) do
          expect(subject.age).to eq 42
        end
      end
    end

    context 'when date_of_birth is not present' do
      subject { create(:prisoner, date_of_birth: nil) }
      its(:age) { is_expected.to be_nil }
    end
  end
end

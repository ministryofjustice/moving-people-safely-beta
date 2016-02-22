require 'rails_helper'

RSpec.describe Prisoner, type: :model do
  it_behaves_like 'an auditable record'
  it_behaves_like 'a record with a uuid as a primary key'
  it_behaves_like 'a record that updates the escort on save'

  subject { create(:prisoner) }

  describe '#full_name' do
    it 'returns the full name' do
      expect(subject.full_name).to eq 'Bigglesworth, Tarquin'
    end
  end

  describe '#formatted_date_of_birth' do
    context 'when date_of_birth is present' do
      it 'returns date_of_birth as string' do
        expect(subject.formatted_date_of_birth).to eq '13/02/1972'
      end
    end

    context 'when date_of_birth is not present' do
      subject { create(:prisoner, date_of_birth: nil) }
      its(:date_of_birth) { is_expected.to be_nil }
    end
  end

  describe '#capitalized_sex' do
    context 'when sex is present' do
      it 'returns capitalized sex' do
        expect(subject.capitalized_sex).to eq 'M'
      end
    end

    context 'when sex is not present' do
      subject { create(:prisoner, sex: nil) }
      its(:sex) { is_expected.to be_nil }
    end
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

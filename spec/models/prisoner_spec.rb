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
    it 'returns date_of_birth as string' do
      expect(subject.formatted_date_of_birth).to eq '13/02/1972'
    end
  end
end

require 'rails_helper'

RSpec.describe CreateEscort, type: :form do
  subject { described_class.new(prison_number: 'A1234BC') }

  it_behaves_like 'a form with prison_number'

  context 'validations' do
    context 'prison_number' do
      context 'with not existing prison_number' do
        it { is_expected.to be_valid }
      end

      context 'with existing prison_number' do
        before do
          create(:escort, prisoner: build(:prisoner, prison_number: 'A1234BC'))
        end

        it { is_expected.to_not be_valid }
      end
    end
  end

  describe '#save' do
    it 'creates an escort with prisoner' do
      subject.save
      expect(subject.escort).to be_persisted
      expect(subject.escort.prisoner).to be_persisted
      expect(subject.escort.prisoner.prison_number).to eq 'A1234BC'
    end
  end
end

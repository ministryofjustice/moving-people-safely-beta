require 'rails_helper'

RSpec.describe Identification, type: :form do
  let(:escort) { create(:escort) }

  subject { described_class.new(escort) }

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

    describe 'date_of_birth features' do
      let(:invalid_dob_i18n_path) do
        'activemodel.errors.models.identification.' \
          'attributes.date_of_birth.invalid'
      end

      let(:invalid_dob_text) { I18n.t(invalid_dob_i18n_path) }

      before(:each) do
        subject.date_of_birth = date_of_birth
        subject.valid?
      end

      context 'genuine date values provided' do
        let(:date_of_birth) { { day: '29', month: '7', year: '1987' } }
        its(:date_of_birth) { is_expected.to eq Date.civil(1987, 7, 29) }
        its(:date_of_birth_presenter) { is_expected.to be_a Date }
        it 'is valid' do
          expect(subject.errors[:date_of_birth]).to be_empty
        end
      end

      context 'a nil date' do
        let(:date_of_birth) { nil }
        its(:date_of_birth) { is_expected.to be_nil }
        its(:date_of_birth_presenter) { is_expected.to be_a UncoercedDate }
        it 'is valid' do
          expect(subject.errors[:date_of_birth]).to be_empty
        end
      end

      context 'an "empty" date' do
        let(:date_of_birth) { { day: '', month: '', year: '' } }
        its(:date_of_birth) { is_expected.to be_nil }
        its(:date_of_birth_presenter) { is_expected.to be_a UncoercedDate }
        it 'is valid' do
          expect(subject.errors[:date_of_birth]).to be_empty
        end
      end

      context 'missing a value in the date hash' do
        let(:date_of_birth) { { day: '', month: '7', year: '1987' } }
        its(:date_of_birth) { is_expected.to eq date_of_birth }
        its(:date_of_birth_presenter) { is_expected.to be_a UncoercedDate }
        it 'is invalid' do
          expect(subject.errors[:date_of_birth]).to include invalid_dob_text
        end
      end

      context 'out of range date input' do
        let(:date_of_birth) { { day: '45', month: '7', year: '1987' } }
        its(:date_of_birth) { is_expected.to eq date_of_birth }
        its(:date_of_birth_presenter) { is_expected.to be_a UncoercedDate }
        it 'is invalid' do
          expect(subject.errors[:date_of_birth]).to include invalid_dob_text
        end
      end

      context 'less than 4 digit year input' do
        let(:date_of_birth) { { day: '29', month: '7', year: '19' } }
        its(:date_of_birth) { is_expected.to eq Date.civil(19, 7, 29) }
        its(:date_of_birth_presenter) { is_expected.to be_a Date }
        it 'is invalid' do
          expect(subject.errors[:date_of_birth]).to include invalid_dob_text
        end
      end
    end
  end

  describe '#target' do
    it 'returns the escort model' do
      expect(subject.target).to eq escort
    end
  end

  describe '#template' do
    it 'returns the name of the partial to render' do
      expect(subject.template).to eq 'identification'
    end
  end

  describe '#url' do
    it 'returns the url where the form is submitted to' do
      expect(subject.url).to eq "/escort/#{escort.id}/identification"
    end
  end
end

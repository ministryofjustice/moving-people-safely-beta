require 'rails_helper'

RSpec.describe Identification, type: :form do
  let(:escort) { create(:escort) }

  subject { described_class.new(escort) }

  describe 'validate' do
    it { is_expected.to validate_presence_of(:prison_number) }

    describe 'sex' do
      context 'when present' do
        context 'and included in the list' do
          before do
            subject.sex = 'male'
            subject.valid?
          end

          it 'is valid' do
            expect(subject.errors[:sex]).to be_empty
          end
        end

        context 'and not included in the list' do
          before do
            subject.sex = 'camel'
            subject.valid?
          end

          it 'is not valid' do
            expect(subject.errors[:sex]).to_not be_empty
          end
        end
      end

      context 'when not present' do
        before do
          subject.sex = nil
          subject.valid?
        end

        it 'is valid' do
          expect(subject.errors[:sex]).to be_empty
        end
      end
    end

    describe 'date_of_birth' do
      context 'with no date_of_birth' do
        before do
          subject.valid?
        end

        specify 'there are no date errors on date_of_birth' do
          expect(subject.errors[:date_of_birth]).to be_empty
        end
      end

      context "with a 'blank' date_of_birth" do
        before do
          subject.date_of_birth = { day: '', month: '', year: '' }
          subject.valid?
        end

        specify 'there are no date errors on date_of_birth' do
          expect(subject.errors[:date_of_birth]).to be_empty
        end
      end

      context 'handling invalid dates' do
        let(:model_translation) do
          'activemodel.errors.models.escort.attributes.date_of_birth.invalid'
        end

        context 'with a non-numeric date_of_birth' do
          before do
            subject.date_of_birth = { day: 'foo', month: 'bar', year: 'baz' }
            subject.valid?
          end

          it 'adds a validation error to date_of_birth' do
            # expect(subject.errors[:date_of_birth]).
            #   to include I18n.t(model_translation)
            expect(subject.errors[:date_of_birth]).to_not be_empty
          end
        end

        context 'with a numeric date with out of bounds segments' do
          before do
            subject.date_of_birth = { day: '67', month: '82', year: '3095' }
            subject.valid?
          end

          it 'adds a validation error to date_of_birth' do
            # expect(subject.errors[:date_of_birth]).
            #   to include I18n.t(model_translation)
            expect(subject.errors[:date_of_birth]).to_not be_empty
          end
        end

        context 'with a year with less than 4 digits' do
          before do
            subject.date_of_birth = { day: '1', month: '5', year: '17' }
            subject.valid?
          end

          it 'adds a validation error to date_of_birth' do
            # expect(subject.errors[:date_of_birth]).
            #   to include I18n.t(model_translation)
            expect(subject.errors[:date_of_birth]).to_not be_empty
          end
        end
      end
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

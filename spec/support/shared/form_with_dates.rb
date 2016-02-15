RSpec.shared_examples 'a form with dates' do |date_fields|
  let(:escort) { create(:escort) }
  subject { described_class.new(escort) }

  date_fields.each do |date_field|
    describe "#{date_field} features" do
      let(:invalid_date_i18n_path) do
        "activemodel.errors.models.#{subject.name}." \
          "attributes.#{date_field}.invalid"
      end

      let(:invalid_date_text) { I18n.t(invalid_date_i18n_path) }

      before(:each) do
        subject.send("#{date_field}=", date_value)
        subject.valid?
      end

      context 'genuine date values provided' do
        let(:date_value) { { day: '29', month: '7', year: '1987' } }
        its(date_field) { is_expected.to eq Date.civil(1987, 7, 29) }
        its("#{date_field}_presenter") { is_expected.to be_a Date }
        it 'is valid' do
          expect(subject.errors[date_field]).to be_empty
        end
      end

      context 'a nil date' do
        let(:date_value) { nil }
        its(date_field) { is_expected.to be_nil }
        its("#{date_field}_presenter") { is_expected.to be_a UncoercedDate }
        it 'is valid' do
          expect(subject.errors[date_field]).to be_empty
        end
      end

      context 'an "empty" date' do
        let(:date_value) { { day: '', month: '', year: '' } }
        its(date_field) { is_expected.to be_nil }
        its("#{date_field}_presenter") { is_expected.to be_a UncoercedDate }
        it 'is valid' do
          expect(subject.errors[date_field]).to be_empty
        end
      end

      context 'missing a value in the date hash' do
        let(:date_value) { { day: '', month: '7', year: '1987' } }
        its(date_field) { is_expected.to eq date_value }
        its("#{date_field}_presenter") { is_expected.to be_a UncoercedDate }
        it 'is invalid' do
          expect(subject.errors[date_field]).to include invalid_date_text
        end
      end

      context 'out of range date input' do
        let(:date_value) { { day: '45', month: '7', year: '1987' } }
        its(date_field) { is_expected.to eq date_value }
        its("#{date_field}_presenter") { is_expected.to be_a UncoercedDate }
        it 'is invalid' do
          expect(subject.errors[date_field]).to include invalid_date_text
        end
      end

      context 'less than 4 digit year input' do
        let(:date_value) { { day: '29', month: '7', year: '19' } }
        its(date_field) { is_expected.to eq Date.civil(19, 7, 29) }
        its("#{date_field}_presenter") { is_expected.to be_a Date }
        it 'is invalid' do
          expect(subject.errors[date_field]).to include invalid_date_text
        end
      end
    end
  end
end

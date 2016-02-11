RSpec.shared_examples 'a form with a text toggle attribute' do |attributes|
  let(:escort) { create(:escort) }
  subject { described_class.new(escort) }

  attributes.each do |attribute|
    {
      'false'   => false,
      'true'    => true,
      'unknown' => nil
    }.each do |radio_button_value, coerced_value|
      describe "#{attribute}=" do
        context "coercing #{radio_button_value}" do
          before { subject.public_send("#{attribute}=", radio_button_value) }
          its(attribute) { is_expected.to be coerced_value }
        end
      end
    end

    let(:user_text) { 'some user entered text' }

    describe "##{attribute}_details=" do
      context "when the boolean #{attribute} value is true" do
        it "sets #{attribute}_details" do
          subject.public_send("#{attribute}=", 'true')
          subject.public_send("#{attribute}_details=", user_text)
          expect(subject.public_send("#{attribute}_details")).to eq user_text
        end
      end

      context "when the boolean #{attribute} value is false" do
        it "does not set #{attribute}_details" do
          subject.public_send("#{attribute}=", 'false')
          subject.public_send("#{attribute}_details=", user_text)
          expect(subject.public_send("#{attribute}_details")).to be_nil
        end
      end

      context "when the boolean #{attribute} value is unknown" do
        it "does not set #{attribute}_details" do
          subject.public_send("#{attribute}=", 'unknown')
          subject.public_send("#{attribute}_details=", user_text)
          expect(subject.public_send("#{attribute}_details")).to be_nil
        end
      end
    end
  end
end

RSpec.shared_examples 'a form that knows what template to render' do |template_name|
  let(:escort) { create(:escort) }
  subject { described_class.new(escort) }

  describe '#template' do
    it "returns #{template_name}" do
      expect(subject.template).to eq template_name
    end
  end
end

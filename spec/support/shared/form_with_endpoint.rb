RSpec.shared_examples 'a form that belongs to an endpoint' do |form_name|
  let(:escort) { create(:escort) }
  subject { described_class.new(escort) }

  describe '#url' do
    it 'returns the url where the form is submitted to' do
      expect(subject.url).to eq "/escort/#{escort.id}/#{form_name}"
    end
  end
end

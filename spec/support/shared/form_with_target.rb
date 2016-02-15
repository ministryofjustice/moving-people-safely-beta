RSpec.shared_examples 'a form that retrives or builds its target' do |target_name|
  let(:escort) { create(:escort) }
  subject { described_class.new(escort) }

  describe '#target' do
    it "returns the #{target_name} model" do
      expect(subject.target).to eq escort.send(target_name)
    end
  end
end

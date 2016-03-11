RSpec.shared_examples 'a presenter that delegates methods to the model' do |methods|
  methods.each do |method|
    it "delegates #{method} to the model" do
      expect(model).to receive(method)
      subject.public_send(method)
    end
  end
end

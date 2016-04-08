require 'rails_helper'

RSpec.describe UncoercedDate, type: :form do
  methods = %i[ day month year ]

  context 'when provided a nil value' do
    subject { described_class.new(nil) }

    methods.each do |method_name|
      it "responds to #{method_name} returning nil" do
        expect(subject.public_send(method_name)).to be_nil
      end
    end
  end

  context 'when provided a date hash' do
    let(:date_hash) { { day: 'X', month: '2', year: '1980' } }
    subject { described_class.new(date_hash) }

    methods.each do |method_name|
      it "responds to #{method_name} with relevant value from the date hash" do
        expect(subject.public_send(method_name)).to eq date_hash[method_name]
      end
    end
  end
end

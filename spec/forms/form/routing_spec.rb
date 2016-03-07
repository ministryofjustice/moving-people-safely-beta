require 'rails_helper'

RSpec.describe Form::Routing, type: :form do
  describe '.resource_list' do
    it 'returns a list of objects that respond to name' do
      expect(described_class.resource_list.map(&:name)).
        to eq %i[ prisoner_information move_information risks ]
    end

    it 'returns a list of objects that respond to path' do
      expect(described_class.resource_list.map(&:path)).
        to eq %w[ prisoner-information move-information risks ]
    end
  end

  describe '.form_names' do
    it 'returns an array of symbolized form names' do
      expect(described_class.form_names).
        to eq %i[ prisoner_information move_information risks ]
    end
  end
end
require 'rails_helper'

RSpec.describe BackfillCollection, type: :service do
  describe '.call' do
    context 'when a collection and a filler are passed' do
      it 'returns an enumerator of the collection prepended with fillers' do
        collection = %w[ foo bar baz ]
        filler = 'lol'
        results = described_class.call(collection) { filler }

        expect(results.take(6)).to eq %w[ foo bar baz lol lol lol ]
      end
    end
  end
end

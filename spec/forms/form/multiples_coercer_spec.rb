require 'rails_helper'

RSpec.describe Form::MultiplesCoercer, type: :form do
  describe '.call' do
    # this is used when a form receives params from
    # the web request
    context 'when input is a Hash' do
      it 'returns the values' do
        input = { a: :b, c: :d }
        expect(described_class.call(input)).to eq %i[ b d ]
      end
    end

    # this is used when a form is initalised with a
    # collection of active record objects
    context 'when an array of active record objects is passed' do
      it 'returns a list of their attributes' do
        class_with_attributes = Class.new do
          def attributes
            { foo: :bar, baz: :lol }
          end
        end

        input = Array.new(2) { class_with_attributes.new }

        expect(described_class.call(input)).
          to match_array([{ foo: :bar, baz: :lol }, { foo: :bar, baz: :lol }])
      end
    end
  end
end

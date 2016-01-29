require 'rails_helper'

RSpec.describe Form, type: :form do
  let(:form_class) do
    Class.new(described_class) do
      attribute :foo, String
      attribute :bar, Integer
      attribute :baz, Axiom::Types::Boolean
    end
  end

  let(:model) do
    OpenStruct.new(foo: 'bar', bar: '1', baz: 'False').tap do |m|
      def m.update_attributes(*); end
    end
  end

  subject { form_class.new(model) }

  describe '#initialize' do
    it 'loads a models attributes' do
      expect(subject.foo).to eq 'bar'
    end
  end

  describe 'coercing attribute types' do
    context 'providing a type' do
      it 'converts a string to its specified type' do
        expect(subject.bar).to eq 1
        expect(subject.baz).to be false
      end
    end
  end

  describe '#assign_attributes' do
    it 'updates the attributes on the form' do
      new_attributes = { bar: '100', baz: 'True' }
      subject.assign_attributes(new_attributes)

      expect(subject.attributes).
        to include(bar: 100, baz: true)
    end
  end

  describe '#save' do
    let(:coerced_attributes) do
      { foo: 'bar', bar: 1, baz: false }
    end

    it 'passes the forms data to the underlying model(s)' do
      expect(model).
        to receive(:update_attributes).
        with coerced_attributes

      subject.save
    end

    context 'with validations' do
      let(:form_class) do
        Class.new(described_class) do
          attribute :foo, String
          validates :foo, presence: true

          def self.name
            # ActiveModel validations requires the
            # form to have a name. This method is
            # required asthis is an anonymous class.
            'ThisIsAnExampleFormClass'
          end
        end
      end

      context 'that pass' do
        let(:model) do
          double(
            'foo=' => nil,
            foo: 'bar',
            update_attributes: true
          )
        end

        it 'returns true' do
          expect(subject.save).to be true
        end

        it 'does not set any errors on the form' do
          expect(subject.errors).to be_empty
        end
      end

      context 'that fail' do
        let(:model) do
          double('foo=' => nil, foo: nil)
        end

        it 'returns false' do
          expect(subject.save).to be false
        end

        it 'sets errors on the form object' do
          subject.save
          expect(subject.errors).to_not be_empty
        end
      end
    end
  end
end

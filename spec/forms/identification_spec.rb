require 'rails_helper'

RSpec.describe Identification, type: :form do
  let(:escort) { Escort.new }

  subject { described_class.new(escort) }

  it { is_expected.to validate_presence_of(:prison_number) }

  describe '#target' do
    context 'with person set on escort' do
      let(:person) { Person.new }
      let(:escort) { Escort.new(person: person) }

      it 'sets the target to person' do
        expect(subject.target).to eq person
      end
    end

    context 'with person not set on escort' do
      it 'builds a new person' do
        person = subject.target
        expect(person).to be_kind_of(Person)
        expect(person.persisted?).to be false
      end
    end
  end

  describe '#date_of_birth' do
    let(:person) { Person.new(date_of_birth: date) }
    let(:escort) { Escort.new(person: person) }

    context 'when coercing to a date' do
      let(:date) { Date.parse('1/2/2016') }

      it 'returns a date' do
        expect(subject.date_of_birth).to eq date
      end
    end

    context 'when not coercing to a date' do
      let(:date) { { day: '', month: '', year: '' } }

      it 'returns nil' do
        expect(subject.date_of_birth).to eq nil
      end
    end
  end
end

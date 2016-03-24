require 'rails_helper'

RSpec.describe 'custom date formats', type: :config do
  around(:each) do |example|
    travel_to(Time.new(2016, 2, 3, 9, 30, 0)) { example.run }
  end

  describe 'Date formats' do
    subject { Date.today }

    describe 'day_month_year' do
      it 'returns a string in the format DD MM YYYY' do
        expect(subject.to_s(:day_month_year)).to eq '03 02 2016'
      end
    end

    describe 'slashed_day_month_year' do
      it 'returns a string in the format DD/MM/YYYY' do
        expect(subject.to_s(:slashed_day_month_year)).to eq '03/02/2016'
      end
    end
  end

  describe 'Time formats' do
    subject { Time.now }

    describe 'time_with_slashed_day_month_year' do
      it 'returns a string in the format HH:MM DD/MM/YYYY' do
        output =  subject.to_s(:time_with_slashed_day_month_year)
        expect(output).to eq '09:30 03/02/2016'
      end
    end
  end
end

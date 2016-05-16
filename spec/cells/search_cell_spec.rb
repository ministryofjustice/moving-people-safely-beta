require 'rails_helper'

RSpec.describe SearchCell, type: :cell do
  controller HomePagesController

  around(:each) do |example|
    travel_to(Date.new(2015, 2, 3)) { example.run }
  end

  it 'renders a search' do
    form = SearchPrisonerForm.new
    expect(cell(:search, form).call).to have_content 'Find a prisoner'
  end

  context 'with a valid prison number' do
    context 'when there are no results' do
      it 'shows a message with a button to initiate a new PER' do
        form = SearchPrisonerForm.new(prison_number: 'Z9876XY')
        expect(cell(:search, form).call).
          to have_content('There are no previously created PERs ' \
            'for prisoner number Z9876XY').
          and have_button('Initiate new PER')
      end
    end

    context 'when there are results' do
      it 'shows the result with the link to the escort' do
        create(:escort, :with_prisoner)
        form = SearchPrisonerForm.new(prison_number: 'A1234BC')
        cell = cell(:search, form)
        expect(cell.call).
          to have_link('A1234BC', href: summary_path(cell.escort)).
          and have_content('Bigglesworth, Tarquin 13/02/1972 00:00 03/02/2015')
      end
    end
  end

  context 'with an invalid prison number' do
    it 'shows an error message' do
      form = SearchPrisonerForm.new(prison_number: 'invalid')
      form.validate
      expect(cell(:search, form).call).
        to have_content 'Enter a valid prison number'
    end
  end
end

require 'rails_helper'

RSpec.feature 'Navigation' do
  let(:escort) { create(:escort) }

  context 'On the summary form' do
    before do
      visit summary_path(escort)
    end

    scenario 'identification is a link on the summary form' do
      expect(page).to have_link('Identification')
    end
  end

  context 'On the navigation form' do
    before :each do
      visit identification_path(escort)
    end

    scenario 'summary is a link on the identification form' do
      expect(page).to have_link('Summary')
    end

    scenario 'viewing an escort record identification form' do
      expect(page).to have_text('Primary navigation').
        and have_link('Summary').
        and have_no_link('Identification')
    end

    scenario 'Identification is not a link on the identification form' do
      expect(page).to have_no_link('Identification')
    end

    scenario 'Identification item has "current" class when form submitted' do
      fill_in('Prison number', with: 'A2345CD')
      click_button('Save')

      expect(page).to have_css('li.current', text: 'Identification')
    end
  end
end

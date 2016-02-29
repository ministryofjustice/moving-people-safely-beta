module FeatureHelpers
  module Forms
    def start_escort_form
      login
      fill_in_prison_number 'A1234BC'
      click_button 'Search'
      click_button 'Initiate new PER'
    end

    def fill_in_prison_number(prison_number)
      fill_in 'search_prisoner[prison_number]', with: prison_number
    end

    def click_save
      click_button 'Save'
    end

    def escort
      Escort.last
    end

    def user
      User.last
    end
  end
end

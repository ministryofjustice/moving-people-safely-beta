module FeatureHelpers
  module MoveInformationForm
    def fill_in_move_information
      attributes = attributes_for(:move)

      fill_in 'From', with: attributes[:origin]
      fill_in 'To', with: attributes[:destination]

      date = attributes[:date_of_travel]
      fill_in 'move_information[date_of_travel][day]', with: date.day
      fill_in 'move_information[date_of_travel][month]', with: date.month
      fill_in 'move_information[date_of_travel][year]', with: date.year

      fill_in 'Reason for move (current offence)', with: attributes[:reason]

      click_save
    end
  end
end

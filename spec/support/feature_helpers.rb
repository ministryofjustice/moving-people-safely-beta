module FeatureHelpers
  def start_escort_form
    visit '/'
    click_button 'Create new escort record'
  end

  def fill_in_identification(options = {})
    options = {
      prison_number: 'A1234BC',
      family_name: 'Bigglesworth',
      forenames: 'Tarquin',
      sex: 'Male',
      date_of_birth: Date.civil(1972, 2, 13),
      nationality: 'British'
    }.merge(options)

    fill_in 'Prison number', with: options.fetch(:prison_number)
    fill_in 'Family name', with: options.fetch(:family_name)
    fill_in 'Forenames', with: options.fetch(:forenames)
    choose options.fetch(:sex)
    fill_in 'identification[date_of_birth][day]',
      with: options.fetch(:date_of_birth)&.day
    fill_in 'identification[date_of_birth][month]',
      with: options.fetch(:date_of_birth)&.month
    fill_in 'identification[date_of_birth][year]',
      with: options.fetch(:date_of_birth)&.year
    fill_in 'Nationality', with: options.fetch(:nationality)
    click_button 'Save'
  end
end

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
    click_save
  end

  def fill_in_risks(options = {})
    options = build_risk_properties.merge(options)
    options.each do |key, (radio_value, textarea_value)|
      within(find('span', text: key).find(:xpath, '../..')) do
        choose radio_value
        find('textarea').set textarea_value
      end
    end
    click_save
  end

  def click_save
    click_button 'Save'
  end

  def build_risk_properties
    ['Risks to self', 'Risks to others', 'Violence', 'Risk from others',
     'Escort escape risk', 'Intolerant behavior', 'Prohibited items',
     'Disabilities', 'Allergies', 'Non-association'
    ].each_with_index.
      each_with_object({}) do |(r, i), o|
      o[r] = (i.odd? ? ['Yes', 'Some user input'] : ['No', nil])
    end
  end
end

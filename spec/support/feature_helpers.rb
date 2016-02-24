module FeatureHelpers
  def login
    email = 'person@prison.com'
    password = 'secret123'
    create_user(email, password)
    login_user(email, password)
  end

  def create_user(email, password)
    create(
      :user,
      email: email,
      password: password,
      password_confirmation: password
    )
  end

  def login_user(email, password)
    visit root_path
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    click_button 'Log in'
  end

  def start_escort_form
    login
    fill_in_prison_number 'A1234BC'
    click_button 'Search'
    click_button 'Initiate new PER'
  end

  def fill_in_identification(options = {})
    options = {
      family_name: 'Bigglesworth',
      forenames: 'Tarquin',
      sex: 'Male',
      date_of_birth: Date.civil(1972, 2, 13),
      nationality: 'British',
      cro_number: 'SOMECRO',
      pnc_number: 'SOMEPNC'
    }.merge(options)

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
    fill_in 'CRO number', with: options.fetch(:cro_number)
    fill_in 'PNC number', with: options.fetch(:pnc_number)

    click_save
  end

  def fill_in_prison_number(prison_number)
    fill_in 'search_prisoner[prison_number]', with: prison_number
  end

  def fill_in_risks(options = {})
    options = build_risk_properties.merge(options)
    options.each do |key, (radio_value, textarea_value)|
      fill_in_risk(key, radio_value, textarea_value)
    end
    click_save
  end

  def fill_in_risk(field, radio_value, textarea_value)
    within_risk(field) do
      choose radio_value
      find('textarea').set textarea_value
    end
  end

  def clear_risk(field)
    within_risk(field) { choose 'Clear selection' }
  end

  def within_risk(field, &_blk)
    within(find('span', text: field).find(:xpath, '../..')) { yield }
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

  def escort
    Escort.last
  end

  def user
    User.last
  end

  def last_escort_version
    escort.versions.last
  end

  def last_user_audited
    User.find(last_escort_version.whodunnit)
  end
end

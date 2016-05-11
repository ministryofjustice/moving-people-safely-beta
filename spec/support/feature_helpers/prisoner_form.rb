module FeatureHelpers
  module PrisonerForm
    def fill_in_prisoner(options = {})
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
      fill_in 'prisoner[date_of_birth][day]',
        with: options.fetch(:date_of_birth)&.day
      fill_in 'prisoner[date_of_birth][month]',
        with: options.fetch(:date_of_birth)&.month
      fill_in 'prisoner[date_of_birth][year]',
        with: options.fetch(:date_of_birth)&.year
      fill_in 'Nationality', with: options.fetch(:nationality)
      fill_in 'CRO number', with: options.fetch(:cro_number)
      fill_in 'PNC number', with: options.fetch(:pnc_number)

      within_prisoner_field('Does the detainee have any significant aliases') do
        choose 'Yes'
        fill_in 'prisoner[aliases][0]', with: 'Jack the Ripper'
      end

      click_save
    end

    def within_prisoner_field(field, &_blk)
      within(find('span', text: field).
        find(:xpath, '../..')) do
          yield
        end
    end
  end
end

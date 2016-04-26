module FeatureHelpers
  module OffencesForm
    def fill_in_offences(options = {})
      options = build_offences_properties.merge(options)
      options.each do |key, (radio_value, textarea_value)|
        fill_in_offences_field(key, radio_value, textarea_value)
      end
      fill_in 'offences[offence_details[0]][offence_type]',
        with: 'Bulgary'
      select 'Outstanding charge',
        from: 'offences[offence_details[0]][offence_status]'
      check 'offences[offence_details[0]][not_for_release]'
      check 'offences[offence_details[0]][current_offence]'

      click_save
    end

    def fill_in_offences_field(field, radio_value, textarea_value)
      within_offences_field(field) do
        choose radio_value
        find('textarea').set textarea_value
      end
    end

    def clear_offences_field(field)
      within_offences_field(field) { choose 'Clear selection' }
    end

    def build_offences_properties
      ['Not for release', 'Must return', 'Must not return'].each_with_index.
        each_with_object({}) do |(r, i), o|
        o[r] = (i.odd? ? ['Yes', 'Some user input'] : ['No', nil])
      end
    end

    def within_offences_field(field, &_blk)
      within(find('span', text: field).
        find(:xpath, '../..')) do
          yield
        end
    end

    def remove_offence_details
      check 'offences[offence_details[1]][_destroy]'
      click_save
      medication_0 =
        find_field('offences[offence_details[0]][offence_type]').value
      medication_1 =
        find_field('offences[offence_details[1]][offence_type]').value
      expect(medication_0).to eq 'Bulgary'
      expect(medication_1).to eq nil
    end
  end
end

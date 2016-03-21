module FeatureHelpers
  module OffencesForm
    def fill_in_offences(options = {})
      options = build_offences_properties.merge(options)
      options.each do |key, (radio_value, textarea_value)|
        fill_in_offences_field(key, radio_value, textarea_value)
      end
      check 'Does the prisoner require an MPV?'
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
      ['Not for release', 'Must return',
       'Must not return', 'Other offences'].each_with_index.
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
  end
end

module FeatureHelpers
  module HealthcareForm
    def fill_in_healthcare(options = {})
      options = build_healthcare_properties.merge(options)
      options.each do |key, (radio_value, textarea_value)|
        fill_in_healthcare_field(key, radio_value, textarea_value)
      end
      check 'Do they need an MPV?'
      click_save
    end

    def fill_in_healthcare_field(field, radio_value, textarea_value)
      within_healthcare_field(field) do
        choose radio_value
        find('textarea').set textarea_value
      end
    end

    def clear_healthcare_field(field)
      within_healthcare_field(field) { choose 'Clear selection' }
    end

    def build_healthcare_properties
      ['Physical health', 'Mental health',
       'Social care', 'Allergies',
       'Disabilities', 'Medication'].each_with_index.
        each_with_object({}) do |(r, i), o|
        o[r] = (i.odd? ? ['Yes', 'Some user input'] : ['No', nil])
      end
    end

    def within_healthcare_field(field, &_blk)
      within(find('span', text: field).
        find(:xpath, '../..')) do
          yield
        end
    end
  end
end

module FeatureHelpers
  module HealthcareForm
    def fill_in_healthcare(options = {})
      options = build_healthcare_properties.merge(options)
      options.each do |key, (radio_value, textarea_value)|
        fill_in_healthcare_field(key, radio_value, textarea_value)
      end
      check 'Do they need an MPV?'
      within_healthcare_field('Medication') do
        choose 'Yes'

        fill_in 'healthcare[medications[0]][description]',
          with: 'Aspirin'
        fill_in 'healthcare[medications[0]][administration]',
          with: 'Once a day'
        select 'Prisoner',
          from: 'healthcare[medications[0]][carrier]'
        fill_in 'healthcare[medications[1]][description]',
          with: 'Ibuprofen'
        fill_in 'healthcare[medications[1]][administration]',
          with: 'Twice a day'
        select 'Escort',
          from: 'healthcare[medications[1]][carrier]'
      end

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
       'Disabilities'].each_with_index.
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

    def remove_medication
      check 'healthcare[medications[1]][_destroy]'
      click_save
      medication_0 =
        find_field('healthcare[medications[0]][description]').value
      medication_1 =
        find_field('healthcare[medications[1]][description]').value
      expect(medication_0).to eq 'Aspirin'
      expect(medication_1).to eq nil
    end
  end
end

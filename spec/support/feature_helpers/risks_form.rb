module FeatureHelpers
  module RisksForm
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

    def build_risk_properties
      ['Risks to self', 'Violence and risk to others', 'Risk from others',
       'Escort escape risk', 'Intolerant behaviour towards others',
       'Prohibited items', 'Non-association'
      ].each_with_index.
        each_with_object({}) do |(r, i), o|
        o[r] = (i.odd? ? ['Yes', 'Some user input'] : ['No', nil])
      end
    end

    def within_risk(field, &_blk)
      within(find('span', text: field).
        find(:xpath, '../..')) do
          yield
        end
    end
  end
end

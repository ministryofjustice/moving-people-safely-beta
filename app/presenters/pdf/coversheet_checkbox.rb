module Pdf
  module CoversheetCheckbox
    def html_for(checkbox_group)
      ActionController::Base.new.render_to_string(
        partial: 'pdfs/coversheet_checkboxes',
        locals: {
          yes_checked_class: checkbox_group.yes_checkbox_class,
          no_checked_class: checkbox_group.no_checkbox_class,
          attribute: checkbox_group.attribute
        }
      )
    end

    module_function :html_for
  end
end

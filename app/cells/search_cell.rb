class SearchCell < FormCell
  def escort
    @escort ||= Escort.find_by_prison_number(model.prison_number)
  end

  def show_results
    if model.valid? && escort.present?
      render :result
    elsif model.valid? && escort.blank?
      render :no_result
    end
  end

  def show_errors
    if model.errors.any?
      content_tag :span, class: 'error-message' do
        t('.search_error')
      end
    end
  end

  def error_wrapper(form, styles:, styles_on_error:, &_blk)
    if form.object.errors.any?
      styles = [styles, styles_on_error].join(' ')
    end
    content_tag(:div, class: styles) { yield }
  end

  def link_to_escort
    link_to escort.prisoner_prison_number, summary_path(escort)
  end

  def initiate_new_per_button
    button_to t('.initiate_new_per_button'),
      {
        controller: :escorts,
        action: :create,
        prison_number: model.prison_number
      },
      class: 'button'
  end

  delegate :prisoner_full_name, :prisoner_formatted_date_of_birth,
    :formatted_updated_at, to: :escort
end

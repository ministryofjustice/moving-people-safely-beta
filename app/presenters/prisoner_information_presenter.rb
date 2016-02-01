class PrisonerInformationPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers

  def edit_section_path
    identification_path(__getobj__)
  end

  def date_of_birth
    __getobj__.date_of_birth&.strftime('%d/%m/%Y') || empty_text
  end

  def sex
    __getobj__.sex&.chr&.capitalize || empty_text
  end

private

  def empty_text
    I18n.t('escorts.summary.empty_text')
  end

  def edit_section_text
    I18n.t('escorts.summary.edit_section')
  end

  def method_missing(method_name, *_args, &_blk)
    __getobj__.send(method_name) || empty_text
  end
end

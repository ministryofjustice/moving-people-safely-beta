class BaseCell < Cell::ViewModel
  include ActionView::Helpers::TranslationHelper

  def show
    @virtual_path = translation_path
    render
  end
end

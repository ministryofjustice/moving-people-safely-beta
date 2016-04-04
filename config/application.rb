require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)

module MovingPeopleSafely
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.app_title = 'Moving people safely'
    config.proposition_title = 'Moving people safely'
    config.phase = 'beta'
    config.product_type = 'service'
    config.feedback_url = ''
    config.action_view.field_error_proc = proc do |html_tag, _instance|
      html_tag
    end
  end
end

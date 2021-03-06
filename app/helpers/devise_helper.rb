module DeviseHelper
  def devise_error_messages!
    if devise_error_messages?
      flash.now[:error] = t('errors.messages.not_saved',
        count: resource.errors.count,
        resource: resource.class.name.underscore)

      render('/shared/flashes/save_errors', object: resource)
    end
  end

  def devise_error_messages?
    resource.errors.any?
  end
end

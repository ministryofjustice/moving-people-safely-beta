Rails.application.routes.draw do
  scope 'escort/:id', controller: :escorts do
    get 'identification'
    get 'summary'
  end
  resource :escort, only: %i[ index create ]
  root to: 'escorts#index'
end

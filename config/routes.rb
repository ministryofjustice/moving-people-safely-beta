Rails.application.routes.draw do
  scope 'escort/:id', controller: :escorts do
    resource :identification,
      only: %i[ show update ],
      controller: :escorts
    get 'summary'
  end
  resource :escort, only: %i[ index create ]
  root to: 'escorts#index'
end

Rails.application.routes.draw do
  scope 'escort/:id' do
    resource :identification,
      only: %i[ show update ],
      controller: :escorts
    get 'summary', controller: :escorts
    resource :pdf, only: :show
  end
  resource :escort, only: %i[ index create ]
  root to: 'escorts#index'
end

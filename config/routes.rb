Rails.application.routes.draw do
  scope 'escort/:id' do
    resource :identification,
      only: %i[ show update ],
      controller: :escorts,
      page: :identification
    resource :risks,
      only: %i[ show update ],
      controller: :escorts,
      page: :risks
    get 'summary', controller: :escorts
    resource :pdf, only: :show
  end
  resource :escort, only: :create
  post 'search', controller: :home_pages
  root to: 'home_pages#show'
end

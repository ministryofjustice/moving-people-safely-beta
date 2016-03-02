Rails.application.routes.draw do
  devise_for :users, skip: %i[ registrations ]

  scope 'escort/:id' do
    resource :identification,
      only: %i[ show update ],
      controller: :escorts,
      page: :identification

    resource :risks,
      only: %i[ show update ],
      controller: :escorts,
      page: :risks

    resource :move_information,
      only: %i[ show update ],
      controller: :escorts,
      path: 'move-information',
      page: :move_information

    get 'summary', controller: :escorts

    resource :pdf, only: :show
  end
  resource :escort, only: :create
  post 'search', controller: :home_pages
  root to: 'home_pages#show'
end

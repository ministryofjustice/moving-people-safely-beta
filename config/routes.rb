Rails.application.routes.draw do
  devise_for :users, skip: %i[ registrations ]

  scope 'escort/:id' do
    Form::Routing.resource_list.each do |r|
      resource r.name,
        only: %i[ show update], controller: :escorts,
        path: r.path, page: r.name
    end

    get 'summary', controller: :escorts

    resource :pdf, only: :show
  end

  resource :escort, only: :create

  post 'search', controller: :home_pages

  root to: 'home_pages#show'
end

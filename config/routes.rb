Rails.application.routes.draw do
  scope 'escort/:id' do
    get 'identification', controller: :escorts
  end
  resource :escort, only: %i[ index create ]
  root to: 'escorts#index'
end

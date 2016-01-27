Rails.application.routes.draw do
  scope 'escort/:id' do
    resource :identification,
      only: %i[ show create ],
      controller: :identification
  end
  resource :escort, only: %i[ index create ]
  root to: 'escorts#index'
end

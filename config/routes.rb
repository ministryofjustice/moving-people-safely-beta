Rails.application.routes.draw do
  scope 'escort-record/:id' do
    get 'identification', controller: :escort_records
  end
  resource :escort_record, only: %i<index create>
  root to: 'escort_records#index'
end

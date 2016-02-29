namespace :dev do
  desc 'Seeds data for development environment'
  task prime: :environment do
    User.destroy_all
    FactoryGirl.create(:user)
  end
end

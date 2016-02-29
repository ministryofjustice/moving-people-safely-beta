namespace :users do
  desc 'Invite a user to the project'
  task :invite,
    %i[ email first_name last_name job_role ] => :environment do |_, args|
    User.invite!(
      email: args[:email],
      first_name: args[:first_name],
      last_name: args[:last_name],
      job_role: args[:job_role]
    )
  end

  desc 'Delete a user from the project'
  task :delete, %i[ email ] => :environment do |_, args|
    User.find_by!(email: args[:email]).delete
  end
end

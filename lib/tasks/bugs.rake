namespace :ch do
  
  task :bug_emails => :environment do
    Email.update_all("to_type = 'User'")
  end
  
end
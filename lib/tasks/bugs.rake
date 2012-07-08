namespace :ch do
  
  task :bug_emails => :environment do
    Email.update_all("to_type = 'User'")
  end 
  
  desc 'set Content-Disposition metadata for photo files'
  task :set_content_dispo => :environment do
    count = Photo.count
    idx = 0
    for photo in Photo.all
      idx +=1
      puts " photo [#{photo.name}] #{idx}/#{count}"
      photo.set_attachment
    end
  end
  
end
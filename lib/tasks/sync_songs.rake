namespace :ch do
  
  task :init => :environment do
    AWS::S3::Base.establish_connection!(
      :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    )
    BUCKET = 'chantal-et-henri.playlist'
  end

  desc 'synchronise the song database with S3 bucket'
  task :sync => :init do
    AWS::S3::Bucket.find(BUCKET).objects.each do |song|
      unless song.content_type =='text/xml'
        unless Upload.find_by_key(song.key)
          Upload.create! do |sg|
            sg.key = song.key
            sg.titre = song.metadata[:titre]
            sg.artiste = song.metadata[:artiste]
            sg.titre ||= song.key
          end
          puts " ---> #{song.key}"
        end
      end
    end
  end
  
  desc 'test rake'
  task :test  => :environment do
    puts Category.all.inspect
  end
end
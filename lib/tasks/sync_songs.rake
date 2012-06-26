namespace :ch do
  
  task :init => :environment do
    AWS::S3::Base.establish_connection!(
      :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    )
    BUCKET = 'chantal-et-henri.playlist'
  end 
  
  desc 'dump a S3 bucket into local respository'
  task :mp3_tag => :init do
    require 'mechanize'
    require 'mp3info'
#    i = 0
    Song.all.each do |song|
#      break if i > 2
      if song.s3_url
#        i += 1 
        file =File.join("amazon_s3_temp",filename(song))
        download(song.s3_url, file)
        if is_mp3?(file)
          Mp3Info.open(file) do |mp3|
            puts "title = #{mp3.tag.title}"   
            puts "artist = #{mp3.tag.artist}"   
            mp3.tag.title ||= song.titre
            mp3.tag.artist ||= song.artiste
          end
        end
      end
    end
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
  
  desc 'remove statuts orphans'
  task :clean => :environment do
    Statut.all.each do |st|
      unless st.user
        puts "destroying statut##{st.id}"
        st.destroy
      end
    end
  end
  
  desc 'create guests for users'
  task :guests => :environment do
    User.no_guests.each do |u|
      unless u.guests.myself
        puts "create guest for #{u.name}"
        u.send(:make_guest)
      end
    end
  end
  
  desc 'test rake'
  task :test  => :environment do
    puts Category.all.inspect
  end 
  

  def download(url, save_as = nil)
    return puts("#{save_as} already exists") if(File.exists?(save_as) & !save_as.nil?)
    if save_as.nil?
      Dir.mkdir("amazon_s3_temp") if !File.exists?("amazon_s3_temp")
      save_as = File.join("amazon_s3_temp",File.basename(url))
    end
    begin
      puts "Saving to #{save_as}"
#      agent = Mechanize.new {|a| a.log = Logger.new(STDERR) }
      agent = Mechanize.new
      img = agent.get(url)
      img.save_as(save_as)
      return save_as
    rescue
      #raise "Failed on " + url + "  " + save_as
      puts "Failed on " + url + "  " + save_as
    end
  end

  def is_mp3?(file)
    arr = file.split(".")
    arr.last.downcase == "mp3"
  end 

  def filename(song)
    File.basename(song.s3_url).split("?")[0]
  end
    
end   


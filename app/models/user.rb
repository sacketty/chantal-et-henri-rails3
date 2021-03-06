class User < ActiveRecord::Base
  attr_accessible :admin, :activated
  attr_accessor :x_activated, :mairie, :diner
  has_many :category_users, :dependent => :destroy
  has_one  :statut, :dependent => :destroy
  has_many :photos
  has_many :presences, :through => :guests do
    def at(lieu)
      find(:all, :conditions=>"\"presences\".\"#{lieu}\" IS TRUE")
    end
  end
  has_one  :presence, :dependent => :destroy
  has_many :songs, :through => :category_users
  has_many :emails, :as=>:to
  has_many :rooms do
    def available
      list =[]
      all.each do |r|
        list << r if r.guests.size < r.places
      end
      list
    end
  end
  has_many :singles, :class_name=>"Room::Single"
  has_many :doubles, :class_name=>"Room::Double"
  belongs_to :room
  has_many :guests, :foreign_key=>:invited_by_id, :dependent => :destroy do
    def myself
      find(:first, :conditions=>'myself IS TRUE')      
    end
  end
  has_many :uploads, :through => :songs
  has_many :direct_uploads, :class_name => "Upload", :foreign_key=>:added_by_id
  after_initialize :set_initial_values
  
  validates_presence_of :name
  
  def self.no_guests(activated=nil)
    if activated.nil?
      cond = "type IS NULL"
    elsif activated
      cond = ["type IS NULL AND activated = ?", true]
    else
      cond = ["type IS NULL AND activated IS NULL OR activated = ?", false]
    end
    find(:all, :conditions=>cond)
  end

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.email = auth["info"]["email"]
      user.name = auth["info"]["name"]
      user.nickname = auth["info"]["nickname"]
      user.first_name = auth["info"]["first_name"]
      user.last_name = auth["info"]["last_name"]
      user.image = auth["info"]["image"]
      user.location = auth["info"]["location"]
    end
  end
  
  def newly_activated?
    self.activated && !self.x_activated
  end
  
  def self.fake(email=nil)
    user = User.new
    fn = Faker::Name
    user.name = fn.name; user.first_name = fn.first_name; user.last_name = fn.last_name
    user.email = email
    user.email ||= Faker::Internet.email(user.name)
    puts UserMailer.registration_confirmation(user).deliver
    user
  end
  
  def get_statut
    self.statut ||= self.create_statut
  end
  
  def at_mairie?
    return false unless presence
    presence.mairie
  end
  
  def at_diner?
    return false unless presence
    presence.diner
  end
  
  def receivers
    [self.email]
  end
  
private
  
  def set_initial_values
    self.x_activated = self.activated
  end
  
end

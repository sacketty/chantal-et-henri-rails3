class User < ActiveRecord::Base
  attr_accessible :admin, :activated
  has_many :category_users, :dependent => :destroy
  has_many :songs, :through => :category_users
  has_many :uploads, :through => :songs
  has_many :direct_uploads, :class_name => "Upload", :foreign_key=>:added_by_id

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
  
end

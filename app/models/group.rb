class Group < ActiveRecord::Base
  attr_accessible :name, :description, :user_ids
  attr_accessor :user_id
  has_many :emails, :as => :to
  has_and_belongs_to_many :users  
  
  def non_members
    User.all - self.users
  end
  
  def short_description
    description.length > 15 ? description[0..14]+"..." : description
  end 
  
  def receivers
    self.users.map{|u| "#{u.name} <#{u.email}>"}
  end
end

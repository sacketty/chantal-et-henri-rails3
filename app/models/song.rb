class Song < ActiveRecord::Base
  has_many :category_users, :dependent => :destroy
  has_many :categories, :through => :category_users
  validates :titre, presence: true
  validates :key, uniqueness: true
  attr_accessible :titre, :artiste, :url, :category_id, :key
  attr_accessor :category_id, :user
  after_save :set_category
  
  def category_list
    (self.categories.map {|c| c.name}).join(", ")
  end
  
  def s3_url
    AWS::S3::S3Object.url_for(self.key, BUCKET) if self.key
  end
  
private
  def set_category
    if(self.user and self.category_id)
      cu = CategoryUser.find_by_user_id_and_song_id(self.user.id, self.id)
      cu ||= CategoryUser.new
      cu.category_id = self.category_id
      cu.user_id ||= self.user.id
      cu.song_id ||= self.id
      cu.save
    end
  end
  
end

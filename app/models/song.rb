class Song < ActiveRecord::Base
  default_scope :order => "updated_at DESC"
  has_many :category_users, :dependent => :destroy
  has_many :categories, :through => :category_users
  belongs_to :upload
  validates :titre, presence: true
  attr_accessible :titre, :artiste, :url, :category_id, :key
  attr_accessor :category_id, :user
  after_save :set_category
  
  def category_list
    (self.categories.map {|c| c.name}).join(", ")
  end
  
  def s3_url
    self.upload.s3_url if self.upload
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

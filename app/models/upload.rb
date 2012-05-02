class Upload < ActiveRecord::Base
  default_scope :order => "updated_at DESC"
  before_destroy :delete_s3
  has_many :songs, :dependent => :destroy
  has_many :categories, :through=>:songs, :dependent => :destroy
  attr_accessible :titre, :key, :artiste, :category_id
  attr_accessor :category_id
  validates :key, uniqueness: true, presence: true

  
  def category_list
    (self.categories.map {|c| c.name}).join(", ")
  end
  
  def s3_url
    AWS::S3::S3Object.url_for(self.key, BUCKET)
  end
  
private
  def delete_s3
    AWS::S3::S3Object.delete(self.key, BUCKET)
  end
  
end

class Photo < ActiveRecord::Base
  belongs_to :user
  attr_accessible :image, :name
  mount_uploader :image, ImageUploader
  validates :user, :name, :presence=>true
end

class Photo < ActiveRecord::Base
  belongs_to :user
  attr_accessible :image, :name
  mount_uploader :image, ImageUploader
  validates :user, :name, :presence=>true
  validate :further_validations 

  def self.accepted
    find(:all, :conditions=>['accepted = ?', true])
  end
  
  def self.to_accept
    find(:all, :conditions=>['accepted = ?', false])
  end     
  
  def further_validations
    errors.add(:photo, "#{self.name} nom de fichier indisponible") if (self.new_record? & PhotoBox.exists(self.name))
  end
  
  def short_name
    return name if name.length < 14
    name[0..4]+"..."+name[-9,9]
  end 
  
  def moderation
    accepted ? "bloquer" : "accepter"
  end
end

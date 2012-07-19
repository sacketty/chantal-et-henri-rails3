class Photo < ActiveRecord::Base
  belongs_to :user
  attr_accessible :image, :name
  mount_uploader :image, ImageUploader
  validates :user, :name, :presence=>true
  validate :further_validations 

  def self.accepted
    scoped(:conditions=>['accepted = ?', true])
  end
  
  def self.to_accept
    scoped(:conditions=>['accepted = ?', false])
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
  
  def s3_object
    @s3_object ||= PhotoBox.find("uploads/"+self.name)
  rescue
    nil
  end
  
  def set_attachment
    return unless s3_object
    if s3_object.metadata["Content-Disposition"].nil?
      s3_object.metadata["Content-Disposition"]="attachment"
      s3_object.store
    end
  end
  
end

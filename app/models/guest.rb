class Guest < User
  attr_accessible :name, :mairie, :diner, :room_id, :myself
  belongs_to :invited_by, :class_name=>"User"
  validates_presence_of :name, :invited_by
  validate :further_validations
  
  def get_statut
  end
  
  def make_guest
  end
  
  def further_validations
    return unless room
    disp = self.room.guests - [self]
    self.errors.add(:chambre, "'#{self.room.name}' surchargee ") unless disp.size < self.room.places
  end
end
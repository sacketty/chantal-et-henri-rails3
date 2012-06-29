class Guest < User
  attr_accessible :name, :mairie, :diner, :room_id, :myself
  belongs_to :invited_by, :class_name=>"User"
  belongs_to :table
  validates_presence_of :name, :invited_by
  validate :further_validations
  before_save :set_presence
  after_save :save_presence

  def self.search(search)
    if(search)
      where('upper(name) LIKE upper(?)', "%#{search}%")
    else
      scoped
    end
  end
  
  def self.to_install
    cond = ["table_id IS NULL and  diner = ?", true]
    find(:all, :conditions=> cond, :joins => :presence, :order => "name ASC")
  end
  
  def get_statut
  end
  
  def make_guest
  end

  def set_presence
    self.presence ||= self.build_presence
    self.presence.mairie = ( self.mairie=="1" ) if self.mairie
    self.presence.diner = ( self.diner=="1" ) if self.diner
    self.table = nil if !self.presence.diner
    self.presence.save
  end

  def save_presence
    self.presence.save
  end
  
  def further_validations
    return unless room
    disp = self.room.guests - [self]
    self.errors.add(:chambre, "'#{self.room.name}' surchargee ") unless disp.size < self.room.places
    return unless self.table
    disp = self.table.guests - [self]
    self.errors.add(:table, "'#{self.table.name}' surchargee ") unless disp.size < self.table.seats
  end
end

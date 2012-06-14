class Guest < User
  attr_accessible :name, :mairie, :diner, :room_id, :myself
  belongs_to :invited_by, :class_name=>"User"
  validates_presence_of :name
  
  def get_statut
  end
end
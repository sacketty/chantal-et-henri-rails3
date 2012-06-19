class Room::Single < Room
  MAX=18
  PLACES=2
  
  def max
    MAX
  end
  
  def places
    PLACES
  end
  
  def name
    "ref:#{self.id} - simple"
  end
end

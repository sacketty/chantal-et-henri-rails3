class Room::Double < Room
  MAX=12
  PLACES=3
  def max
    MAX
  end
  
  def places
    PLACES
  end
  
  def name
    "ref:#{self.id} - double"
  end
end

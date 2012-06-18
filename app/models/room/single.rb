class Room::Single < Room
  MAX=25
  
  def max
    MAX
  end
  
  def places
    2
  end
  
  def name
    "ref:#{self.id} - simple"
  end
end
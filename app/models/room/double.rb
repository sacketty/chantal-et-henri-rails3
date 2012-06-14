class Room::Double < Room
  MAX=5
  def max
    MAX
  end
  
  def name
    "ref:#{self.id} - double"
  end
end
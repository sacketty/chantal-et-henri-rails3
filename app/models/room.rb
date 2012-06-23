class Room < ActiveRecord::Base
  belongs_to :user
  has_many :guests
  attr_accessible :number, :places
  before_validation(:on=>:create) {check_max}
  
  def self.update_quantity(statut)
    self.update_room(statut, :singles)
    self.update_room(statut, :doubles)
  end
  
  def self.update_room(statut,attr)
    qty = attr == :singles ? statut.delta_s : statut.delta_d
    user = statut.user
    if(qty <0)
      i=0
      begin
        i += 1
        user.send(attr).last.destroy
      end until (i+qty==0)
    elsif(qty >0)
      (1..qty).each { |i| @ch = user.send(attr).create!}
    end
    statut
  end   
  
  def full_name 
    g = self.guests.map {|x| x.name}
    for i in g.length..places-1 do
      g << " x "      
    end
    g = g[0..places-1]
    g.join(" | ")
  end
  
  def check_max
    errors.add(:maximum, "nombre de reservations atteintes pour #{self.class}") if(self.class.count >= self.max)
  end
end

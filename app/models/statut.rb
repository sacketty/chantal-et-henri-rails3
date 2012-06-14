class Statut < ActiveRecord::Base
  attr_accessible :chambre, :chambre2, :diner, :mairie
  attr_accessor :quantity, :singles, :doubles, :delta_s, :delta_d
  belongs_to :user
  after_initialize :set_default_values
  validates :chambre, :diner, :mairie, :numericality => { :greater_than_or_equal_to => 0 }
  after_find :set_reservation_status
  
  def set_resa_rq(params)
    self.singles = params['singles']
    self.singles = 0 if self.singles == ""
    self.singles = 0 if self.singles.to_i < 0
    self.doubles = params['doubles']
    self.doubles = 0 if self.doubles == ""
    self.doubles = 0 if self.doubles.to_i < 0
    self.delta_s = self.singles.to_i - self.user.singles.count
    self.delta_d = self.doubles.to_i - self.user.doubles.count
  end
  
private
  
  def set_reservation_status
    self.singles = user.singles.count
    self.doubles = user.doubles.count
  end

  def set_default_values
    self.chambre ||=0
    self.chambre2 ||=0
    self.diner ||=0
    self.mairie ||=0
  end
end

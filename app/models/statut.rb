class Statut < ActiveRecord::Base
  attr_accessible :chambre, :diner, :mairie
  belongs_to :user
  after_initialize :set_default_values
  validates :chambre, :diner, :mairie, :numericality => { :greater_than_or_equal_to => 0 }
  
private
  def set_default_values
    self.chambre ||=0
    self.diner ||=0
    self.mairie ||=0
  end
end

class Email < ActiveRecord::Base
  belongs_to :to, :polymorphic => true
  attr_accessible :subject, :text, :cc, :cci
  validates :to, :subject, :presence=>true
  validate :further_validation
  
  def further_validation
    return unless self.to.is_a?(Group)
    errors.add(:list, "destinataires vide") unless self.to.users.size >0
  end
end

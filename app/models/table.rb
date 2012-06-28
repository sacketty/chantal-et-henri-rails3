class Table < ActiveRecord::Base
  attr_accessible :name, :seats
  attr_accessor :guest_id
  after_initialize :set_default_values
  has_many :guests
  accepts_nested_attributes_for :guests

  def set_default_values
    self.seats ||=8
  end
end

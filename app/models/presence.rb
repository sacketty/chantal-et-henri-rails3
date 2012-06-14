class Presence < ActiveRecord::Base
  belongs_to :user
  attr_accessible :diner, :mairie
end

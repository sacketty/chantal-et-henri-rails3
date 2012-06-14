class ListeMariage < ActiveRecord::Base
  belongs_to :taken_by
  attr_accessible :article, :taken
end

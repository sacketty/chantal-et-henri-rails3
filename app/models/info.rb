class Info < ActiveRecord::Base
  default_scope :order => "updated_at DESC"
  attr_accessible :author_id, :subject, :text
  belongs_to :author, :class_name=>"User"
end

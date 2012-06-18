class Email < ActiveRecord::Base
  belongs_to :to, :class_name=>User.name
  attr_accessible :subject, :text, :cc, :cci
  validate :to, :subject, :presence=>true
end

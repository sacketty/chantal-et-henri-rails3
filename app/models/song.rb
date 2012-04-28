class Song < ActiveRecord::Base
  has_and_belongs_to_many :users, :autosave => true
  has_and_belongs_to_many :categories, :autosave => true
  validates :titre, presence: true
  attr_accessible :titre, :artiste, :url, :category_id
  attr_accessor :category_id, :user
  after_save :set_category
  
  def category_list
    (self.categories.map {|c| c.name}).join(", ")
  end
  
private
  def set_category
    cat = Category.find(self.category_id)
    self.categories << cat
    self.users<< self.user
  end
  
end

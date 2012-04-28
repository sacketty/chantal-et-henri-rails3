class Song < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :categories
  validates :titre, presence: true
  attr_accessor :category_id, :user
  
  def after_save
    super
    cat = Category.find(self.category_id)
    self.categories << cat
    self.users<< self.user
  end
  
end

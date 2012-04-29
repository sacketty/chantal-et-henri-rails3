class CategoryUser < ActiveRecord::Base
  set_table_name "categories_songs"
  belongs_to :category
  belongs_to :user
  belongs_to :song
end

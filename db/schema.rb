# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120628143735) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories_songs", :force => true do |t|
    t.integer "song_id"
    t.integer "category_id"
    t.integer "user_id"
  end

  add_index "categories_songs", ["category_id"], :name => "index_categories_songs_on_category_id"
  add_index "categories_songs", ["song_id"], :name => "index_categories_songs_on_song_id"

  create_table "emails", :force => true do |t|
    t.integer  "to_id"
    t.string   "cc"
    t.string   "cci"
    t.string   "subject"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "emails", ["to_id"], :name => "index_emails_on_to_id"

  create_table "infos", :force => true do |t|
    t.string   "subject"
    t.text     "text"
    t.integer  "author_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "liste_mariages", :force => true do |t|
    t.string   "article"
    t.boolean  "taken"
    t.integer  "taken_by_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "liste_mariages", ["taken_by_id"], :name => "index_liste_mariages_on_taken_by_id"

  create_table "presences", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "mairie"
    t.boolean  "diner"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "presences", ["user_id"], :name => "index_presences_on_user_id"

  create_table "rooms", :force => true do |t|
    t.integer  "user_id"
    t.string   "number"
    t.integer  "places"
    t.string   "type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rooms", ["user_id"], :name => "index_rooms_on_user_id"

  create_table "songs", :force => true do |t|
    t.integer  "uid"
    t.string   "titre"
    t.string   "artiste"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "upload_id"
  end

  add_index "songs", ["titre"], :name => "index_songs_on_titre"

  create_table "songs_users", :force => true do |t|
    t.integer "song_id"
    t.integer "user_id"
  end

  add_index "songs_users", ["song_id"], :name => "index_songs_users_on_song_id"
  add_index "songs_users", ["user_id"], :name => "index_songs_users_on_user_id"

  create_table "statuts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "mairie"
    t.integer  "diner"
    t.integer  "chambre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "chambre2"
  end

  create_table "tables", :force => true do |t|
    t.string   "name"
    t.integer  "seats"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "uploads", :force => true do |t|
    t.string   "key"
    t.string   "titre"
    t.string   "artiste"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "added_by_id"
  end

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "email"
    t.string   "name"
    t.string   "nickname"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image"
    t.string   "location"
    t.boolean  "admin"
    t.boolean  "activated"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "type"
    t.integer  "invited_by_id"
    t.boolean  "myself"
    t.integer  "room_id"
    t.integer  "table_id"
  end

  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["provider", "uid"], :name => "index_users_on_provider_and_uid", :unique => true
  add_index "users", ["room_id"], :name => "index_users_on_room_id"
  add_index "users", ["table_id"], :name => "index_users_on_table_id"

end

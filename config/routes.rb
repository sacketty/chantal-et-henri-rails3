ChantalEtHenriRails3::Application.routes.draw do
  
  match "/songs/all", to: "songs#all"
  resources :songs
  resources :s3_uploads
  resources :uploads
  resources :users
  root to: "sessions#new"
  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"
#  match "/upload", to: "uploads#icreate"
end

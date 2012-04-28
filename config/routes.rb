ChantalEtHenriRails3::Application.routes.draw do
  resources :songs
  resources :s3_uploads
  root to: "sessions#new"
  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"
  match "/upload", to: "uploads#index"
end

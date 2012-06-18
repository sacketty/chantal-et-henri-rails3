ChantalEtHenriRails3::Application.routes.draw do
  
  resources :rooms
  
#  resources :liste_mariages

  resources :statut
  resources :statuts
  resources :guests
  namespace :admin do
    resources :guests
  end

  resources :infos
  match 'statuts/:id', to: "statuts#edit", as: :edit_statuts
  match 'emails', to: "emails#index", as: :emails, via: :get
  match 'email/:id', to: "emails#show", as: :email, via: :get
  match 'email/:id', to: "emails#destroy", via: :delete
  
  match "/songs/all", to: "songs#all"
  match "/uploads/all", to: "uploads#all"
  resources :songs
  resources :s3_uploads
  resources :uploads
  resources :users do
    resources :emails
  end
  root to: "sessions#new"
  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"
#  match "/upload", to: "uploads#icreate"
end

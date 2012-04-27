ChantalEtHenriRails3::Application.routes.draw do
  resources :s3_uploads
  root :to=>'uploads#index'
end

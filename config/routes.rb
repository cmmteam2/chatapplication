
Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  
  get "/login" , to:"session#login"
  post '/login',   to: 'session#create'
  get '/logout',  to: 'session#destroy'
  get "/", to:"session#index"
  root "session#index"

  
  get "/signup", to:"user#new"
  post "/signup", to:"user#create"
  
  get "/users/:id", to:"user#show"
  post "/users/:id", to:"user#uploadpic"

  get "/workspace", to:"workspace#index"
  get "/createworkspace", to:"workspace#new"
  post "/createworkspace", to:"workspace#create"
  get "/editworkspace_:id",to:"workspace#edit"
  post "/editworkspace_:id",to:"workspace#update"
  get "/delws_:id",to:"workspace#destroy"


  get "/createchannel", to:"group#new"
  post "/createchannel", to:"group#create"
  get "/deletemember_:id",to:"group#deletemember"
  get "/dels_:id",to:"group#destroy"

  get "/views_:id",to:"group#view"  
  post "/views_:id",to:"group#sendmessage"  
  
  get "/edit_channel_:id",to:"group#edit"
  get "/updatechannel_:id",to:"group#update"
  post "/updatechannel_:id",to:"group#update"
  post "/edit_channel_:id",to:"group#update"

  get "/invite_people_:id",to:"group#invite"
  post "/invite_people_:id",to:"group#update"

  get "/loginworkspace_:id",to:"session#loginworkspace"

  
  get "/editworkspace", to:"workspace#edit"
 

  get "/individualmessage", to:"individualmessage#index"

  get "/gostar",to:"group#ssss"
  post "/gostar",to:"group#gostar"
  get "/delmg_:id",to:"group#deletemessage"
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
end
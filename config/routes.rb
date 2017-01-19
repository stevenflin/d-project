Rails.application.routes.draw do
	root 'app#index'
	post '/', to: 'app#create'
	get '/user/:id', to: 'user#index'
	get '/user', to: 'user#select'
	post '/user/:id', to: 'user#add'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

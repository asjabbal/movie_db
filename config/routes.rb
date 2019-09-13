Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  
  resources :movies do
  	collection {
  		get "search"
  	}

  	member {
  		post "rate"
  	}
  end
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      post '/subscribe', to: 'customers#subscribe'
      patch '/unsubscribe', to: 'customers#unsubscribe'
      get '/subscriptions', to: 'customers#subscriptions'

      post '/subscribe_tea', to: 'subscription_tea#create'
    end
  end
end

Rails.application.routes.draw do
  # resources :meanings
  # resources :words, except: [:show]

  scope "api/v1" do
    get "/words/:word",  to: "words#show"
    get "/word_list",    to: "words#index"
    get "/list/:letter", to: "words#list_by_letter"
  end
  
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

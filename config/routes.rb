Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :npcs, only: [:index, :show, :create, :update, :destroy]

  get 'npcs/random', to: 'npcs#random'
  get 'npcs/generate_preview', to: 'npcs#generate'
  post 'npcs/generate', to: 'npcs#generate'

  root to: proc {
    [
      200,
      { 'Content-Type' => 'application/json' },
      [{ message: 'Welcome to the Quirky NPC API ✨', docs: '/api-docs' }.to_json]
    ]
  }
end

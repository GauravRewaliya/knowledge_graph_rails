Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  resources :workspaces do
    resources :chatgpts, only: [ :create, :show, :index, :destroy ] do
      collection do
        post :import_from_curl
        # post :import_from_har
      end
      resources :chat_sessions, only: [ :create, :index, :destroy ] do
        member do
          get  :chat_messages
          post :send_message
          get :last_response
        end
      end
    end
  end
  
  get 'view/workspaces', to: 'workspaces#workspace_index'
  get 'view/workspaces/:workspace_id/swagger', to: 'workspaces#workspace_swagger'
  get 'view/workspaces/:workspace_id/docs', to: 'swagger_dynamic#workspace_spec'
  resources :user_bookmarks
  resources :users
  resources :scrapping_tables do
    member do
      post :process_step
      get :refetch
    end

    collection do
      post :curl_import
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

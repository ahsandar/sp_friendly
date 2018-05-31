Rails.application.routes.draw do

  mount Apidoco::Engine, at: "/docs"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get :heartbeat, to: 'application#heartbeat'

  namespace :api do
    namespace :v1 do

      scope :users do

        get '/', to: 'users#index'
        get '/block_list', to: 'users#block_list'

        scope :settings do
          post '/block', to: 'settings#block'
        end
        scope :friendships do
          get '/', to: 'friendships#index'
          post '/', to: 'friendships#create'
          post '/list', to: 'friendships#list'
          post '/common', to: 'friendships#common'
        end

        scope :subscriptions do
          get '/', to: 'subscriptions#index'
          post '/', to: 'subscriptions#create'
          post '/list', to: 'subscriptions#list'
        end
      end

    end
  end
end

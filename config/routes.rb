Rails.application.routes.draw do
  resources :tags do 
    collection do
      get 'stats', to: 'tags#stats', as: :stats
    end
  end
  
  resources :breeds do
    collection do
      get 'stats', to: 'breeds#stats', as: :stats
    end

    resources :tags, except: [:index, :show, :update, :create, :destroy] do
      collection do
        get '/', to: 'breeds#breed_tags'
        post '/', to: 'breeds#update_breed_tags'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

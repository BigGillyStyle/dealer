Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'vehicles#index'

  devise_for :users, skip: :registrations

  authenticate :user do
    resources :vehicles, only: [:new, :create, :edit, :update, :destroy] do
      member do
        patch :archive
      end
      resources :images, only: [:new, :create, :destroy] do
        member do
          get :download
        end
      end
    end
  end

  resources :vehicles, only: [:index, :show]
  resources :contacts, only: [:new, :create]
end

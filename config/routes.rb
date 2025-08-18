Rails.application.routes.draw do
  root "home#index"

  Rails.application.routes.draw do
  resources :places do
    resources :courses
  end
end

  resources :courses, only: [:show, :edit, :update, :destroy, :new, :create] do
    resources :participants, only: [:create, :new]
  end

  resources :participants, only: [:edit, :update, :destroy]
end
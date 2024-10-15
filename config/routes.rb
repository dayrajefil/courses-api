Rails.application.routes.draw do
  resources :courses do
    get :show, on: :member
    resources :videos, only: [:destroy]
  end
end

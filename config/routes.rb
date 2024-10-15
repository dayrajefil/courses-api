Rails.application.routes.draw do
  resources :courses do
    get :show, on: :member
  end
end

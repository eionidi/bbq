Rails.application.routes.draw do

  # дергаем спец. девайзовский метод, который генерит все нужные ему пути
  devise_for :users

  root "events#index"

  resources :events
  resources :users, only: [:show, :edit, :update]

end

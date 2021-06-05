Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :departments
  resources :manufacturers
  resources :suppliers
  resources :paints
  resources :orders do
    collection do
      patch :update_accept # ひと月分の勤怠申請に対する上長による判断
    end
  end
  resources :answers
end

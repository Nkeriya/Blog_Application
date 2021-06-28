Rails.application.routes.draw do
  devise_for :users
  # get 'articles/index'

  # get 'articles/show'

  # get 'articles/new'

  # get 'articles/edit'

  # get 'articles/create'

  # get 'articles/update'

  # get 'articles/destroy'

  root 'welcome#index'
  get 'welcome/about'
  get "articles/archived"

  resources :articles do
    resources :comments
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

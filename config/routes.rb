Rails.application.routes.draw do
  resources :users

  resources :posts, except: [:new, :edit] do
    resources :comments, except: [:new, :edit]
  end

  post '/posts/:id/tags' => 'posts#link_tag'
  delete '/posts/:id/tags' => 'posts#unlink_tag'

  post 'login' => 'users#login'

  resources :tags, except: [:new, :edit]
end

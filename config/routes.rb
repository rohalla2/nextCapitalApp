NextCapitalApp::Application.routes.draw do
  root 'static_pages#home'
  get 'information' => 'static_pages#information'
  resources :users

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  controller :tasks do
  	post 'task' => :add
  	post 'task/update' => :update
  	get 'task/edit' => :edit
  end
end

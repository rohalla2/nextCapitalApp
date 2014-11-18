NextCapitalApp::Application.routes.draw do
  root 'static_pages#home'
  get 'information' => 'static_pages#information'
 
  controller :users do
    post 'users' => :create
    get 'users' => :show
    get 'users/new' => :new
  end
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

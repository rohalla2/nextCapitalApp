NextCapitalApp::Application.routes.draw do
  root 'static_pages#home'
  get 'information' => 'static_pages#information'
  resources :users

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  post '/task' => 'tasks#add'

end

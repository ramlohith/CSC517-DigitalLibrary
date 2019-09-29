Rails.application.routes.draw do


  get 'students/library_list'
  get 'students/books'
  post 'students/history_request', to: 'students#history_request', as: :students_history_request
  post 'students/bookmark', to: 'students#bookmark', as: :students_bookmark
  post 'students/book_return', to: 'students#book_return', as: :students_book_return

  get 'admin/index'
  resources :libraries

  get 'libraries/edit'
  post '/sessions/create'
  get 'sessions/destroy'

  post 'login/new'
  get 'login/index'
  post 'login/index'
  post 'login/search'

  get 'librarians/login'
  post 'librarians/login'
  get 'librarians/books'
  post 'librarians/books'
  get 'librarians/show'
  post 'librarians/show'
  post  'librarians/destroy'
  get 'librarians/checkedout_request', to: 'librarians#checkedout_request', as: :librarians_checkedout_request
  get 'librarians/borrow', to: 'librarians#borrow', as: :librarians_borrow

  get 'students/index'
  post 'students/create'
  post 'students/index'
  get 'students/login'
  post 'students/login'
  get 'students/delete'
  post 'students/delete'
  get 'students/:id/edit', to: 'students#edit', as: :edit_student
  patch 'students/:id', to: 'students#update'
  get 'students/show'

  resources :students
  resources :login
  resources :sessions
  resources :librarians

  root 'login#index'


end

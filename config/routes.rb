Rails.application.routes.draw do


  get 'students/library_list'
  get 'students/books'
  post 'students/history_request', to: 'students#history_request', as: :students_history_request
  post 'students/bookmark', to: 'students#bookmark', as: :students_bookmark
  post 'students/book_return', to: 'students#book_return', as: :students_book_return
  post 'students/delete_reservation', to: 'students#book_delete_reservation', as: :students_book_delete_reservation

  get 'admin/index'
  resources :libraries

  get 'libraries/edit'
  post '/sessions/create'
  get 'sessions/destroy'

  post 'login/new'
  get 'login/index'
  post 'login/index'
  post 'login/search'

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


  get 'librarian/index'
  post 'librarian/create'
  post 'librarian/index'
  get 'librarian/login'
  post 'librarian/login'


  resources :students
  resources :login
  resources :sessions
  resources :librarian

  root 'login#index'


end

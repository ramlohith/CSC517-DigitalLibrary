Rails.application.routes.draw do

  get 'students/library_list'
  get 'students/books'
  post 'students/history_request', to: 'students#history_request', as: :students_history_request
  post 'students/bookmark', to: 'students#bookmark', as: :students_bookmark
  post 'students/book_return', to: 'students#book_return', as: :students_book_return
  post 'students/delete_reservation', to: 'students#book_delete_reservation', as: :students_book_delete_reservation

  get 'books/index'
  get 'books/delete'
  post 'books/delete'
  get 'books/show'
  get 'books/edit'
  get 'books/show'
  post 'books/show'

  get 'libraries/edit'
  get 'libraries/index'
  get 'libraries/new'
  get 'libraries/delete'
  post 'libraries/delete'
  post '/sessions/create'
  get 'sessions/destroy'

  post 'login/new'
  get 'login/index'
  post 'login/index'
  post 'login/search'

  get 'admins/index'
  get 'admins/login'
  post 'admins/login'
  get 'admins/users'
  get 'admins/delete'
  post 'admins/delete'
  get 'admins/approval'
  post 'admins/approval'
  get 'admins/approved'
  post 'admins/approved'
  get 'admins/:id/edit', to: "admins#edit", as: :admins_profile_edit
  post 'admins/:id', to: "admins#update", as: :admins_profile_update
  get 'admins/books_on_hold'
  get 'admins/checked'
  get 'admins/borrow_history'
  get 'admins/overdue'

  get 'students/:id/edit', to: 'students#admin_edit', as: :admin_edit
  get 'students/show/:id', to: 'students#admin_show', as: :admin_show
  post 'students/:id', to: 'students#admin_update', as: :admin_update

  get 'admins/:id/admin_edit_librarian', to: 'admins#admin_edit_librarian', as: :admin_edit_librarian
  get 'librarians/show/:id', to: 'librarians#admin_show_librarian', as: :admin_show_librarian
  post 'librarians/:id', to: 'librarians#admin_update_librarian', as: :admin_update_librarian

  get 'librarians/new'
  get 'librarians/:id/edit', to: 'librarians#edit', as: :librarian_edit
  post 'librarians/:id', to: 'librarians#update', as: :librarian_update
  get 'librarians/login'
  post 'librarians/login'
  get 'librarians/index'
  post 'librarians/index'
  get 'librarians/books'
  post 'librarians/books'
  get 'librarians/show'
  post 'librarians/show'
  post 'librarians/destroy'
  get 'librarians/checkedout_request', to: 'librarians#checkedout_request', as: :librarians_checkedout_request
  get 'librarians/borrow', to: 'librarians#borrow', as: :librarians_borrow

  get 'students/index'
  post 'students/create'
  post 'students/index'
  get 'students/login'
  post 'students/login'
  get 'students/delete'
  post 'students/delete'
  get 'students/admin_edit'
  post 'students/admin_edit'
  get 'students/:id/edit', to: 'students#edit', as: :edit_student

  patch 'students/:id', to: 'students#update'
  get 'students/show'

  resources :students
  resources :login
  resources :sessions
  resources :librarians
  resources :libraries
  resources :books
  resources :admins

  root 'login#index'


end

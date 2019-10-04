# README

* Ruby version:
ruby 2.6.3p62 (2019-04-16 revision 67580) [x64-mingw32]

Functionalities of Admin -
> Log in with an email and password
> Edit profile
> Create/Modify Librarian or Student accounts - On the homepage, you will find options to create/update a student or a librarian.
> Create/Modify/Delete Libraries and Books.- select show libraries on homepage and then you will find these options under the details page.
> View the list of users (students and librarians) and their profile details (except password) - under show students/librarian
> View the list of books, along with detailed information.
> View the list of book hold requests.
> View the list of Checked out books.
> View the list of students with books overdue (along with overdue fines). - select checked out books which will display dues for all the students alongwith the book they borrowed.
> View the borrowing history of each book. - Under show books, if you select a particular book to display, it will give you an option to see the borrowing history of that book.
> Delete Student/Book/Librarian from the system - This functionality hasn't been implemented thoroughly yet.

Functionalities of Librarian -
> Log in with email and password.
> Edit their own profile to choose an existing library. Each librarian can only work for one library.
> Edit library attributes. - Under "show libraries"
> Add/Remove books to/from a library.- Admin will create the book. Librarian can goto the "show books" option and then edit that book to add that to a library.
> View & Edit book information.
> View all books.
> View hold requests for any book in the library he/she works in. - Under "show hold requests".
> For books in the special collection, accept or deny book hold request. - Under hold request, the special collection books will have this option.
> View list of all the books that are checked out from their library. - shows under "Show Checked Out Books".
> View the borrowing history of the books from their library.- Under show books, if you select a particular book to display, it will give you an option to see the borrowing history of that book.
> View the list of students with overdue books from their library along with overdue fine. - select checked out books which will display dues for all the students alongwith the book they borrowed from their own library.

Functionalities of Students -
> View the list of all the libraries
> Edit profile to modify email, name and password only.
> View all books
> Check out/Request/Return a book from any library associated with their University. - This option is available under the details page of any book.
> Delete a reservation request, which has not been approved yet (pending). - Under hold request.
> View/Edit their account attributes (including changing their password).
> Search through the books - Datatables have been implemented to search, sort all the books based on their attributes.
> Bookmark a book they are interested in - This option is available under the details page of any book.
> View their bookmarked books. - Under "show bookmarks"
> View the overdue fines for his/her account. - Under "Show Checked Out Books"
> Receive an email when any of their book request is sucessful. - Make sure you use correct email ids.

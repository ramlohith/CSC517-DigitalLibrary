# README

* Ruby version:
ruby 2.6.3p62 (2019-04-16 revision 67580) [x64-mingw32]

We will follow a particular sequence to test all the functionalities:
Starting with the Admin:

Functionalities of Admin -
1) Log in with an email and password:
As the admin credentials are preconfigured, Please use the following credentials to login
 
 Username: admin@digitallibrary.com 
 Password: a

2) Edit profile: we can edit the admin profile, can change the admins mail id and password if required. We are providing multiple credentials for admin so that even if any user changes the credentials we can use other credentials to login.


3) Create/Modify Librarian or Student accounts - Please select the Librarian or the student tab and under those tabs you need to login using their credentials and then you can edit their profiles.

4) Create/Modify/Delete Libraries and Books.- You can find it under the libraries and books tab.

5) View the list of users (students and librarians) - under the Users tab you can see the details of the students and librarians except their passwords.

6) View the list of books, along with detailed information- we can find this under the books tab which shows the information of each book.

7) View the list of book hold requests- under the Books On Hold tab.

8) View the list of Checked out books- under the Checked Out Books tab.

9) View the list of students with books overdue (along with overdue fines). - we can see this under the overdue fine.

10) View the borrowing history of each book. - Under the Book History tab we can see the entire borrowing history of each book.

11) Delete Student/Book/Librarian from the system - we can delete a book under the Books tab for each book by clicking on the destroy tab.

Functionalities of Librarian -
1) Sign up as a  librarian- Once you sign up as a librarian a request for approval will be sent to the Admin. A message will be displayed indicating that an approval has been sent. Once it is approved by the admin you can now login.

2) Log in with email and password.

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

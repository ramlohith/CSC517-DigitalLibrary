# README

* Ruby version:
ruby 2.6.3p62 (2019-04-16 revision 67580) [x64-mingw32]

We will follow a particular sequence to test all the functionalities:(Please Use the Home Button to traverse back to the index page or use the back arrow where Home button is absent)

Starting with the Admin:

Functionalities of Admin -
1) Log in with an email and password:
As the admin credentials are preconfigured, Please use the following credentials to login
 
 Username: admin@digitallibrary.com 
 Password: password
 Username: admin1@digitallibrary.com
 Password: password@123
 Username: admin2@digitallibrary.com
 Password: password@123

2) Edit profile: we can edit the admin profile, can change the admins mail id and password if required. We are providing multiple credentials for admin so that even if any user changes the credentials we can use other credentials to login.

3)Admin can Logout using the Logout button on the top right corner. 

4) Create Librarian or Student accounts - Please select the New Librarian Registration or the New Student Registration tab. Once You register we take you to the Student Home page so that you can login or check the login.

5) Adding New Books- Under the Books Tab we can see a New Book option which allows us to create a new book.

6) Deleting a Book- Beside each Book we can click the destroy link to delete the book.

7) View the list of users (students and librarians) - under the Users tab you can see the details of the students and librarians except their passwords. To delete the user we can click the destroy button beside each user.

8) View the list of books, along with detailed information- we can find this under the books tab which shows the information of each book. The History link shows the history of each book that is the information related to the isbn of the book and by whom it was held.

9) View the list of book hold requests- under the Books On Hold tab. To view the detailed information click on the isbn hyperlink.

10) View the list of Checked out books- under the Checked Out Books tab. To view the detailed information click on the isbn hyperlink.

11) View the list of students with books overdue (along with overdue fines). - we can see this under the overdue fine tab which includes the fine a student needs to pay.

12) View the borrowing history of each book. - Under the Books tab we can see the entire borrowing history of each book by clicking the history link for each book.

13) Delete Student/Librarian from the system - we can delete a book under the Books tab for each book by clicking on the destroy tab. Similarly for Student and Librarian

Functionalities of Librarian -

1) Sign up as a  librarian- Once you sign up as a librarian a request for approval will be sent to the Admin. A message will be displayed indicating that an approval has been sent. Once it is approved by the admin you can now login.

2) Log in with email and password.
  In case we have created some librarian profiles for easy login which are approved by the admin
  Profile 1: Email: subha@subha.com                  Belongs to Hunt Library
             Password: test@123
  Profile 2: Email: sekhar@sekhar.com                Belongs to Hill Library
             Password: test@123

3) Edit their own profile to choose an existing library: Under the "Edit My Profile" tab we can modify and select a library. 

4) Edit library attributes. - Under "Edit library" tab we can edit the features of the his Library.

5) Add/Remove/Edit books from a library of his- Admin will create the book. Librarian can goto the "books" link and then edit that book to add that to a library or can edit some feature and also can remove the book by clicking the destroy link.
[He can only edit or delete the books from his library but not from other libraries but can view books of other libraries]

6) View all books- Under the "Books" Tab.

7) View hold requests for any book in the library he/she works in. - Under "View Hold Request".

8) For books in the special collection, accept or deny book hold request. - Under "View Hold Request", the special collection books will have this option to approve or deny by the librarian.

9) View list of all the books that are checked out from their library. - shows under "View Checkedout".

10) View the borrowing history of the books from their library.- Under "View Borrowing History" Tab we can see the history of books that are checkedout or on hold from that library.

11) View the list of students with overdue books from their library along with overdue fine. - Under the "View Student Fine" Tab we can see the list of students with fine and the books that are over due with the isbn number of the book.

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

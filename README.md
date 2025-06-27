                                            Aggregate Functions & Group Filtering in LibraryManagementSystem
1. Aggregate SQL Queries (SUM, COUNT, AVG, GROUP BY)
These queries summarize the data in the LibraryManagementSystem using common aggregate functions.

1.1 Count of Books by Each Author
SELECT a.Name AS Author, COUNT(b.BookID) AS BookCount
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID
GROUP BY a.Name;

 1.2 Count of Loans per Member
SELECT m.Name AS Member, COUNT(l.LoanID) AS TotalLoans
FROM Loans l
JOIN Members m ON l.MemberID = m.MemberID
GROUP BY m.Name;

 1.3 Average Number of Books Issued per Member
SELECT AVG(BookCount) AS AvgBooksIssued
FROM (
    SELECT MemberID, COUNT(LoanID) AS BookCount
    FROM Loans
    GROUP BY MemberID
) AS MemberLoans;

 1.4 Count of Books Published by Each Publisher
SELECT p.Name AS Publisher, COUNT(b.BookID) AS BooksPublished
FROM Books b
JOIN Publishers p ON b.PublisherID = p.PublisherID
GROUP BY p.Name;

 1.5 Count of Books per Genre
SELECT Genre, COUNT(*) AS TotalBooks
FROM Books
GROUP BY Genre;

 2. Filter Groups Using HAVING
HAVING is used to filter grouped records (like WHERE, but for aggregate results).

 2.1 Authors with More Than 1 Book
SELECT a.Name AS Author, COUNT(b.BookID) AS BookCount
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID
GROUP BY a.Name
HAVING COUNT(b.BookID) > 1;

 2.2 Members Who Borrowed More Than 1 Book
SELECT m.Name AS Member, COUNT(l.LoanID) AS TotalLoans
FROM Loans l
JOIN Members m ON l.MemberID = m.MemberID
GROUP BY m.Name
HAVING COUNT(l.LoanID) > 1;

2.3 Publishers With More Than 1 Book Published
SELECT p.Name AS Publisher, COUNT(b.BookID) AS BookCount
FROM Books b
JOIN Publishers p ON b.PublisherID = p.PublisherID
GROUP BY p.Name
HAVING COUNT(b.BookID) > 1;











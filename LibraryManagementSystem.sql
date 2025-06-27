
-- LibraryManagementSystem database 

CREATE DATABASE IF NOT EXISTS LibraryManagementSystem;
USE LibraryManagementSystem;

-- Authors Table
CREATE TABLE IF NOT EXISTS Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

-- Publishers Table
CREATE TABLE IF NOT EXISTS Publishers (
    PublisherID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

-- Books Table
CREATE TABLE IF NOT EXISTS Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(150) NOT NULL,
    Genre VARCHAR(50) NOT NULL,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    AuthorID INT NOT NULL,
    PublisherID INT NOT NULL,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

-- Members Table
CREATE TABLE IF NOT EXISTS Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    JoinDate DATE NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);

-- Loans Table
CREATE TABLE IF NOT EXISTS Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    IssueDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Sample SELECTS
SELECT * FROM Authors;
SELECT * FROM Publishers;
SELECT * FROM Books;
SELECT * FROM Members;
SELECT * FROM Loans;

-- Insert Data
INSERT INTO Authors (Name, Country) VALUES 
('Dr.Charles', 'USA'),
('K.John', 'Africa'),
('George', 'Japan');

INSERT INTO Publishers (Name, Country) VALUES 
('Eagle', 'USA'),
('Collins', 'Africa'),
('Bliss', 'Japan');

INSERT INTO Books (Title, Genre, ISBN, AuthorID, PublisherID) VALUES 
('Human Evolution', 'Study about Humans', '9788129104595', 1, 1),
('Computer Basics', 'Computer science', '9780747532699', 2, 3),
('Sea Creatures', 'Zoology', '9780451524935', 3, 2);

INSERT INTO Members (Name, JoinDate, Email) VALUES 
('Jai', '2024-05-05', 'jai@123.com'),
('Vardha', '2024-06-07', 'vardha@457.com');

INSERT INTO Loans (BookID, MemberID, IssueDate, ReturnDate) VALUES 
(1, 1, '2025-06-01', '2025-06-05'),
(2, 2, '2025-06-05', NULL);

-- UPDATE Statements
UPDATE Members 
SET Email = 'jai@123.com' 
WHERE MemberID = 1;

UPDATE Books 
SET Genre = 'Underwater creatures' 
WHERE Title = 'Sea Creatures';

-- DELETE Statements
DELETE FROM Loans 
WHERE ReturnDate IS NOT NULL;

DELETE FROM Members 
WHERE MemberID NOT IN (SELECT DISTINCT MemberID FROM Loans);

-- GROUP BY + Aggregates
SELECT a.Name AS Author, COUNT(b.BookID) AS BookCount
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID
GROUP BY a.Name;

SELECT m.Name AS Member, COUNT(l.LoanID) AS TotalLoans
FROM Loans l
JOIN Members m ON l.MemberID = m.MemberID
GROUP BY m.Name;

SELECT AVG(BookCount) AS AvgBooksIssued
FROM (
    SELECT MemberID, COUNT(LoanID) AS BookCount
    FROM Loans
    GROUP BY MemberID
) AS MemberLoans;

SELECT p.Name AS Publisher, COUNT(b.BookID) AS BooksPublished
FROM Books b
JOIN Publishers p ON b.PublisherID = p.PublisherID
GROUP BY p.Name;

SELECT Genre, COUNT(*) AS TotalBooks
FROM Books
GROUP BY Genre;

-- HAVING Clause
SELECT a.Name AS Author, COUNT(b.BookID) AS BookCount
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID
GROUP BY a.Name
HAVING COUNT(b.BookID) > 1;

SELECT m.Name AS Member, COUNT(l.LoanID) AS TotalLoans
FROM Loans l
JOIN Members m ON l.MemberID = m.MemberID
GROUP BY m.Name
HAVING COUNT(l.LoanID) > 1;

SELECT Genre, COUNT(*) AS TotalBooks
FROM Books
GROUP BY Genre
HAVING COUNT(*) > 1;

SELECT p.Name AS Publisher, COUNT(b.BookID) AS BookCount
FROM Books b
JOIN Publishers p ON b.PublisherID = p.PublisherID
GROUP BY p.Name
HAVING COUNT(b.BookID) > 1;

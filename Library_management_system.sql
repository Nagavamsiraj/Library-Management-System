-- ===========================================================================================================================
-- LIBRARY MANAGEMENT SYSTEM
-- Created By : Naga Vamsi Raj
-- Tool Used : MySQL Workbench
-- SQL Project
-- ===========================================================================================================================


-- ===========================================================================================================================
-- DATABASE CREATION
-- ===========================================================================================================================

CREATE DATABASE LibraryDB;

USE LibraryDB;


-- ===========================================================================================================================
-- TABLE 1 : BOOKS
-- Stores all book details in the library
-- ===========================================================================================================================

CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(150) NOT NULL,
    category VARCHAR(100) NOT NULL,
    total_copies INT DEFAULT 1,
    available_copies INT DEFAULT 1,
    published_year INT,
    added_date DATE DEFAULT (CURRENT_DATE)
);


-- ===========================================================================================================================
-- TABLE 2 : MEMBERS
-- Stores all member details
-- ===========================================================================================================================

CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    membership_date DATE DEFAULT (CURRENT_DATE),
    is_active BOOLEAN DEFAULT TRUE
);


-- ===========================================================================================================================
-- TABLE 3 : ISSUED_BOOKS
-- Tracks borrowed books and return details
-- ===========================================================================================================================

CREATE TABLE Issued_Books (
    issue_id INT AUTO_INCREMENT PRIMARY KEY,

    book_id INT NOT NULL,
    member_id INT NOT NULL,

    issue_date DATE DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,
    return_date DATE DEFAULT NULL,

    fine_amount DECIMAL(6,2) DEFAULT 0.00,

    CONSTRAINT book_reference
        FOREIGN KEY (book_id)
        REFERENCES Books(book_id),

    CONSTRAINT member_reference
        FOREIGN KEY (member_id)
        REFERENCES Members(member_id)
);


-- ===========================================================================================================================
-- INSERTING BOOK DATA
-- ===========================================================================================================================

INSERT INTO Books
(title, author, category, total_copies, available_copies, published_year)

VALUES
('Clean Code', 'Robert C. Martin', 'Programming', 5, 5, 2008),
('The Pragmatic Programmer', 'Andrew Hunt', 'Programming', 4, 4, 1999),
('Python Crash Course', 'Eric Matthes', 'Programming', 6, 6, 2015),
('Wings of Fire', 'A.P.J. Abdul Kalam', 'Autobiography', 5, 5, 1999),
('Ignited Minds', 'A.P.J. Abdul Kalam', 'Motivation', 4, 4, 2002),
('Gitanjali', 'Rabindranath Tagore', 'Poetry', 3, 3, 1910),
('Geetanjali', 'Rabindranath Tagore', 'Literature', 2, 2, 1910),
('Indian Polity', 'M. Laxmikanth', 'Politics', 7, 7, 2006),
('Into the Wild', 'Jon Krakauer', 'Adventure', 3, 3, 1996),
('The Call of the Wild', 'Jack London', 'Adventure', 4, 4, 1903);


-- ===========================================================================================================================
-- DISPLAY ALL BOOKS
-- ===========================================================================================================================

SELECT * FROM Books;


-- ===========================================================================================================================
-- INSERTING MEMBERS DATA
-- ===========================================================================================================================

INSERT INTO Members
(full_name, email, phone, address)

VALUES
('Naga Raj', 'nagaraj@gmail.com', '9652152992', 'Kandukur, Andhra Pradesh'),
('Naveen', 'naveen@gmail.com', '9123456780', 'Hyderabad, Telangana'),
('Vignesh', 'vignesh@gmail.com', '9852152992', 'Chennai, Tamil Nadu'),
('Pallavi', 'pallavi@gmail.com', '9871234560', 'Vijayawada, Andhra Pradesh'),
('Sowmya', 'sowmya@gmail.com', '7993173216', 'Bangalore, Karnataka'),
('Srinivasulu', 'srinivas@gmail.com', '7671877699', 'Tirupati, Andhra Pradesh'),
('Varun Raj', 'varun@gmail.com', '9887766554', 'Pune, Maharashtra'),
('Arjun Reddy', 'arjun@gmail.com', '9776655443', 'Delhi, India'),
('Chaitanya', 'chaitu@gmail.com', '9665544332', 'Hyderabad, Telangana'),
('Vamsi Raj', 'vamsi@gmail.com', '9554433221', 'Chittoor, Andhra Pradesh');


-- ===========================================================================================================================
-- DISPLAY ALL MEMBERS
-- ===========================================================================================================================

SELECT * FROM Members;


-- ===========================================================================================================================
-- INSERTING BORROWING RECORDS
-- ===========================================================================================================================

INSERT INTO Issued_Books
(book_id, member_id, issue_date, due_date, return_date, fine_amount)
VALUES
(1, 1, '2026-05-01', '2026-05-15', '2026-05-14', 0.00),
(2, 2, '2026-05-03', '2026-05-17', '2026-05-20', 15.00),
(3, 3, '2026-05-05', '2026-05-19', NULL, 0.00),
(4, 4, '2026-05-06', '2026-05-20', '2026-05-18', 0.00),
(5, 5, '2026-05-08', '2026-05-22', NULL, 0.00),
(6, 6, '2026-05-10', '2026-05-24', '2026-05-25', 5.00),
(7, 7, '2026-05-11', '2026-05-25', NULL, 0.00),
(8, 8, '2026-05-12', '2026-05-26', '2026-05-24', 0.00),
(9, 9, '2026-05-13', '2026-05-27', NULL, 0.00),
(10, 10, '2026-05-15', '2026-05-29', NULL, 0.00);


-- ===========================================================================================================================
-- DISPLAY ALL ISSUED BOOK RECORDS
-- ===========================================================================================================================

SELECT * FROM Issued_Books;


-- ===========================================================================================================================
-- QUERY 1 : DISPLAY PROGRAMMING BOOKS
-- ===========================================================================================================================

SELECT title, author
FROM Books
WHERE category = 'Programming';


-- ===========================================================================================================================
-- QUERY 2 : DISPLAY BOOKS NOT RETURNED
-- ===========================================================================================================================

SELECT *
FROM Issued_Books
WHERE return_date IS NULL;


-- ===========================================================================================================================
-- QUERY 3 : DISPLAY MEMBERS BORROW DETAILS
-- ===========================================================================================================================

SELECT
    Members.full_name,
    Books.title,
    Issued_Books.issue_date,
    Issued_Books.due_date

FROM Issued_Books

JOIN Members
ON Issued_Books.member_id = Members.member_id

JOIN Books
ON Issued_Books.book_id = Books.book_id;


-- ===========================================================================================================================
-- QUERY 4 : DISPLAY MEMBERS WITH FINES
-- ===========================================================================================================================

SELECT
    Members.full_name,
    Books.title,
    Issued_Books.fine_amount

FROM Issued_Books

JOIN Members
ON Issued_Books.member_id = Members.member_id

JOIN Books
ON Issued_Books.book_id = Books.book_id

WHERE fine_amount > 0;


-- ===========================================================================================================================
-- QUERY 5 : TOTAL BOOKS COUNT
-- ===========================================================================================================================

SELECT COUNT(*) AS Total_Books
FROM Books;


-- ============================================================================================================================
-- QUERY 6 : TOTAL MEMBERS COUNT
-- ============================================================================================================================

SELECT COUNT(*) AS Total_Members
FROM Members;


-- ============================================================================================================================
-- QUERY 7 : TOTAL BORROWED BOOKS COUNT
-- ============================================================================================================================

SELECT COUNT(*) AS Borrowed_Books
FROM Issued_Books;

-- =============================================================================================================================
-- PROJECT COMPLETED SUCCESSFULLY
-- =============================================================================================================================
-- Thank you for exploring the Library Management System.
-- This project demonstrates database design, relationships, data management, and SQL query operations using MySQL.
--
-- Features Implemented:
-- . Database Creation
-- . Table Relationships
-- . Data Insertion
-- . Book Borrowing System
-- . Fine Management
-- . Filtering and JOIN Queries
-- . Reports and Record Tracking
--
-- End of Project
-- =============================================================================================================================
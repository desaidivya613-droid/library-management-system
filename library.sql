CREATE DATABASE library_db;
USE library_db;
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(15),
    join_date DATE
);
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    author VARCHAR(50),
    category VARCHAR(50),
    available_copies INT
);
CREATE TABLE issued_books (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    issue_date DATE,
    return_date DATE,
    
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
desc members;
desc books;
desc issued_books;

INSERT INTO members (name, email, phone, join_date) VALUES
('Rahul Sharma', 'rahul@gmail.com', '9876543210', '2024-01-10'),
('Anita Verma', 'anita@gmail.com', '9123456780', '2024-02-15'),
('Karan Mehta', 'karan@gmail.com', '9988776655', '2024-03-20');

INSERT INTO books (title, author, category, available_copies) VALUES
('Database Systems', 'Korth', 'Education', 5),
('Python Basics', 'Guido', 'Programming', 3),
('Java Fundamentals', 'James Gosling', 'Programming', 4);

INSERT INTO issued_books (member_id, book_id, issue_date, return_date) VALUES
(1, 2, '2024-04-01', NULL),
(2, 1, '2024-04-02', NULL);

SELECT * FROM members;

SELECT * FROM books;

SELECT 
    m.name AS member_name,
    b.title AS book_title,
    i.issue_date,
    i.return_date
FROM issued_books i
JOIN members m ON i.member_id = m.member_id
JOIN books b ON i.book_id = b.book_id;

UPDATE issued_books
SET return_date = '2024-04-10'
WHERE issue_id = 1;

UPDATE books
SET available_copies = available_copies - 1
WHERE book_id = 2;

UPDATE books
SET available_copies = available_copies + 1
WHERE book_id = 2;

SELECT 
    m.name,
    b.title,
    i.issue_date
FROM issued_books i
JOIN members m ON i.member_id = m.member_id
JOIN books b ON i.book_id = b.book_id
WHERE i.return_date IS NULL;

DELETE FROM members
WHERE member_id = 3;

SELECT COUNT(*) AS total_books FROM books;

SELECT 
    b.title,
    COUNT(i.book_id) AS times_issued
FROM issued_books i
JOIN books b ON i.book_id = b.book_id
GROUP BY b.title
ORDER BY times_issued DESC
LIMIT 1;

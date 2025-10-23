
-- Library Management Database (MySQL)
-- Developed by Trupti Dongare

-- Create Database
CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- Create tables
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(50),
    category VARCHAR(50),
    publisher VARCHAR(50),
    available_copies INT DEFAULT 1
);

CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    phone VARCHAR(15),
    join_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE borrow_records (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    borrow_date DATE DEFAULT CURRENT_DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Sample data
INSERT INTO books (title, author, category, publisher, available_copies)
VALUES ('C Programming', 'Dennis Ritchie', 'Programming', 'Prentice Hall', 5),
       ('Java Basics', 'Herbert Schildt', 'Programming', 'McGraw-Hill', 3),
       ('HTML & CSS', 'Jon Duckett', 'Web Development', 'Wiley', 4);

INSERT INTO members (name, email, phone)
VALUES ('Trupti Dongare', 'trupti@example.com', '9876543210'),
       ('Rahul Sharma', 'rahul@example.com', '9123456780');

INSERT INTO borrow_records (book_id, member_id, borrow_date, return_date)
VALUES (1, 1, '2025-10-23', '2025-10-30'),
       (2, 2, '2025-10-20', '2025-10-27');

-- Indexes
CREATE INDEX idx_book_title ON books(title);
CREATE INDEX idx_member_name ON members(name);

-- Views
CREATE VIEW borrowed_books AS
SELECT b.title, m.name AS member_name, br.borrow_date, br.return_date
FROM borrow_records br
JOIN books b ON br.book_id = b.book_id
JOIN members m ON br.member_id = m.member_id;

-- Stored Procedure
DELIMITER //
CREATE PROCEDURE add_new_borrow(IN p_book_id INT, IN p_member_id INT, IN p_return_date DATE)
BEGIN
    INSERT INTO borrow_records(book_id, member_id, borrow_date, return_date)
    VALUES (p_book_id, p_member_id, CURDATE(), p_return_date);
    
    UPDATE books
    SET available_copies = available_copies - 1
    WHERE book_id = p_book_id;
END //
DELIMITER ;

-- Stored Function
DELIMITER //
CREATE FUNCTION available_books_count(p_book_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT available_copies INTO total
    FROM books
    WHERE book_id = p_book_id;
    RETURN total;
END //
DELIMITER ;

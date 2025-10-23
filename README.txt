
Library Management Database - Instructions

1. Install XAMPP (Windows): https://www.apachefriends.org/download.html
2. Start Apache and MySQL from XAMPP Control Panel.
3. Open browser -> http://localhost/phpmyadmin
4. Create a new database: library_db
5. Go to Import tab -> Choose file -> select library_db.sql from this folder -> Click Go
6. All tables, sample data, views, indexes, procedures, and functions will be created.
7. Test queries in phpMyAdmin SQL tab:
   - SELECT * FROM borrowed_books;
   - CALL add_new_borrow(1,2,'2025-11-10');
   - SELECT available_books_count(1);
8. Resume description:
   Library Management Database (MySQL) - Developed normalized tables, views, stored procedures, functions, indexes, and applied constraints.

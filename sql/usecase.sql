	use sql_usecase;

    -- creating tables(students,books,issuedbooks)
	CREATE TABLE students (
		student_id INT PRIMARY KEY AUTO_INCREMENT,
		name VARCHAR(100),
		email VARCHAR(100),
		created_at DATE,
		status VARCHAR(20)
	);

	CREATE TABLE books (
		book_id INT PRIMARY KEY AUTO_INCREMENT,
		title VARCHAR(150),
		author VARCHAR(100),
		category VARCHAR(50),
		total_copies INT
	);

	CREATE TABLE issuedbooks (
		issue_id INT PRIMARY KEY AUTO_INCREMENT,
		student_id INT,
		book_id INT,
		issuedate DATE,
		returndate DATE,
		FOREIGN KEY (student_id) REFERENCES students(student_id),
		FOREIGN KEY (book_id) REFERENCES books(book_id)
	);
    
    -- inserting values
	INSERT INTO books (title, author, category, total_copies) VALUES
    ('one piece', 'eiichiro oda', 'adventure', 15),
    ('naruto', 'masashi kishimoto', 'action', 12),
    ('attack on titan', 'hajime isayama', 'dark fantasy', 10),
    ('death note', 'tsugumi ohba', 'thriller', 8),
    ('demon slayer', 'koyoharu gotouge', 'fantasy', 9);

	INSERT INTO students (name, email, created_at, status) VALUES
	('sandeep', 'sandeep@gmail.com', '2022-01-10', 'active'),
	('rahul', 'rahul@gmail.com', '2021-05-15', 'active'),
	('anita', 'anita@gmail.com', '2020-03-20', 'active'),
	('kiran', 'kiran@gmail.com', '2019-07-11', 'active'),
	('meena', 'meena@gmail.com', '2023-02-01', 'active');

	INSERT INTO issuedbooks (student_id, book_id, issuedate, returndate) VALUES
	(1, 1, CURRENT_DATE - INTERVAL 20 DAY, NULL),   -- overdue
	(2, 2, CURRENT_DATE - INTERVAL 5 DAY, NULL),    -- not overdue
	(3, 3, CURRENT_DATE - INTERVAL 30 DAY, '2026-03-20'), -- returned
	(4, 4, CURRENT_DATE - INTERVAL 40 DAY, NULL),   -- overdue
	(5, 5, CURRENT_DATE - INTERVAL 2 DAY, NULL),    -- recent
	(1, 3, CURRENT_DATE - INTERVAL 10 DAY, NULL),
	(2, 1, CURRENT_DATE - INTERVAL 15 DAY, NULL);

	--overdue books(14 days or longer)
	SELECT 
		s.student_id,
		s.name,
		b.title,
		i.issuedate
	FROM issuedbooks i
	JOIN students s ON i.student_id = s.student_id
	JOIN books b ON i.book_id = b.book_id
	WHERE i.returndate IS NULL
	AND i.issuedate < CURRENT_DATE - INTERVAL 14 DAY;

	--penalty report
	SELECT 
		s.student_id,
		s.name,
		b.title,
		i.issuedate,
		DATEDIFF(CURRENT_DATE, i.issuedate) - 14 AS overdue_days,
		(DATEDIFF(CURRENT_DATE, i.issuedate) - 14) * 5 AS penalty
	FROM issuedbooks i
	JOIN students s ON i.student_id = s.student_id
	JOIN books b ON i.book_id = b.book_id
	WHERE i.returndate IS NULL
	AND i.issuedate < CURRENT_DATE - INTERVAL 14 DAY;

	--popularity index
	SELECT 
		b.category,
		COUNT(i.issue_id) AS total_borrows
	FROM issuedbooks i
	JOIN books b ON i.book_id = b.book_id
	GROUP BY b.category
	ORDER BY total_borrows DESC;

	--inactive students(more than 3 years)
	UPDATE students
    SET status = 'inactive'
    WHERE student_id IN (
    SELECT student_id FROM (
        SELECT s.student_id
        FROM students s
        LEFT JOIN issuedbooks i 
        ON s.student_id = i.student_id
        AND i.issuedate >= CURRENT_DATE - INTERVAL 3 YEAR
        WHERE i.student_id IS NULL
    ) AS temp
)
LIMIT 1000;










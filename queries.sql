-- Query 1: Retrieve all books and their authors
SELECT b.title, a.author_name
FROM books b
JOIN authors a ON b.author_id = a.author_id;

-- Query 2: Calculate the total number of books in each category
SELECT c.category_name, COUNT(bc.book_id) AS total_books
FROM categories c
LEFT JOIN book_categories bc ON c.category_id = bc.category_id
GROUP BY c.category_name;

-- Query 3: Find the top 5 bestselling books by quantity
SELECT b.title, SUM(oi.quantity) AS total_sold
FROM books b
JOIN order_items oi ON b.book_id = oi.book_id
GROUP BY b.title
ORDER BY total_sold DESC
LIMIT 5;

-- Query 4: Retrieve customers who have placed orders
SELECT DISTINCT c.first_name, c.last_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- Query 5: Calculate total sales revenue by month
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month_year, SUM(b.price * oi.quantity) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN books b ON oi.book_id = b.book_id
GROUP BY month_year
ORDER BY month_year;

-- Query 6: Find customers who have spent the most on books
SELECT c.first_name, c.last_name, SUM(b.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN books b ON oi.book_id = b.book_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 1;

-- Query 7: List books priced above $50
SELECT title, price
FROM books
WHERE price > 50;

-- Query 8: Retrieve books written by a specific author
SELECT b.title
FROM books b
JOIN authors a ON b.author_id = a.author_id
WHERE a.author_name = 'J.K. Rowling';

-- Query 9: Identify customers who have ordered a specific book
SELECT c.first_name, c.last_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.book_id = 1;

-- Query 10: Calculate average book price per category
SELECT c.category_name, AVG(b.price) AS avg_price
FROM categories c
JOIN book_categories bc ON c.category_id = bc.category_id
JOIN books b ON bc.book_id = b.book_id
GROUP BY c.category_name;

-- List Authors and Their Published Books:
SELECT a.author_name, GROUP_CONCAT(b.title ORDER BY b.title) AS published_books
FROM authors a
JOIN books b ON a.author_id = b.author_id
GROUP BY a.author_name;

-- Find Customers Who Have Not Placed Orders:
SELECT c.first_name, c.last_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- List Categories and Their Books:
SELECT c.category_name, GROUP_CONCAT(b.title ORDER BY b.title) AS books_in_category
FROM categories c
LEFT JOIN book_categories bc ON c.category_id = bc.category_id
LEFT JOIN books b ON bc.book_id = b.book_id
GROUP BY c.category_name;

-- Calculate Average Order Quantity:
SELECT AVG(oi.quantity) AS avg_order_quantity
FROM order_items oi;

-- Count Orders Placed Each Month:
SELECT YEAR(order_date) AS year, MONTH(order_date) AS month, COUNT(order_id) AS order_count
FROM orders
WHERE YEAR(order_date) = 2023  -- Specify the desired year
GROUP BY year, month
ORDER BY year, month;

-- Identify Categories with No Books:
SELECT c.category_name
FROM categories c
LEFT JOIN book_categories bc ON c



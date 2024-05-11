-- Query 1: Retrieve all books and their authors
SELECT title, author_name FROM books
JOIN authors ON books.author_id = authors.author_id;

-- Query 2: Calculate the total number of books in each category
SELECT categories.category_name, COUNT(book_categories.book_id) AS total_books FROM categories
LEFT JOIN book_categories ON categories.category_id = book_categories.category_id
GROUP BY categories.category_name;

-- Query 3: Find the top 5 bestselling books by quantity
SELECT books.title, SUM(order_items.quantity) AS total_sold FROM books
JOIN order_items ON books.book_id = order_items.book_id
GROUP BY books.title
ORDER BY total_sold DESC LIMIT 5;

-- Query 4: Retrieve customers who have placed orders
SELECT DISTINCT customers.first_name, customers.last_name
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id;

-- Query 5: Calculate total sales revenue by month
SELECT DATE_FORMAT(orders.order_date, '%Y-%m') AS month_year, SUM(books.price * order_items.quantity) AS total_revenue FROM orders
JOIN order_items ON orders.order_id = order_items.order_id
JOIN books ON order_items.book_id = books.book_id
GROUP BY month_year
ORDER BY month_year;

-- Query 6: Find customers who have spent the most on books
SELECT customers.first_name, customers.last_name, SUM(books.price * order_items.quantity) AS total_spent FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
JOIN books ON order_items.book_id = books.book_id
GROUP BY customers.customer_id
ORDER BY total_spent DESC
LIMIT 1;

-- Query 7: List books priced above $50
SELECT title, price FROM books
WHERE price > 50;

-- Query 8: Retrieve books written by a specific author
SELECT books.title FROM books
JOIN authors ON books.author_id = authors.author_id
WHERE authors.author_name = 'J.K. Rowling';

-- Query 9: Identify customers who have ordered a specific book
SELECT customers.first_name, customers.last_name FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
WHERE order_items.book_id = 1;

-- Query 10: Calculate average book price per category
SELECT categories.category_name, AVG(b.price) AS avg_price FROM categories
JOIN book_categories ON categories.category_id = book_categories.category_id
JOIN books ON book_categories.book_id = books.book_id
GROUP BY categories.category_name;

-- List Authors and Their Published Books:
SELECT authors.author_name, GROUP_CONCAT(books.title ORDER BY books.title) AS published_books FROM authors
JOIN books ON authors.author_id = books.author_id
GROUP BY authors.author_name;

-- Find Customers Who Have Not Placed Orders:
SELECT customers.first_name, customers.last_name FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.order_id IS NULL;

-- List Categories and Their Books:
SELECT categories.category_name, GROUP_CONCAT(books.title ORDER BY books.title) AS books_in_category FROM categories
LEFT JOIN book_categories ON categories.category_id = book_categories.category_id
LEFT JOIN books ON book_categories.book_id = books.book_id
GROUP BY categories.category_name;

-- Calculate Average Order Quantity:
SELECT AVG(quantity) AS avg_order_quantity FROM order_items;

-- Count Orders Placed Each Month:
SELECT YEAR(order_date) AS year, MONTH(order_date) AS month, COUNT(order_id) AS order_count
FROM orders
WHERE YEAR(order_date) = 2023  -- Specify the desired year
GROUP BY year, month
ORDER BY year, month;


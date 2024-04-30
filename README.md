# Bookstore-Database-Setup

This repository contains SQL scripts to create and manage a database schema for a bookstore application. The schema includes tables for authors, books, categories, customers, orders, and order items, along with foreign key relationships and indexes for efficient querying.

## Tables

### `authors`
- Stores information about authors of books.
  - `author_id`: Unique identifier for the author.
  - `author_name`: Name of the author.

### `books`
- Represents individual books available in the bookstore.
  - `book_id`: Unique identifier for the book.
  - `title`: Title of the book.
  - `author_id`: Foreign key linking the book to its author in the `authors` table.
  - `price`: Price of the book.

### `categories`
- Contains categories or genres of books.
  - `category_id`: Unique identifier for the category.
  - `category_name`: Name of the category.

### `book_categories`
- Acts as a linking table between books and categories, specifying which categories each book belongs to.
  - `book_id`: Foreign key referencing the `book_id` in the `books` table.
  - `category_id`: Foreign key referencing the `category_id` in the `categories` table.

### `customers`
- Stores information about bookstore customers.
  - `customer_id`: Unique identifier for the customer.
  - `first_name`: First name of the customer.
  - `last_name`: Last name of the customer.
  - `email`: Email address of the customer.

### `orders`
- Represents orders placed by customers.
  - `order_id`: Unique identifier for the order.
  - `customer_id`: Foreign key linking the order to the customer in the `customers` table.
  - `order_date`: Date when the order was placed.

### `order_items`
- Contains details of items included in each order.
  - `order_item_id`: Unique identifier for the order item.
  - `order_id`: Foreign key linking the order item to the order in the `orders` table.
  - `book_id`: Foreign key linking the order item to the book in the `books` table.
  - `quantity`: Quantity of the book purchased in the order.

## Indexes

- `idx_books_author_id`: Index on the `author_id` column of the `books` table for faster retrieval of books by author.
- `idx_book_categories_category_id`: Index on the `category_id` column of the `book_categories` table for efficient querying of book categories.
- `idx_order_items_book_id`: Index on the `book_id` column of the `order_items` table for quick access to order items by book.
- `idx_orders_customer_id`: Index on the `customer_id` column of the `orders` table for optimized queries related to customer orders.
- `idx_order_items_order_id`: Index on the `order_id` column of the `order_items` table for efficient retrieval of order items by order.
- `idx_book_categories_book_id`: Index on the `book_id` column of the `book_categories` table for faster querying of books by category.

## Views

### `book_details`
- Provides details of books including title, author name, and price by joining `books` and `authors` tables.

### `customer_order_history`
- Displays the order history of customers including order ID and order date by joining `customers` and `orders` tables.

### `customer_last_purchase`
- Shows the last purchase date for each customer by aggregating order dates using `MAX` function and grouping by customer.

## Usage

1. **Schema Creation**: Execute the provided SQL scripts (`schema.sql`) to create the database schema including tables, indexes, and views.
2. **Query Examples**: Explore the database schema and perform queries using the provided views (`book_details`, `customer_order_history`, `customer_last_purchase`) to retrieve relevant information about books, customers, and orders.

Feel free to use and modify this schema for your own bookstore application or database project. If you have any questions or suggestions, please feel free to reach out!

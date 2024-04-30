-- Create tables

CREATE TABLE `authors` (
  `author_id` INT AUTO_INCREMENT,
  `author_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`author_id`)
);

CREATE TABLE `books` (
  `book_id` INT AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `author_id` INT,
  `price` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`book_id`),
  FOREIGN KEY (`author_id`) REFERENCES `authors`(`author_id`)
);

CREATE TABLE `categories` (
  `category_id` INT AUTO_INCREMENT,
  `category_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`category_id`)
);

CREATE TABLE `book_categories` (
  `book_id` INT,
  `category_id` INT,
  PRIMARY KEY (`book_id`, `category_id`),
  FOREIGN KEY (`book_id`) REFERENCES `books`(`book_id`),
  FOREIGN KEY (`category_id`) REFERENCES `categories`(`category_id`)
);

CREATE TABLE `customers` (
  `customer_id` INT AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`customer_id`)
);

CREATE TABLE `orders` (
  `order_id` INT AUTO_INCREMENT,
  `customer_id` INT,
  `order_date` DATE NOT NULL,
  PRIMARY KEY (`order_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `customers`(`customer_id`)
);

CREATE TABLE `order_items` (
  `order_item_id` INT AUTO_INCREMENT,
  `order_id` INT,
  `book_id` INT,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`order_item_id`),
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`order_id`),
  FOREIGN KEY (`book_id`) REFERENCES `books`(`book_id`)
);

-- Create indexes

CREATE INDEX `idx_books_author_id` ON `books` (`author_id`);
CREATE INDEX `idx_book_categories_category_id` ON `book_categories` (`category_id`);
CREATE INDEX `idx_order_items_book_id` ON `order_items` (`book_id`);
CREATE INDEX `idx_orders_customer_id` ON `orders` (`customer_id`);
CREATE INDEX `idx_order_items_order_id` ON `order_items` (`order_id`);
CREATE INDEX `idx_book_categories_book_id` ON `book_categories` (`book_id`);

-- Create views

CREATE VIEW `book_details` AS
SELECT `books`.`book_id`, `books`.`title`, `authors`.`author_name`, `books`.`price`
FROM `books`
JOIN `authors` ON `books`.`author_id` = `authors`.`author_id`;

CREATE VIEW `customer_order_history` AS
SELECT `customers`.`customer_id`, `customers`.`first_name`, `customers`.`last_name`, `orders`.`order_id`, `orders`.`order_date`
FROM `customers`
JOIN `orders` ON `customers`.`customer_id` = `orders`.`customer_id`;

CREATE VIEW `customer_last_purchase` AS
SELECT `customers`.`customer_id`, `customers`.`first_name`, `customers`.`last_name`, MAX(`orders`.`order_date`) AS `last_purchase_date`
FROM `customers`
JOIN `orders` ON `customers`.`customer_id` = `orders`.`customer_id`
GROUP BY `customers`.`customer_id`;

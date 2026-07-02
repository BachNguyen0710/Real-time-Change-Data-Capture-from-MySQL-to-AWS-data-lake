CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

CREATE TABLE IF NOT EXISTS orders (
    order_id      BIGINT PRIMARY KEY AUTO_INCREMENT,
    customer_id   BIGINT NOT NULL,
    product_id    BIGINT NOT NULL,
    quantity      INT NOT NULL,
    price         DECIMAL(10,2) NOT NULL,
    status        VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
                  ON UPDATE CURRENT_TIMESTAMP
);

-- Seed data mẫu
INSERT INTO orders (customer_id, product_id, quantity, price, status)
VALUES
    (101, 501, 2, 199.99, 'PENDING'),
    (102, 502, 1, 49.50,  'PAID'),
    (103, 503, 3, 15.00,  'PENDING');

-- Tạo user riêng cho Debezium, có quyền replication
-- (sẽ dùng ở bước 3, tạo sẵn luôn cho tiện)
CREATE USER IF NOT EXISTS 'debezium'@'%' IDENTIFIED BY 'debezium123';
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT
    ON *.* TO 'debezium'@'%';
FLUSH PRIVILEGES;
-- Tạo bảng
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id VARCHAR(100),
    order_date DATE,
	total_amount INT
);

-- Tạo B-Tree Index trên customer_id
CREATE INDEX idx_orders_customer_id
ON Orders USING BTREE (customer_id);

-- Truy vấn sau khi tạo index
EXPLAIN ANALYZE
SELECT *
FROM Orders
WHERE customer_id = 1;
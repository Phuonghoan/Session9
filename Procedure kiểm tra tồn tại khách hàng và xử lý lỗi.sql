-- Tạo bảng
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    amount INT,
	order_date DATE,
	FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Tạo Procedure
CREATE OR REPLACE PROCEDURE add_order(
    IN p_customer_id INT,
    IN p_amount NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM Customers
        WHERE customer_id = p_customer_id
    ) THEN
        RAISE EXCEPTION 'Customer ID % does not exist', p_customer_id;
    END IF;

    INSERT INTO Orders (customer_id, amount, order_date)
    VALUES (p_customer_id, p_amount, CURRENT_DATE);
END;
$$;

-- Gọi thử
CALL add_order(1, 500000);

-- Kiểm tra
SELECT * FROM Orders;
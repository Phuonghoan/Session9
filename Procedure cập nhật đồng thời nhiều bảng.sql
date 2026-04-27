-- Tạo bảng
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    total_spent VARCHAR(100)
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    total_amount INT,
	FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Tạo Procedure
CREATE OR REPLACE PROCEDURE add_order_and_update_customer(
    IN p_customer_id INT,
    IN p_amount NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_customer_exists INT;
BEGIN
    -- Kiểm tra khách hàng có tồn tại không
    SELECT COUNT(*)
    INTO v_customer_exists
    FROM Customers
    WHERE customer_id = p_customer_id;

    IF v_customer_exists = 0 THEN
        RAISE EXCEPTION 'Customer ID % does not exist', p_customer_id;
    END IF;

    -- Thêm đơn hàng mới
    INSERT INTO Orders (customer_id, total_amount)
    VALUES (p_customer_id, p_amount);

    -- Cập nhật total_spent của khách hàng
    UPDATE Customers
    SET total_spent = COALESCE(total_spent, 0) + p_amount
    WHERE customer_id = p_customer_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to add order and update customer: %', SQLERRM;
END;
$$;

-- Gọi thử Procedure
CALL add_order_and_update_customer(1, 500000);

-- Kiểm tra kết quả
SELECT * FROM Orders;
SELECT * FROM Customers;
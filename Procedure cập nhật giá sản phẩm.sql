-- Tạo bảng
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC,
	category_id SERIAL
);

-- Tạo Procedure
CREATE OR REPLACE PROCEDURE update_product_price(
    IN p_category_id INT,
    IN p_increase_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_product RECORD;
    v_new_price NUMERIC;
BEGIN
    FOR v_product IN
        SELECT product_id, price
        FROM Products
        WHERE category_id = p_category_id
    LOOP
        v_new_price := v_product.price + (v_product.price * p_increase_percent / 100);

        UPDATE Products
        SET price = v_new_price
        WHERE product_id = v_product.product_id;
    END LOOP;
END;
$$;

-- Gọi thử Procedure
CALL update_product_price(1, 10);

-- Kiểm tra kết quả
SELECT * FROM Products;
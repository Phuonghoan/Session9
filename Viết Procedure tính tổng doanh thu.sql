-- Tạo bảng
CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id SERIAL,
    amount INT,
	sale_date DATE
);

-- Tạo procedure
CREATE OR REPLACE PROCEDURE calculate_total_sales (
	IN start_date DATE,
	IN end_date DATE,
	OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN 
	SELECT SUM(amount, 0)
	INTO total
	FROM Sales
	WHERE sale_date BETWEEN start_date AND end_date;
END;
$$;

-- Gọi Procedure
CALL calculate_total_sales('2024-01-01', '2024-12-31', NULL);
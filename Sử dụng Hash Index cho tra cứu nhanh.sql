-- Tạo bảng
CREATE TABLE Users (
    users_id SERIAL PRIMARY KEY,
    email VARCHAR(100),
    username VARCHAR(100)
);

-- Tạo Hash Index trên cột email
CREATE INDEX idx_users_email_hash
ON Users USING HASH (email);

-- Truy vấn và kiểm tra kế hoạch thực hiện
EXPLAIN
SELECT *
FROM Users
WHERE email = 'a@gmail.com';
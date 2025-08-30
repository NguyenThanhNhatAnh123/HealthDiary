-- Health Diary Database Setup
-- Run this script to create the necessary database and tables

CREATE DATABASE IF NOT EXISTS health_diary;
USE health_diary;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    age INT,
    height_cm DOUBLE,
    weight_kg DOUBLE,
    goal VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Meals table
CREATE TABLE IF NOT EXISTS meals (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    meal_time VARCHAR(50) NOT NULL,
    log_date DATE NOT NULL,
    total_calories INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Meal items table
CREATE TABLE IF NOT EXISTS meal_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    meal_id INT NOT NULL,
    food_name VARCHAR(255) NOT NULL,
    calories INT NOT NULL,
    image VARCHAR(500),
    quantity DOUBLE DEFAULT 1.0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (meal_id) REFERENCES meals(id) ON DELETE CASCADE
);

-- Food samples table
CREATE TABLE IF NOT EXISTS food_samples (
    id INT PRIMARY KEY AUTO_INCREMENT,
    food_name VARCHAR(255) NOT NULL,
    calories_per_100g INT NOT NULL,
    protein_per_100g DOUBLE DEFAULT 0,
    carbs_per_100g DOUBLE DEFAULT 0,
    fat_per_100g DOUBLE DEFAULT 0,
    image VARCHAR(500)
);

-- Insert some sample food data
INSERT IGNORE INTO food_samples (food_name, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g) VALUES
('Cơm trắng', 130, 2.7, 25.6, 1.0),
('Trứng luộc', 155, 20.0, 0.0, 13.0),
('Cá hồi', 250, 20.0, 0.0, 13.0),
('Salad rau', 80, 4.7, 11.2, 0.6),
('Táo', 52, 0.3, 14.0, 0.2);

-- Set MySQL root password (run separately if needed)
-- ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123';
-- FLUSH PRIVILEGES;
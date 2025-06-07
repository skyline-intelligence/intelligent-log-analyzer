-- Create database first
CREATE DATABASE IF NOT EXISTS analyzer_database;

-- Create users with proper permissions
CREATE USER IF NOT EXISTS 'mysql'@'%' IDENTIFIED BY 'mysql';
CREATE USER IF NOT EXISTS 'mysql'@'localhost' IDENTIFIED BY 'mysql';

-- Grant all privileges on the specific database to the users
GRANT ALL PRIVILEGES ON analyzer_database.* TO 'mysql'@'%';
GRANT ALL PRIVILEGES ON analyzer_database.* TO 'mysql'@'localhost';

-- Flush privileges to apply changes
FLUSH PRIVILEGES;
CREATE DATABASE hostelmanagement;
USE hostelmanagement;

CREATE TABLE role_mst (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  role_name VARCHAR(100) NOT NULL,
  role_desc VARCHAR(100),
  view_complaints BIT DEFAULT 0,
  manage_complaints BIT DEFAULT 0,
  view_food_requests BIT DEFAULT 0,
  approve_food_requests BIT DEFAULT 0
);

CREATE TABLE user_mst (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  login_id VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(200),
  role_id BIGINT NOT NULL,
  FOREIGN KEY (role_id) REFERENCES role_mst(id)
);

CREATE TABLE room_mst (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  room_type VARCHAR(100) NOT NULL,
  capacity INT NOT NULL,
  location VARCHAR(100) NOT NULL
);

CREATE TABLE complaint_mst (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  student_id BIGINT NOT NULL,
  category VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  status ENUM('Pending', 'In Progress', 'Resolved') DEFAULT 'Pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES user_mst(id)
);

CREATE TABLE food_request_mst (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  student_id BIGINT NOT NULL,
  room_number VARCHAR(10) NOT NULL,
  food_type VARCHAR(100) NOT NULL,
  status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
  request_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES user_mst(id)
);

INSERT INTO role_mst (id, role_name, role_desc, view_complaints, manage_complaints, view_food_requests, approve_food_requests)
VALUES (1, 'Admin', 'Administrator', 1, 1, 1, 1),
       (2, 'Student', 'Hostel Resident', 1, 0, 1, 0),
       (3, 'Warden', 'Hostel Warden', 1, 1, 1, 1),
       (4, 'Maintenance Staff', 'Handles complaints', 1, 1, 0, 0);

INSERT INTO user_mst (id, login_id, password, name, role_id)
VALUES (1, 'admin', 'admin123', 'Admin User', 1),
       (2, 'student1', 'student123', 'Student One', 2),
       (3, 'warden1', 'warden123', 'Warden One', 3),
       (4, 'staff1', 'staff123', 'Maintenance Staff', 4);

INSERT INTO room_mst (id, name, room_type, capacity, location)
VALUES (1, 'Room 101', 'AC', 2, 'Block A'),
       (2, 'Room 102', 'Non-AC', 3, 'Block B');

INSERT INTO complaint_mst (student_id, category, description, status)
VALUES (2, 'Plumbing Issue', 'Water leakage in Room 101', 'Pending');

INSERT INTO food_request_mst (student_id, room_number, food_type, status)
VALUES (2, '101', 'Vegetarian', 'Pending');

INSERT INTO food_request_mst (student_id, room_number, food_type, status)
VALUES (2, '101', 'Vegetarian', 'Pending');
SELECT * FROM user_mst WHERE id = 2;

SELECT * FROM role_mst;
SELECT * FROM user_mst;
SELECT * FROM room_mst;
SELECT * FROM complaint_mst;
SELECT * FROM food_request_mst;


DELETE FROM food_request_mst
WHERE id = 2
  AND room_number = 101
  AND food_type = 'Vegetarian'
  AND status = 'Pending'
  AND request_time = '2025-03-23 18:47:37';
INSERT INTO food_request_mst (student_id, room_number, food_type, status)
VALUES (4, '401', 'NONVegetarian', 'Pending');

UPDATE user_mst 
SET password = 'admin123' WHERE login_id = 'admin';

UPDATE user_mst 
SET password = 'student123' WHERE login_id = 'student1';

UPDATE user_mst 
SET password = 'warden123' WHERE login_id = 'warden1';

UPDATE user_mst 
SET password = 'staff123' WHERE login_id = 'staff1';
SELECT login_id, password FROM user_mst;

INSERT INTO user_mst (id, login_id, password, name, role_id) 
VALUES (5, 'staff2', 'staff123', 'Maintenance Staff', 4);
SELECT * FROM user_mst WHERE login_id = 'staff1';
SELECT * FROM role_mst WHERE role_name = 'Warden';

CREATE TABLE roommate_preferences (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT NOT NULL UNIQUE,
    sleep_schedule VARCHAR(50) NOT NULL,
    cleanliness VARCHAR(50) NOT NULL,
    study_habits VARCHAR(50) NOT NULL,
    hobbies VARCHAR(255) NOT NULL,
    dietary VARCHAR(50) NOT NULL,
    sleeping_preference VARCHAR(20) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES user_mst(id)
);
INSERT INTO roommate_preferences (student_id, sleep_schedule, cleanliness, study_habits, hobbies, dietary, sleeping_preference)
VALUES 
(2, 'Night Owl', 'Tidy', 'Group Study', 'Gaming', 'Vegetarian', 'Heavy Sleeper'),
(3, 'Early Bird', 'Messy', 'Solo Study', 'Reading', 'Non-Vegetarian', 'Light Sleeper'),
(4, 'Night Owl', 'Tidy', 'Group Study', 'Sports', 'Vegetarian', 'Heavy Sleeper'),
(5, 'Early Bird', 'Tidy', 'Solo Study', 'Music', 'Vegan', 'Light Sleeper');

select * from roommate_preferences;
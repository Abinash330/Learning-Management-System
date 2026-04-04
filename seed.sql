USE lms;

-- Find a faculty to assign courses, or insert one
INSERT IGNORE INTO user_master (name, email, mobile, password, role, status) VALUES ('Prof. Smith', 'faculty@example.com', '1234567890', 'password', 'FACULTY', 1);

-- Insert dummy courses
INSERT IGNORE INTO courses (title, description, instructor_id) VALUES 
('Advanced Java Programming', 'Learn advanced Streams, Lambdas and Collections.', (SELECT id FROM user_master WHERE role='FACULTY' LIMIT 1)),
('Modern JavaScript (ES6+)', 'Async/await, ES6 syntax, and more.', (SELECT id FROM user_master WHERE role='FACULTY' LIMIT 1)),
('React JS for Beginners', 'Introduction to React components and hooks.', (SELECT id FROM user_master WHERE role='FACULTY' LIMIT 1)),
('Spring Boot Microservices', 'Learn how to build scalable microservices.', (SELECT id FROM user_master WHERE role='FACULTY' LIMIT 1));

-- Enroll the teststudent into some courses
INSERT IGNORE INTO enrollments (student_id, course_id, enrollment_date) 
SELECT u.id, c.id, CURDATE()
FROM user_master u
JOIN courses c ON c.title IN ('Advanced Java Programming', 'Modern JavaScript (ES6+)', 'React JS for Beginners')
WHERE u.email = 'teststudent@example.com';

-- ============================================================
-- EduPro LMS — New Features DB Migration (Fixed)
-- ============================================================

USE lms;

-- ─── 1. Add progress column to enrollments (safe) ───────────
ALTER TABLE enrollments ADD COLUMN progress INT DEFAULT 0 COMMENT '0-100 percentage';

-- ─── 2. Assignments table ────────────────────────────────────
CREATE TABLE IF NOT EXISTS assignments (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    course_id   INT NOT NULL,
    title       VARCHAR(255) NOT NULL,
    description TEXT,
    due_date    DATE,
    created_by  INT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

-- ─── 3. Assignment Submissions ───────────────────────────────
CREATE TABLE IF NOT EXISTS assignment_submissions (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    assignment_id INT NOT NULL,
    student_id    INT NOT NULL,
    answer        TEXT,
    submitted_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    marks         INT DEFAULT NULL,
    feedback      TEXT DEFAULT NULL,
    status        ENUM('submitted','graded') DEFAULT 'submitted',
    FOREIGN KEY (assignment_id) REFERENCES assignments(id) ON DELETE CASCADE
);

SELECT 'Migration complete!' AS status;

CREATE TABLE Students (
    student_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100)
);

CREATE TABLE Exams (
    exam_id NUMBER PRIMARY KEY,
    subject VARCHAR2(100),
    exam_date DATE
);

CREATE TABLE Questions (
    question_id NUMBER PRIMARY KEY,
    exam_id NUMBER,
    question_text CLOB,
    marks NUMBER,
    FOREIGN KEY (exam_id) REFERENCES Exams(exam_id)
);

CREATE TABLE Results (
    result_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    exam_id NUMBER,
    total_marks NUMBER,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (exam_id) REFERENCES Exams(exam_id)
);

CREATE TABLE Notifications (
    notification_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    message CLOB,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- Insert data into Students table
INSERT INTO Students (student_id, name, email) VALUES 
(1, 'Aarav Sharma', 'aarav.sharma@example.com'),
INSERT INTO Students (student_id, name, email) VALUES (2, 'Vihaan Verma', 'vihaan.verma@example.com'),
INSERT INTO Students (student_id, name, email) VALUES (3, 'Ananya Iyer', 'ananya.iyer@example.com'),
INSERT INTO Students (student_id, name, email) VALUES (4, 'Mira Rao', 'mira.rao@example.com'),
INSERT INTO Students (student_id, name, email) VALUES (5, 'Arjun Kapoor', 'arjun.kapoor@example.com'),
INSERT INTO Students (student_id, name, email) VALUES (6, 'Priya Patel', 'priya.patel@example.com'),
INSERT INTO Students (student_id, name, email) VALUES (7, 'Riya Singh', 'riya.singh@example.com'),
INSERT INTO Students (student_id, name, email) VALUES (8, 'Kunal Joshi', 'kunal.joshi@example.com'),
INSERT INTO Students (student_id, name, email) VALUES (9, 'Tara Nair', 'tara.nair@example.com'),
INSERT INTO Students (student_id, name, email) VALUES (10, 'Aditya Malhotra', 'aditya.malhotra@example.com');

-- Insert data into Exams table
INSERT INTO Exams (exam_id, subject, exam_date) VALUES 
(1, 'Mathematics', TO_DATE('2025-01-20', 'YYYY-MM-DD')),
INSERT INTO Exams (exam_id, subject, exam_date) VALUES (2, 'Science', TO_DATE('2025-01-22', 'YYYY-MM-DD'));

-- Insert data into Questions table
INSERT INTO Questions (question_id, exam_id, question_text, marks) VALUES 
(1, 1, 'What is 2+2?', 5),
INSERT INTO Questions (question_id, exam_id, question_text, marks) VALUES (2, 1, 'What is the square root of 16?', 10),
INSERT INTO Questions (question_id, exam_id, question_text, marks) VALUES (3, 2, 'What is H2O?', 5),
INSERT INTO Questions (question_id, exam_id, question_text, marks) VALUES (4, 2, 'Describe the process of photosynthesis.', 10);

-- Insert data into Results table
 
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (1, 1, 1, 15, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (2, 1, 2, 12, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (3, 2, 1, 12, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (4, 2, 2, 14, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (5, 3, 1, 9, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (6, 3, 2, 11, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (7, 4, 1, 8, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (8, 4, 2, 10, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (9, 5, 1, 14, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (10, 5, 2, 12, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (11, 6, 1, 11, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (12, 6, 2, 13, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (13, 7, 1, 13, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (14, 7, 2, 15, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (15, 8, 1, 10, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (16, 8, 2, 14, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (17, 9, 1, 7, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (18, 9, 2, 10, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (19, 10, 1, 13, NULL),
INSERT INTO Results (result_id, student_id, exam_id, total_marks, grade) VALUES (20, 10, 2, 14, NULL);

-- Insert data into Notifications table

-- Notifications will be populated by triggers
-- View to show the total marks and grade of each student in each exam
CREATE OR REPLACE VIEW Student_Exam_Marks AS
SELECT 
    r.student_id, 
    r.exam_id, 
    r.total_marks, 
    CASE
        WHEN r.total_marks >= 15 THEN 'A'
        WHEN r.total_marks >= 12 THEN 'B'
        WHEN r.total_marks >= 9 THEN 'C'
        ELSE 'D'
    END AS grade
FROM Results r;

CREATE OR REPLACE PROCEDURE Generate_Grade IS
BEGIN
    FOR r IN (SELECT result_id, total_marks FROM Results) LOOP
        UPDATE Results
        SET grade = 
            CASE 
                WHEN r.total_marks >= 15 THEN 'A'
                WHEN r.total_marks >= 12 THEN 'B'
                WHEN r.total_marks >= 9 THEN 'C'
                ELSE 'D'
            END
        WHERE result_id = r.result_id;
    END LOOP;
    
    COMMIT;
END;
BEGIN
    Generate_Grade;
END;
/





select * from results;
select * from exams;
select * from notifications;



SELECT 
    s.name AS student_name,
    e.subject AS exam_subject,
    r.total_marks,
    r.grade
FROM Results r
JOIN Students s ON r.student_id = s.student_id
JOIN Exams e ON r.exam_id = e.exam_id
ORDER BY e.exam_id, r.student_id;

SELECT 
    e.subject,
    AVG(r.total_marks) AS average_marks
FROM Results r
JOIN Exams e ON r.exam_id = e.exam_id
GROUP BY e.subject
ORDER BY e.subject;

SELECT 
    s.name AS student_name,
    e.subject AS exam_subject,
    r.total_marks,
    RANK() OVER (PARTITION BY e.exam_id ORDER BY r.total_marks DESC) AS rank
FROM Results r
JOIN Students s ON r.student_id = s.student_id
JOIN Exams e ON r.exam_id = e.exam_id
WHERE RANK() OVER (PARTITION BY e.exam_id ORDER BY r.total_marks DESC) <= 5
ORDER BY e.subject, rank;


CREATE SEQUENCE notification_id_seq
START WITH 1
INCREMENT BY 1
NOCACHE NOCYCLE;


CREATE OR REPLACE TRIGGER trg_Notify_Marks_Change
AFTER UPDATE OF total_marks ON Results
FOR EACH ROW
DECLARE
    v_student_name VARCHAR2(100);
    v_exam_subject VARCHAR2(100);
    v_message CLOB;
BEGIN
    -- Fetch the student's name and the exam's subject into variables
    SELECT s.name, e.subject
    INTO v_student_name, v_exam_subject
    FROM Students s
    JOIN Exams e ON e.exam_id = :NEW.exam_id
    WHERE s.student_id = :NEW.student_id;

    -- Prepare the notification message
    v_message := 'Dear ' || v_student_name || 
                 ', your marks for exam ' || v_exam_subject ||
                 ' have been updated to ' || :NEW.total_marks || '.';

    -- Insert into Notifications table with a unique notification_id from sequence
    INSERT INTO Notifications (notification_id, student_id, message)
    VALUES (notification_id_seq.NEXTVAL, :NEW.student_id, v_message);

END;
/

UPDATE Results
SET total_marks = 18
WHERE student_id = 1 AND exam_id = 1;


SELECT * FROM Notifications WHERE student_id = 1;





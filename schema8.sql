CREATE TABLE student
(
    student_id INT PRIMARY KEY,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    birth_day DATE NOT NULL,
    sex VARCHAR(1) NOT NULL,
    student_email_address VARCHAR(40) NOT NULL UNIQUE,
    student_password VARCHAR(10) NOT NULL UNIQUE,
    student_nick_name VARCHAR(10) NOT NULL,
    student_qualification VARCHAR(10) NOT NULL,
    student_documents VARCHAR(255) NOT NULL,
    student_image VARCHAR(100) NOT NULL

);


CREATE TABLE student_feedback
(
    sr_no BIGSERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    feedback_type VARCHAR(10) NOT NULL,
    feedback_text VARCHAR(200) NOT NULL,
    is_response INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id)


);

CREATE TABLE online_exam
(
    exam_id INT PRIMARY KEY,
    exam_title VARCHAR(20) UNIQUE NOT NULL,
    exam_duration_min INT NOT NULL,
    total_questions INT NOT NULL,
    marks_per_right_answer INT NOT NULL,
    marks_per_wrong_answer INT NOT NULL,
    passing_marks INT NOT NULL,
    exam_status VARCHAR(2)
);


CREATE TABLE exam_subjects
(
    sub_id INT UNIQUE,
    exam_id INT UNIQUE,
    sub_name VARCHAR(20) NOT NULL,
    sub_desc VARCHAR(20) NOT NULL,
    PRIMARY KEY(sub_id,exam_id),
    FOREIGN KEY (exam_id) REFERENCES online_exam(exam_id) ON DELETE CASCADE

);

CREATE TABLE sub_questions
(
    sub_id1 INT UNIQUE,
    ques_id INT UNIQUE,
    ques_text VARCHAR(150) NOT NULL,
    ques_attachments VARCHAR(255),
    option_1 VARCHAR(20) NOT NULL,
    option_2 VARCHAR(20) NOT NULL,
    option_3 VARCHAR(20) NOT NULL,
    option_4 VARCHAR(20) NOT NULL,
    PRIMARY KEY (sub_id1,ques_id),
    FOREIGN KEY (sub_id1) REFERENCES exam_subjects(sub_id) ON DELETE CASCADE

);


CREATE TABLE ques_answers
(
    ans_id INT UNIQUE,
    ques_id INT UNIQUE,
    ans VARCHAR(20) NOT NULL,
    PRIMARY KEY (ans_id,ques_id),
    FOREIGN KEY (ques_id) REFERENCES sub_questions(ques_id) ON DELETE CASCADE

);



CREATE TABLE exam_registration
(
    student_id INT UNIQUE,
    exam_id INT UNIQUE,
    exam_date_time TIMESTAMP NOT NULL,
    PRIMARY KEY (student_id,exam_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (exam_id) REFERENCES online_exam(exam_id) ON DELETE CASCADE

);

CREATE TABLE exam_result
(
    student_id INT,
    exam_id INT,
    sub_id INT,
    marks_scored INT NOT NULL,
    correct_ques INT NOT NULL,
    wrong_ques INT NOT NULL,
    grade VARCHAR(10) NOT NULL,
    attempt_date_time TIMESTAMP NOT NULL,
    PRIMARY KEY(student_id,exam_id,sub_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (exam_id) REFERENCES online_exam(exam_id) ON DELETE CASCADE,
    FOREIGN KEY (sub_id) REFERENCES  exam_subjects(sub_id) ON DELETE CASCADE


);





CREATE TABLE admin
(
    admin_id INT PRIMARY KEY,
    admin_email_address VARCHAR(50) NOT NULL,
    admin_password VARCHAR(12) NOT NULL,
    admin_type VARCHAR(10) NOT NULL,
    admin_created_on DATE NOT NULL
);
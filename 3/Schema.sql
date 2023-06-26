-- create a tables
CREATE TABLE 'classroom_types' (
  'specific_id' INT NOT NULL,
  'name' VARCHAR(45) NOT NULL,
  PRIMARY KEY ('specific_id'));

CREATE TABLE 'classrooms' (
  'classroom_id' INT NOT NULL,
  'name' VARCHAR(45) NOT NULL,
  'specific' INT NOT NULL,
  'desks_num' INT NULL,
  PRIMARY KEY ('classroom_id'),
  CONSTRAINT 'fk_classrooms_classroom_types'
    FOREIGN KEY ('specific')
    REFERENCES 'classroom_types' ('specific_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE 'subjects' (
  'subject_id' INT NOT NULL,
  'name' VARCHAR(45) NOT NULL,
  'classroom_specific' INT NOT NULL,
  PRIMARY KEY ('subject_id'),
  CONSTRAINT 'fk_subjects_classroom_types1'
    FOREIGN KEY ('classroom_specific')
    REFERENCES 'classroom_types' ('specific_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE 'student' (
  'student_id' INT NOT NULL,
  'first_name' VARCHAR(45) NOT NULL,
  'last_name' VARCHAR(45) NOT NULL,
  'birth_date' DATE NOT NULL,
  'class_number' INT NOT NULL,
  'class_letter' VARCHAR(45) NOT NULL,
  PRIMARY KEY ('student_id'));

CREATE TABLE 'seating_arrangements' (
  'subject' INT NOT NULL,
  'student' INT NOT NULL,
  'row' INT NOT NULL,
  'desk' INT NOT NULL,
  'variant' INT NOT NULL,
  CONSTRAINT 'fk_seating_arrangements_student1'
    FOREIGN KEY ('student')
    REFERENCES 'student' ('student_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 'fk_seating_arrangements_subjects1'
    FOREIGN KEY ('subject')
    REFERENCES 'subjects' ('subject_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE 'lessons' (
  'lesson_id' INT NOT NULL,
  'subject' INT NOT NULL,
  'classroom' INT NOT NULL,
  'start_lesson' TIMESTAMP NOT NULL,
  'end_lesson' TIMESTAMP NULL,
  'class_number' INT NOT NULL,
  'class_letter' VARCHAR(45) NOT NULL,
  PRIMARY KEY ('lesson_id'),
  CONSTRAINT 'fk_lessons_subjects1'
    FOREIGN KEY ('subject')
    REFERENCES 'subjects' ('subject_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 'fk_lessons_classrooms1'
    FOREIGN KEY ('classroom')
    REFERENCES 'classrooms' ('classroom_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE 'attendance' (
  'lesson' INT NOT NULL,
  'absent_student' INT NOT NULL,
  'reason' VARCHAR(45) NULL,
  CONSTRAINT 'fk_attendance_lessons1'
    FOREIGN KEY ('lesson')
    REFERENCES 'lessons' ('lesson_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 'fk_attendance_student1'
    FOREIGN KEY ('absent_student')
    REFERENCES 'student' ('student_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- insert some values
INSERT INTO 'classroom_types' ('specific_id', 'name') VALUES (1, 'Физика');
INSERT INTO 'classroom_types' ('specific_id', 'name') VALUES (2, 'Химия');
INSERT INTO 'classroom_types' ('specific_id', 'name') VALUES (3, 'Общий');

INSERT INTO 'classrooms' ('classroom_id', 'name', 'specific', 'desks_num') VALUES (1, '1', 2, 20);
INSERT INTO 'classrooms' ('classroom_id', 'name', 'specific', 'desks_num') VALUES (2, '2', 3, 20);
INSERT INTO 'classrooms' ('classroom_id', 'name', 'specific', 'desks_num') VALUES (3, '3', 1, 20);

INSERT INTO 'subjects' ('subject_id', 'name', 'classroom_specific') VALUES (1, 'Химия', 2);
INSERT INTO 'subjects' ('subject_id', 'name', 'classroom_specific') VALUES (2, 'Физика', 1);
INSERT INTO 'subjects' ('subject_id', 'name', 'classroom_specific') VALUES (3, 'Литература', 3);

INSERT INTO 'student' ('student_id', 'first_name', 'last_name', 'birth_date', 'class_number', 'class_letter') VALUES (1, 'Марина', 'Петрова', '2013.06.10', 3, 'А');
INSERT INTO 'student' ('student_id', 'first_name', 'last_name', 'birth_date', 'class_number', 'class_letter') VALUES (2, 'Василий', 'Иванов', '2013.05.01', 3, 'А');
INSERT INTO 'student' ('student_id', 'first_name', 'last_name', 'birth_date', 'class_number', 'class_letter') VALUES (3, 'Светлана', 'Попова', '2013.11.20', 3, 'А');

INSERT INTO 'seating_arrangements' ('subject', 'student', 'row', 'desk', 'variant') VALUES (1, 1, 1, 1, 1);
INSERT INTO 'seating_arrangements' ('subject', 'student', 'row', 'desk', 'variant') VALUES (2, 1, 1, 1, 2);
INSERT INTO 'seating_arrangements' ('subject', 'student', 'row', 'desk', 'variant') VALUES (3, 1, 1, 2, 1);
INSERT INTO 'seating_arrangements' ('subject', 'student', 'row', 'desk', 'variant') VALUES (1, 2, 1, 1, 1);
INSERT INTO 'seating_arrangements' ('subject', 'student', 'row', 'desk', 'variant') VALUES (2, 2, 1, 1, 2);
INSERT INTO 'seating_arrangements' ('subject', 'student', 'row', 'desk', 'variant') VALUES (3, 2, 1, 2, 1);
INSERT INTO 'seating_arrangements' ('subject', 'student', 'row', 'desk', 'variant') VALUES (1, 3, 1, 2, 1);
INSERT INTO 'seating_arrangements' ('subject', 'student', 'row', 'desk', 'variant') VALUES (2, 3, 1, 2, 2);
INSERT INTO 'seating_arrangements' ('subject', 'student', 'row', 'desk', 'variant') VALUES (3, 3, 2, 2, 1);

INSERT INTO 'lessons' ('lesson_id', 'subject', 'classroom', 'start_lesson', 'end_lesson', 'class_number', 'class_letter') VALUES (1, 2, 3, '2023-05-17 09:00:00', '2023-05-17 09:45:00', 3, 'А');
INSERT INTO 'lessons' ('lesson_id', 'subject', 'classroom', 'start_lesson', 'end_lesson', 'class_number', 'class_letter') VALUES (2, 1, 1, '2023-05-17 09:55:00', '2023-05-17 10:00:00', 3, 'А');

INSERT INTO 'attendance' ('lesson', 'absent_student', 'reason') VALUES (1, 3, 'болезнь');
INSERT INTO 'attendance' ('lesson', 'absent_student', 'reason') VALUES (2, 3, 'болезнь');

-- Who was sitting at the first desk in the first row on May 17, 2023?
SELECT first_name, last_name
FROM student
WHERE student_id =
    (SELECT subject
     FROM seating_arrangements
     WHERE row = 1 AND desk = 1 AND subject =
         (SELECT lesson_id
          FROM lessons
          WHERE DATE(start_lesson)="2023-05-17"));
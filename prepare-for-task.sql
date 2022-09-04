-- [Prepare] Create tables

CREATE TABLE students (
	name varchar,
	surname varchar,
	birthday date,
	phone varchar,
	skill varchar,
	create_timestamp timestamp,
	update_timestamp timestamp
);

CREATE TABLE subjects (
	name varchar,
	tutor varchar
);

CREATE TABLE exam_results (
	student_id int,
	subject_id int,
	mark int
);

ALTER TABLE students ADD COLUMN id SERIAL PRIMARY KEY;
ALTER TABLE subjects ADD COLUMN id SERIAL PRIMARY KEY;
ALTER TABLE exam_results ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE exam_results
ADD CONSTRAINT student_id_fkey
FOREIGN KEY (student_id)
REFERENCES students(id)
ON DELETE CASCADE;

ALTER TABLE exam_results
ADD CONSTRAINT subject_id_fkey
FOREIGN KEY (subject_id)
REFERENCES subjects(id)
ON DELETE CASCADE;
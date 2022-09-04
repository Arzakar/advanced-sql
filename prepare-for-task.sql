-- [Prepare] Create tables

CREATE TABLE students (
	name varchar,
	surname varchar,
	birthday timestamp,
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
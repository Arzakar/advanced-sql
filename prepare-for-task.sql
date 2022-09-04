-- [Prepare] Create tables with constraints

CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	name varchar NOT NULL,
	surname varchar NOT NULL,
	birthday date NOT NULL,
	phone varchar NOT NULL,
	skill varchar NOT NULL,
	create_timestamp timestamp NOT NULL DEFAULT NOW(),
	update_timestamp timestamp
);

CREATE TABLE subjects (
	id SERIAL PRIMARY KEY,
	name varchar NOT NULL,
	tutor varchar NOT NULL
);

CREATE TABLE exam_results (
	id SERIAL PRIMARY KEY,
	student_id int NOT NULL REFERENCES students (id) ON DELETE CASCADE,
	subject_id int NOT NULL REFERENCES subjects (id) ON DELETE CASCADE,
	mark int NOT NULL,
	create_timestamp timestamp NOT NULL DEFAULT NOW(),
	update_timestamp timestamp
);

CREATE OR REPLACE FUNCTION trigger_set_update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
	NEW.update_timestamp = NOW();
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_update_timestamp_on_student
BEFORE UPDATE ON students
FOR EACH ROW EXECUTE PROCEDURE trigger_set_update_timestamp();

CREATE TRIGGER set_update_timestamp_on_exam_result
BEFORE UPDATE ON exam_results
FOR EACH ROW EXECUTE PROCEDURE trigger_set_update_timestamp();

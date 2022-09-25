-- 5. Select students who passed at least two exams for different subjects.

SELECT * FROM students
WHERE id IN (
	SELECT student_id FROM (
		SELECT DISTINCT student_id, subject_id 
		FROM exam_results
	) AS unique_pair_table
	GROUP BY student_id
	HAVING count(student_id) > 1
)
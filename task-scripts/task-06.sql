-- 6. Select students who passed at least two exams for the same subject. 

SELECT * FROM students
WHERE id IN (
	SELECT student_id FROM exam_results
	GROUP BY student_id, subject_id
	HAVING count(subject_id) > 1
)
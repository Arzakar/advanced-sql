-- 10. Select all students whose average mark is bigger than the overall average mark
SELECT s.* FROM students s
WHERE s.id IN (
	SELECT er.student_id FROM exam_results er
	GROUP BY er.student_id
	HAVING AVG(er.mark) > (
		SELECT AVG(er.mark) FROM exam_results er
	)
)
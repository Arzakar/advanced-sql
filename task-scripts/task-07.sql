-- 7. Select all subjects which exams passed only students with the same primary skills

SELECT * FROM subjects
WHERE id IN (
	SELECT subject_id FROM (
		SELECT er.subject_id
		FROM exam_results er 
		JOIN students s ON s.id = er.student_id 
		GROUP BY er.subject_id, s.skill 
	) AS subjects_ids_table
	GROUP BY subject_id
	HAVING count(subject_id) = 1
)





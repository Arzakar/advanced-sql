-- 8. Select all subjects which exams passed only students with the different primary skills. 
--    It means that all students passed the exam for the one subject must have different primary skill

SELECT subject_id, count(*), sum(cnt) FROM (
	SELECT er.subject_id, s.skill, count(*) AS cnt FROM exam_results er
	JOIN students s ON s.id = er.student_id
	GROUP BY er.subject_id, s.skill
) AS subject_with_skills
GROUP BY subject_id
HAVING count(*) = sum(cnt)
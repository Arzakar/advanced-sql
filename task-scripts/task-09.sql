-- 9. Select students who do not pass any exam using each of the following operator
--    Outer join (for 100K students and 1M exams duration = 2.285s)
SELECT s.id, s."name", s.surname, s.birthday, s.phone, s.skill, s.create_timestamp, s.update_timestamp
FROM students s
LEFT JOIN exam_results er ON er.student_id = s.id
WHERE er.id IS NULL

--    Subquery with 'not in' (for 100K students and 1M exams duration = 1.529s)
SELECT s.* FROM students s
WHERE s.id NOT IN (
	SELECT DISTINCT er.student_id FROM exam_results er
)

--    Subquery with ‘any‘ clause
--    Из-за ограничений таблицы exam_results, где у записи все поля кроме update_timestamp не должны быть null
--    не получится написать запрос такого вида
SELECT s.* FROM students s
WHERE s.id = ANY (
	SELECT er.student_id FROM exam_results er
	WHERE er.subject_id IS NULL
)

--    В качестве решения можно рассмотреть
--    Но смысла в таком запросе я не вижу, т.к. он всё равно использует NOT IN (его длительность 1.520s)
SELECT s.* FROM students s
WHERE s.id NOT IN (
	SELECT s2.id FROM students s2
	WHERE s2.id = ANY (
		SELECT DISTINCT er.student_id FROM exam_results er
	)
)


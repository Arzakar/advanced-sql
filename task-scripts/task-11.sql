-- 11. Select the top 5 students who passed their last exam better than average students
--     Немного объяснений:
--     Первым делом собираем таблицу, которая будет хранить id студента и id предмета с оценкой,
--     экзамен по которому он сдал в последнюю очередь. Выбирается это исходя из дат указанных в create или update timestamp
--     DISTINCT на student_id нужен, потому что в случае пакетного обновления информации для конкретного студента в таблице
--     exam_result, update_timestamp везде будет одинаковый и в таблице будет несколько записей с одинаковым student_id
--
--     Вторым шагом, мы собираем таблицу с id предмета и средней оценкой по нему
--     После чего соединяем эти таблицы, вычисляем разницу между оценкой студента и средней оценкой по этому предмету
--     Сортируем по этой разнице, затем по id студента и выбираем первые 5 записей
SELECT last_exams_table.student_id,
	   last_exams_table.subject_id,
	   last_exams_table.mark,
	   avg_mark_table.avg_mark,
	   (mark - avg_mark) AS diff
FROM (
	SELECT DISTINCT ON (er.student_id) er.student_id, er.subject_id, er.mark
	FROM exam_results er
	JOIN (
		SELECT er_inner.student_id,
			   GREATEST(
			       MAX(er_inner.create_timestamp),
			       MAX(er_inner.update_timestamp)
			   ) AS last_complete_exam_timestamp
		FROM exam_results er_inner
		GROUP BY er_inner.student_id
	) AS help_table ON help_table.student_id = er.student_id
	WHERE er.create_timestamp = help_table.last_complete_exam_timestamp
	OR er.update_timestamp = help_table.last_complete_exam_timestamp
) AS last_exams_table
JOIN (
	SELECT er.subject_id, AVG(mark) AS avg_mark FROM exam_results er
	GROUP BY er.subject_id
) AS avg_mark_table ON avg_mark_table.subject_id = last_exams_table.subject_id
WHERE last_exams_table.mark > avg_mark_table.avg_mark
ORDER BY diff DESC, student_id LIMIT 5
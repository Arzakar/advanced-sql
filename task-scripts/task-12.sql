-- 12. Select the biggest mark for each student and add text description for the mark (use COALESCE and WHEN operators)
SELECT s.id AS student_id,
	   MAX(er.mark) AS max_mark,
	   CASE coalesce(MAX(er.mark), 0)
		   WHEN 1 THEN 'BAD'
		   WHEN 2 THEN 'BAD'
		   WHEN 3 THEN 'BAD'
		   WHEN 4 THEN 'AVERAGE'
		   WHEN 5 THEN 'AVERAGE'
		   WHEN 6 THEN 'AVERAGE'
		   WHEN 7 THEN 'GOOD'
		   WHEN 8 THEN 'GOOD'
		   WHEN 9 THEN 'EXCELLENT'
		   WHEN 10 THEN 'EXCELLENT'
		   ELSE 'not passed'
	   END AS word_mark
FROM exam_results er
RIGHT JOIN students s ON s.id = er.student_id
GROUP BY s.id
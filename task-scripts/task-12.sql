-- 12. Select the biggest mark for each student and add text description for the mark (use COALESCE and WHEN operators)
SELECT s.id AS student_id,
	   coalesce(MAX(er.mark), 0) AS max_mark,
	   CASE
		   WHEN MAX(er.mark) BETWEEN 1 AND 3 THEN 'BAD'
		   WHEN MAX(er.mark) BETWEEN 4 AND 6 THEN 'AVERAGE'
		   WHEN MAX(er.mark) BETWEEN 7 AND 8 THEN 'GOOD'
		   WHEN MAX(er.mark) BETWEEN 9 AND 10 THEN 'EXCELLENT'
		   ELSE 'not passed'
	   END AS word_mark
FROM exam_results er
RIGHT JOIN students s ON s.id = er.student_id
GROUP BY s.id
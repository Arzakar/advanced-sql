-- 4. Select the number of students with the same exam marks for each subject. 

SELECT s."name", er.mark, count(*) AS students_count
FROM subjects s, exam_results er 
WHERE s.id = er.subject_id 
GROUP BY s."name", er.mark
ORDER BY s."name" ASC, er.mark DESC;
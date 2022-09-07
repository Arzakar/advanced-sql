-- 3. Select number of students passed exams for each subject and order result by a number of student descending. 

SELECT s."name", count(*) AS students_count
FROM subjects s, exam_results er 
WHERE s.id = er.subject_id 
GROUP BY s."name"
ORDER BY students_count DESC, s."name" ASC;
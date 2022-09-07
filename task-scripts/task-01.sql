-- 1. Select all primary skills that contain more than one word 

SELECT id, name, surname, skill FROM students
WHERE skill LIKE ANY (ARRAY['%_ _%', '%_-_%', '%_ - _%', '%_(_%_)%', '%_. _%'])


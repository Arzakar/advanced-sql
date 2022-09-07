-- 2. Select all students who do not have a second name 
-- (it is absent or consists of only one letter/letter with a dot)

SELECT * FROM students
WHERE surname LIKE ANY (ARRAY['', '_.', '_'])
OR surname IS NULL;
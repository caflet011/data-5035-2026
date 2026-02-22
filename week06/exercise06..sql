SELECT CATEGORY
FROM DONATIONS
WHERE CATEGORY IS NULL;


SELECT *
FROM DONATIONS 
WHERE DATE_OF_BIRTH < '1900-01-01';

CREATE OR REPLACE TEMPORARY TABLE birth_test
(date_of_birth date, expected int NOT NULL);

INSERT INTO birth_test
VALUES
('1985-07-15', 0),   -- Valid date, no issues
('1899-12-31', 1),   -- checking for dates before 1900
(NULL, 1),           -- missing data check
('2001-01-01', 0),   -- checks the date formats
('1909-08-21', 1),   -- abnormally old, the oldest person alive has this as their birthday
('01-01-84', 1),     -- checks data for the DD-MM-YY or MM-DD-YY format
('1-1-99', 1);       -- another format check

SELECT
'dq_invalid_birth' AS test_name,
date_of_birth AS input_value,
CASE
    WHEN date_of_birth IS NULL THEN 1
    WHEN date_of_birth < '1900-01-01' THEN 1
    ELSE 0 --situation eight, checking the dates 
END AS actual,
expected,
actual = expected AS match
FROM birth_test;

CREATE OR REPLACE TEMPORARY TABLE name_test
(name VARCHAR, expected INT NOT NULL);

INSERT INTO name_test
VALUES
    ('Bobby Flay', 1), --sometimes people use fake names so I just want to confirm. 
    ('Gordon Ramsey', 1),
    ('Carl Fletcher', 0),
    ('Tomato Barley', 1),
    ('Lamar Jackson', 1),
    ('Shaq', 1), --this is just to make sure we don't have a nickname in here. 
    ('James Smith', 1),
    ('Barack Obama', 1), --president name check. I chose Obama
    ('John Cena', 1);

SELECT
'dq_invalid_name' AS name_test,
name AS input_value,
CASE
    WHEN name IS NULL THEN 1
    WHEN REGEXP_LIKE(name, '^[0-9]+$') THEN 1
    WHEN REGEXP_LIKE(name, '^[A-Za-z]+,\s*[A-Za-z]+$') THEN 1
    ELSE 0 --three different checks, this checks for the comma, if we have names with numbers inside and if we have missing names. 
END AS actual,
expected,
actual = expected AS match
FROM name_test;

-- second database test 

DROP TABLE IF EXISTS students;

CREATE TYPE gen AS ENUM ('f', 'm');

CREATE VIEW select_all_students AS SELECT * FROM students;

CREATE TABLE students(
	id SERIAL,
	name VARCHAR(50),
	birth_day date,
	phone_number CHAR(12) UNIQUE NOT NULL,
	gender gen,
	PRIMARY KEY(id)
)

INSERT INTO students(name, birth_day ,phone_number,gender) 
VALUES
	('Quỳnh','1999-12-20','0389926701','f'),
	('Anh','1995-01-22','0389926702','m'),
	('Ánh','1992-01-22','0389926703','f'),
	('Ngọc','1996-02-12','0389926704','f');
	
CREATE FUNCTION func_get_gender(gender gen)
RETURNS varchar
LANGUAGE plpgsql
AS $body$
DECLARE
BEGIN
 	if gender = 'f' then
  		return 'Nữ';
	else
  		return 'Nam';
	end if;
END;
$body$

SELECT name,birth_day,phone_number,func_get_gender(gender) FROM students ORDER By name collate "C";

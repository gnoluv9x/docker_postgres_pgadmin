CREATE TYPE GENDER AS ENUM('f', 'm');

CREATE TABLE CLASSROOM (
	ID SERIAL,
	NAME VARCHAR(50) UNIQUE NOT NULL,
	PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS STUDENTS;

CREATE TABLE STUDENTS (
	ID SERIAL,
	NAME VARCHAR(50) NOT NULL,
	GENDER GENDER DEFAULT 'f',
	PHONE_NUMBER CHAR(12) UNIQUE NOT NULL,
	BIRTH_DAY DATE,
	CLASSROOM_ID INT,
	CONSTRAINT FK_CLASSROOM FOREIGN KEY (CLASSROOM_ID) REFERENCES CLASSROOM (ID),
	PRIMARY KEY (ID)
)

INSERT INTO
	CLASSROOM (NAME)
VALUES
	('IT'),
	('Accountant'),
	('Mechanical'),
	('Electrical');

INSERT INTO
	STUDENTS (
		NAME,
		GENDER,
		PHONE_NUMBER,
		BIRTH_DAY,
		CLASSROOM_ID
	)
VALUES
	('Trang', 'f', '0372667055', '1998-11-01', 2),
	('Nam', 'm', '0389123456', '1996-10-11', 3),
	('Quỳnh', 'f', '0389123457', '1999-01-21', 2),
	('Trung', 'm', '0389123458', '2000-04-22', 1);

CREATE
OR REPLACE FUNCTION FUNC_GET_GENDER (GENDER GENDER) RETURNS CHAR AS $$
declare gender_name ALIAS FOR gender;
BEGIN
	IF gender_name = 'f' then 
		return 'Nữ';
	ELSE 
		return 'Nam';
	end if;
END
$$ LANGUAGE PLPGSQL;

DROP FUNCTION FUNC_GET_AGE_FROM_BIRTH_DAY;

CREATE
OR REPLACE FUNCTION FUNC_GET_AGE_FROM_BIRTH_DAY (BIRTHDAY DATE) RETURNS INT AS $$
BEGIN
	return  DATE_PART('YEAR', AGE(NOW(),birthday));
END
$$ LANGUAGE PLPGSQL;

DROP FUNCTION FUNC_GET_STUDENT_DETAILS;
CREATE
OR REPLACE FUNCTION FUNC_GET_STUDENT_DETAILS (student_id INT) RETURNS TABLE (name VARCHAR(50),age INT, gender CHAR, phone_number CHAR(12), classroom_name VARCHAR(50)) AS $$
BEGIN
	RETURN QUERY SELECT students.name,func_get_age_from_birth_day(students.birth_day) as age, func_get_gender(students.gender) as gender, students.phone_number, classroom.name as classroom_name FROM students
	INNER JOIN classroom ON students.classroom_id = classroom.id
	WHERE students.id = student_id;
END
$$ LANGUAGE PLPGSQL;

-- hiển thị tên giới tính
SELECT
	NAME,
	FUNC_GET_GENDER (GENDER)
FROM
	STUDENTS;

-- hiển thị tuổi
SELECT
	NAME,
	FUNC_GET_AGE_FROM_BIRTH_DAY (BIRTH_DAY) AS AGE
FROM
	STUDENTS;

-- join 2 bảng và hiển thị lại toàn bộ thông tin theo mã sinh viên truyền vào
SELECT phone_number FROM func_get_student_details(1);


SELECT students.name,func_get_age_from_bi-rth_day(students.birth_day) as age, func_get_gender(students.gender) as gender, students.phone_number, classroom.name as classroom_name FROM students
	INNER JOIN classroom ON students.classroom_id = classroom.id
	WHERE students.id = 1




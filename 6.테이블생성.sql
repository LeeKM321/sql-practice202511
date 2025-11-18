
CREATE TABLE dept (
	dept_no BIGSERIAL PRIMARY KEY,
	dept_name VARCHAR(14),
	loca VARCHAR(15), -- 타 DBMS는 ()안의 숫자를 byte 크기, postgres는 글자 수
	dept_date TIMESTAMP DEFAULT NOW(),
	dept_bonus NUMERIC(10)
);

SELECT * FROM dept;

INSERT INTO dept 
	(dept_name, loca, dept_bonus)
VALUES('test', '', 40000000);


-- 컬럼명 수정 
ALTER TABLE dept
RENAME COLUMN dept_bonus TO bonus;

-- 컬럼 추가 
ALTER TABLE dept 
ADD COLUMN dept_comment VARCHAR(100);

SELECT * FROM dept2;

ALTER TABLE dept 
DROP COLUMN bonus;

ALTER TABLE dept
RENAME TO dept2;

ALTER TABLE dept2
ALTER COLUMN dept_name TYPE VARCHAR(140);

-- 테이블 삭제 (구조는 남겨두고 내부 데이터만 모두 삭제)
TRUNCATE TABLE dept2;

SELECT * FROM dept2;

-- 테이블 자체 삭제 
DROP TABLE dept2;















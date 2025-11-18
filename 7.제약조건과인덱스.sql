
-- 테이블 생성과 제약조건
-- : 테이블에 부적절한 데이터가 입력되는 것을 방지하기 위해 규칙을 설정하는 것.

-- 테이블 열레벨 제약조건 (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: 테이블의 고유 식별 컬럼입니다. (주요 키)
-- UNIQUE: 유일한 값을 갖게 하는 컬럼 (중복값 방지)
-- NOT NULL: null을 허용하지 않음. (필수값)
-- FOREIGN KEY: 참조하는 테이블의 PRIMARY KEY를 저장하는 컬럼
-- CHECK: 정의된 형식만 저장되도록 허용.

-- 컬럼 레벨 제약 조건 (컬럼 선언마다 제약조건 지정)
-- 제약조건 식별자는 생략이 가능합니다. (PostgreSQL에서 알아서 이름 지음)

CREATE TABLE dept (
	dept_no BIGSERIAL CONSTRAINT dept_deptno_pk PRIMARY KEY,
	dept_name VARCHAR(14) NOT NULL CONSTRAINT dept_deptname_uk UNIQUE,
	loca INTEGER CONSTRAINT dept_loca_locid_fk REFERENCES locations(location_id), 
	dept_bonus NUMERIC(10) CONSTRAINT dept_bonus_ck CHECK(dept_bonus > 1000000),
	man_gender VARCHAR(1) CONSTRAINT dept_gender_ck CHECK(man_gender IN ('M', 'F'))
);

DROP TABLE dept;


-- 테이블 레벨 제약 조건 (모든 열을 선언 후 제약조건을 한번에 취하는 방식)
CREATE TABLE dept (
	dept_no BIGSERIAL,
	dept_name VARCHAR(14) NOT NULL,
	loca INTEGER, 
	dept_bonus NUMERIC(10),
	man_gender VARCHAR(1),
	
	CONSTRAINT dept_deptno_pk PRIMARY KEY(dept_no),
	CONSTRAINT dept_deptname_uk UNIQUE(dept_name),
	CONSTRAINT dept_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
	CONSTRAINT dept_bonus_ck CHECK(dept_bonus > 1000000),
	CONSTRAINT dept_gender_ck CHECK(man_gender IN ('M', 'F'))
);

-- 외래 키(foreign key)는 부모테이블(참조테이블)에 없는 값을 INSERT 할 수 없음!
INSERT INTO dept
	(dept_name, loca, dept_bonus, man_gender)
VALUES 
	('마케팅부', 2000, 2000000, 'F');

SELECT * FROM dept;

UPDATE dept
SET loca = 4000
WHERE dept_no = 1; -- 실패 (FK 제약조건 위반)

UPDATE dept
SET dept_no = 3
WHERE dept_no = 1; -- 실패 (PK 위반)

UPDATE dept
SET dept_bonus = 1000
WHERE dept_no = 1; -- 실패 (CHECK 위반)

-- 타 테이블에서 나의 PK를 참조하는 경우에는 삭제가 마음대로 안됩니다.
DELETE FROM locations
WHERE location_id = 1700;

-- 제약 조건 삭제 (제약 조건 이름으로)
ALTER TABLE dept
DROP CONSTRAINT dept_gender_ck;

-- CHECK 추가
ALTER TABLE dept
ADD CONSTRAINT man_gender_ck CHECK(man_gender IN ('M', 'F'));


EXPLAIN ANALYZE
SELECT * FROM employees
WHERE phone_number = '010-5000-5000';

CREATE INDEX idx_emp_phone ON employees(phone_number);

DROP INDEX idx_emp_phone;

SELECT * FROM employees;

ANALYZE employees;

INSERT INTO employees (
    employee_id, 
    first_name, 
    last_name, 
    email, 
    phone_number, 
    hire_date, 
    job_id, 
    salary, 
    commission_pct, 
    manager_id, 
    department_id
)
SELECT 
    1000 + i,  -- employee_id: 1001부터 시작
    'FirstName' || i,
    'LastName' || i,
    'EMP' || i || '@company.com',
    '010-' || LPAD((i % 10000)::TEXT, 4, '0') || '-' || LPAD((i % 10000)::TEXT, 4, '0'),  -- phone_number
    CURRENT_DATE - (i % 3650),  -- 최근 10년 내 임의의 날짜
    (ARRAY['IT_PROG', 'SA_REP', 'ST_CLERK', 'SH_CLERK', 'AD_ASST'])[1 + (i % 5)],  -- 직무 랜덤
    30000 + (i % 20) * 1000,  
    CASE WHEN i % 10 = 0 THEN 0.1 ELSE NULL END,  
    101,  -- manager_id (기존 데이터의 매니저 ID)
    50  -- department_id: 50
FROM generate_series(1, 100000) AS i;



SELECT COUNT(*) FROM employees;

SELECT * FROM employees;











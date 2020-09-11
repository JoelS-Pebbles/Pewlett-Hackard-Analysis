CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY(dept_no),
	UNIQUE (dept_name)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(300026) NOT NULL,
	last_name VARCHAR(300026) NOT NULL,
	gender VARCHAR(300026) NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
dept_no VARCHAR(26) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR(443309) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date) 
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR (4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

SELECT e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
ti.title,
ti.from_date,
ti.to_date
INTO retirement_title
FROM employees as e
left join titles as ti
on e.emp_no=ti.emp_no;

SELECT 
emp_no,
first_name,
last_name,
title,
from_date,
to_date
INTO retirement_titles
from retirement_title
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');
SELECT*FROM retirement_titles
ORDER BY emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, from_date DESC;
SELECT*FROM unique_titles;

SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
from unique_titles as ut
group by ut.title
order by count desc;
SELECT * FROM retiring_titles;

SELECT emp_no,
first_name, 
last_name,
birth_date 
FROM employees;

SELECT DISTINCT ON (emp_no) emp_no,
first_name, 
last_name,
birth_date 
INTO EMP
FROM employees;

SELECT*FROM EMP;

SELECT from_date,
to_date
FROM dept_emp;

SELECT DISTINCT ON (emp_no) emp_no,
from_date,
to_date
INTO year_sixty_five
FROM dept_emp;

SELECT sf.from_date,
sf.to_date,
ti.title
FROM year_sixty_five as sf
left join titles as ti
on sf.emp_no=ti.emp_no;

SELECT e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
sf.from_date,
sf.to_date
INTO mentorship_e
FROM EMP as e
left join year_sixty_five as sf
on e.emp_no=sf.emp_no;

SELECT*FROM mentorship_e;

SELECT me.emp_no,
me.first_name,
me.last_name,
me.birth_date,
me.from_date,
sf.to_date
INTO mentorship_el
FROM mentorship_e as me
left join year_sixty_five as sf
on me.emp_no=sf.emp_no;
SELECT*FROM mentorship_el;

SELECT me.emp_no,
me.first_name,
me.last_name,
me.birth_date,
me.from_date,
sf.to_date,
me.title
INTO mentorship_elgibile
--FROM mentorship_elgibile as me
left join year_sixty_five as sf
on me.emp_no=sf.emp_no;
SELECT*FROM mentorship_elgibile;

SELECT distinct on (emp_no) emp_no,
first_name,
last_name,
birth_date,
from_date,
to_date,
title
INTO mentorship_eligibility
FROM mentorship_eli
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

SELECT *FROM mentorship_eligibility;

SELECT me.emp_no,
me.first_name,
me.last_name,
me.birth_date,
me.from_date,
me.to_date,
ti.title
INTO mentorship_eli
FROM mentorship_e as me
left join titles as ti
on me.emp_no=ti.emp_no;
SELECT*FROM mentorship_el;

SELECT distinct on (emp_no) emp_no,
first_name,
last_name,
birth_date,
from_date,
to_date,
title
INTO mentorship_eligibility
FROM mentorship_eli
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (to_date='9999-01-01')
ORDER BY emp_no;
SELECT*FROM mentorship_eligibility;

SELECT COUNT(me.emp_no), me.title
--INTO mentor_titles
from mentorship_eli as me
WHERE (birth_date BETWEEN '1956-01-01' AND '1959-12-31')
group by me.title
order by count desc;










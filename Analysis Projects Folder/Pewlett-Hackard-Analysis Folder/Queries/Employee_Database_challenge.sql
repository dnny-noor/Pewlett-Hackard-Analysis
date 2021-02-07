--Retrieve data from employees table.
SELECT emp_no, first_name, last_name
FROM employees;

--Retrieve data from titles table.
SELECT title, from_date, to_date
FROM titles;

--Join data from both employee and titles table.
SELECT e.emp_no, 
    e.first_name, 
    e.last_name,
    t.title,
    t.from_date,
    t.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
ORDER BY e.emp_no;

commit;

--Capture most recent job title for ea. employee.
SELECT DISTINCT ON (emp_no) emp_no, 
    first_name, 
    last_name,
    title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

commit;

SELECT * FROM unique_titles;

--Retrieve number of titles from the Unique Titles table.
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) desc;

commit;

SELECT * FROM retiring_titles;

--Mentorship Program
--Retrieve data from employees table.
SELECT emp_no, first_name, last_name, birth_date
FROM employees;

--Retrieve data from dept_emp table.
SELECT from_date, to_date
FROM dept_emp;

--Retrieve data from titles table.
SELECT title
FROM titles;

--Join retrieved data from all tables.
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees AS e
LEFT JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE de.to_date = '9999-01-01' AND
(e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

commit;
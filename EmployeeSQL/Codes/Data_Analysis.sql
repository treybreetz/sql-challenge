--List the employee number, last name, first name, sex, and salary of each employee.
SELECT
e.emp_no,
e.last_name,
e.first_name,
e.sex,
(SELECT s.salary FROM salaries AS s 
WHERE e.emp_no = s.emp_no) AS salary					
FROM employees AS e
;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT
first_name,
last_name,
hire_date
FROM employees 
WHERE DATE_PART('year', hire_date) = 1986
;

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT
d.dept_no,
d.dept_name,
e.emp_no,
e.last_name,
e.first_name
FROM 	dept_emp as de
LEFT JOIN employees as e
	ON e.emp_no = de.emp_no
LEFT JOIN departments as d
	ON d.dept_no = de.dept_no
WHERE e.emp_title_id LIKE 'm%'
;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
CREATE VIEW all_employees AS 
(SELECT e.emp_no,
e.emp_title_id,
e.birth_date,
e.last_name,
e.first_name,
e.sex,
e.hire_date,
d.dept_name,
d.dept_no
FROM dept_emp as de
LEFT JOIN employees as e
ON e.emp_no = de.emp_no
LEFT JOIN departments as d
ON d.dept_no = de.dept_no)
;

SELECT
dept_no,
emp_no,
last_name,
first_name,
dept_name
FROM all_employees
;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT
first_name,
last_name,
sex
FROM employees 
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'
;

--List each employee in the Sales department, including their employee number, last name, and first name.
create view Sales as (
Select 
emp_no,
last_name,
first_name,
dept_name
from all_employees)
;

Select emp_no, last_name, first_name
from Sales 
where dept_name = 'Sales'
;

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
select emp_no, last_name, first_name, dept_name
from Sales
where dept_name = 'Sales'
or dept_name = 'Development'
;

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT
last_name,
COUNT(last_name) AS frequency	
FROM employees 
GROUP BY last_name
ORDER BY frequency DESC
;
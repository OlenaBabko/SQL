CREATE DATABASE office;

USE office;

-- tables
CREATE TABLE departments (
	department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
	employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE tasks (
	task_id INT,
    task_name VARCHAR(100) NOT NULL,
    employee_id INT
);

ALTER TABLE tasks
ADD PRIMARY KEY (task_id),
ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
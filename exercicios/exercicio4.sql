select * from employees;
select * from departments;

--Exercício 4
--Laura Pianetti

--questão 1
--Apresente o nome dos departamentos que não têm empregados. 
--Faça isso com consulta aninhada. Faça isso também com operadores de conjunto, como union, intersect ou minus.

--resolvendo com consulta aninhada
SELECT
    department_name
FROM
    aluno.departments
WHERE
    department_id NOT IN (SELECT DISTINCT department_id
                         FROM aluno.employees
                         WHERE department_id is not null);

--resolvendo com operadores de conjunto
SELECT 
    d.department_name
FROM   
    departments d
MINUS  
SELECT 
    d.department_name
FROM   
    departments d JOIN employees e
    ON d.department_id = e.department_id;

-- questão 2 
--Apresente o nome completo de todos os empregados, com o nome dos seus departamentos.

SELECT
    e.first_name, e.last_name,
    d.department_name
FROM
    departments d INNER JOIN employees e
    ON d.department_id = e.department.id;

--questão 3 
--Agora, refaça o comando anterior para incluir também os empregados sem departamentos. 
--Nesse caso, o nome do departamento deve ser nulo. 

SELECT
    e.first_name, e.last_name,
    d.department_name
FROM
    departments d RIGHT OUTER JOIN employees e
    ON d.department_id = e.department.id;

--questão 4 
--Se você usou junção externa à direita, refaça o comando anterior para usar a esquerda e vice-versa.

SELECT
    e.first_name, e.last_name,
    d.department_name
FROM
    employees e LEFT OUTER JOIN departments d
    ON d.department_id = e.department.id;

--questão 5 
--Apresente o nome dos empregados e data de ocupação. Faça isso para todos os empregados, inclusive os que nunca tiveram cargos anteriores. 
--Use junção externa. Não precisa colocar o título (JOB_TITLE) do cargo que está em JOBS.

SELECT
    e.first_name, e.last_name,
    jh.start_date, jh.end_date, jh.job_id
FROM
    employees e LEFT JOIN job_history jh
    ON e.employees_id = jh.employee_id;

--questão 6 
--Agora, refaça o comando anterior para incluir o nome do cargo, que, como foi dito, está em JOBS. 
--Continue usando junção externa.

SELECT
    e.first_name, e.last_name,
    jh.start_date, jh.end_date, jh.job_id,
    j.job_title
FROM
    (employees e LEFT OUTER JOIN job_history jh
    ON e.employees_id = jh.employee_id) LEFT JOIN jobs j
    ON jh.job_id = j.job_id;

--questão 7 
--Apresente, distintamente, todos os cargos sendo ocupados atualmente na cidade de ‘Seattle’. 
--Utilize, para isso, somente consultas aninhadas. 

SELECT
    j.job_title
FROM
    jobs j
WHERE
    j.job_id in (SELECT DISTINCT e.job_id
                FROM employees e
                WHERE e.department_id in (SELECT d.department_idl.location_id
                                         FROM departments d
                                         WHERE d.location_id in (SELECT l.location_id
                                                                FROM locations l
                                                                WHERE l.city='Seattle')));

--questão 8 
--Resolva a consulta anterior, utilizando somente junções ao invés de consultas aninhadas.

SELECT DISTINCT
    j.job_title
FROM
    ((locations l JOIN departments d
    ON l.location_id=d.location_id) JOIN employees e
    ON d.department_id=e.department_id) JOIN jobs j
    ON e.job_id=j.job_id
WHERE
    l.city='Seattle';

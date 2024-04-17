select * from employees;
select * from departments;

--Exercício 1
--Laura Pianetti

--questão 1
--Apresente o primeiro e último nomes e o mês, por extenso, de admissão (coluna Hire_Date de EMPLOYEES) 
--de todos os empregados que começam com a letra ‘R’ no último nome. 
--O formato de exibição por extenso das datas deve ser ‘DD-Month-YYYY’. Exemplo: ‘01-Janeiro-2021’.

SELECT
    First_Name AS Nome,
    Last_Name AS Sobrenome,
    TO_CHAR(Hire_Date, 'DD-Month-YYYY') AS Data_Admissao
FROM
    Employees
WHERE
    SUBSTR(Last_Name, 1, 1) = 'R';

--questão 2
--Apresente o nome completo de todos os empregados que trabalham no departamento que tem “executive” no nome. 
--O nome do departamento deve aparecer no resultado em maiúsculas

SELECT
    CONCAT(CONCAT(First_Name, ' '), Last_Name) AS Nome_Completo,
    UPPER(Departament_Name) AS Departamento
FROM
    Employees E JOIN Departments D 
    ON E.Department_ID = D.Department_ID
WHERE
    LOWER(D.Departament_Name) = 'executive';

--questão 3
--Apresente o nome completo e a data de admissão de todos os empregados que foram admitidos no ano de 1999. 
--Use a coluna HIRE_DATE com funções de data. O formato de exibição das datas deve ser ‘DD-Month-YYYY’.

SELECT
    CONCAT(CONCAT(First_Name, ' '), Last_Name) AS Nome_Completo,
    TO_CHAR(Hire_Date, 'DD-Month-YYYY') AS Data_Admissao
FROM
    Employees
WHERE
    TO_CHAR(Hire_Date, 'YYYY') = '1999';

--questão 4
--Apresente o nome completo, o salário diário, arredondado, e o anual de todos os empregados que ganham comissão. 
--O salário em EMPLOYEES é mensal para todos os empregados.

SELECT
    CONCAT(CONCAT(First_Name, ' '), Last_Name) AS Nome_Completo,
    ROUND(Salary/30) AS Salario_Diario,
    Salary*12 AS Salario_Anual
FROM
    Employees
WHERE
    Commission_Pct IS NOT NULL;

--questão 5
--Apresente o nome completo de todos empregados, com salário mensal e o salário mensal mais a comissão (que é um percentual mensal de 0 a 1). 
--Caso não tenha comissão, o empregado tem a coluna Comission_Pct igual a NULL. 
--Empregados sem comissão devem ser incluídos no resultado, naturalmente a comissão deles é zero.

SELECT
    CONCAT(CONCAT(First_Name, ' '), Last_Name) AS Nome_Completo,
    Salary AS Salario_Mensal,
    NVL(Comission_Pct,0)*Salary AS Comissao,
    Salary*(1+Commission_Pct) AS Salario_Comissao
FROM
    Employees;

--questão 6 
--Apresente somente a inicial de cada nome (primeiro e último nomes) de empregados que são gerentes de departamento. 
--Incluir o nome do departamento.

SELECT 
    SUBSTR(First_Name,1,1), SUBSTR(Last_Name,1,1), 
    D.Departament_Name AS Departamento
FROM
    Employees E JOIN Departments D 
    ON E.Department_ID = D.Department_ID
WHERE  
    E.Employee_ID = D.Manager_ID;

--questão 7 
--Apresente o nome completo de todos os empregados, a quantidade de anos e meses trabalhando na empresa. 
--Os resultados devem ser inteiros. 

SELECT 
    CONCAT(CONCAT(First_Name, ' '), Last_Name) AS Nome_Completo, 
    ROUND(MONTHS_BETWEEN(SYSDATE,Hire_Date)/12) AS Anos,
    ROUND(MONTHS_BETWEEN(SYSDATE, Hire_Date)) AS Meses
FROM   
    Employees;

--questão 8 
--Apresente a média, arredondada, o máximo, o mínimo salário por departamento, incluindo o nome do departamento. 

SELECT 
    E.Department_ID, 
    D.Department_Name AS Departemento, 
    ROUND(AVG(Salary)) AS Salario_Medio,
    MAX(Salary) AS Salario_Max,
    MIN(Salary) AS Salario_Min
FROM   
    Employees E JOIN Departments D 
    ON E.Department_ID = D.Department_ID
GROUP BY 
    D.Department_Name;

--questão 9 
--Apresente a quantidade de empregados por departamento. Faça somente isso para empregados que têm ‘clerk’ na coluna JOB_ID.
--O departamento deve aparecer. 

SELECT 
    D.Department_Name AS Departamento,
    COUNT(E.Employee_ID) AS Quantidade_Emp
FROM   
    Employees E JOIN Departments D 
    ON E.Department_ID = D.Department_ID
WHERE  
    LOWER(E.Job_ID) LIKE '%clerk%'
GROUP BY 
    D.Department_Name;
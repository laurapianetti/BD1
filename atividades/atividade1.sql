--Atividade Avaliativa 1
--Laura Pianetti

--Resolva as seguintes questões, apresentando o comando SQL apropriado. Também apresente os resultados obtidos

--questão 1 
--Apresente o último nome e a data de admissão de todos os empregados que começam com a letra ‘R’ no último nome.

DESC aluno.employees;
SELECT 
    First_Name, Last_Name,
    Hire_Date
FROM 
    Employees
WHERE 
    LOWER(Last_Name) LIKE 'r%';

-- Den	Raphaely	07/12/1994
-- Michael	Rogers	26/08/1998
-- Trenna	Rajs	17/10/1995
-- John	Russell	01/10/1996

--questão 2 
--Apresente o primeiro nome concatenado com o último de todos os empregados que trabalham no departamento 60.

SELECT
    E.First_Name ||' '|| E.Last_Name as Nome_Completo
FROM 
    Employees E
WHERE 
    Department_Id = 60;

-- Alexander Hunold	
-- Bruce Ernst
-- David Austin	
-- Valli Pataballa	
-- Diana Lorentz	

--questão 3 
--Apresente em maiúsculas o nome do departamento 60

SELECT
    UPPER(Department_Name) 
FROM   
    Departments D
WHERE 
    D.Department_Id = 60;

-- IT

--questão 4 
--Apresente o nome completo de todos os empregados que foram admitidos no ano de 1999.

SELECT
    E.First_Name ||' '|| E.Last_Name as Nome_Completo
FROM     
    aluno.Employees E
WHERE  
    TO_CHAR(E.Hire_Date,'YYYY') = '1999';

-- Diana Lorentz
-- Luis Popp
-- Karen Colmenares
-- Kevin Mourgos
-- James Landry
-- TJ Olson


--questão 5
--Apresente o nome e o salário anual de todos os empregados que ganham entre 4000 e 7000

SELECT
    E.First_Name ||' '|| E.Last_Name as Nome_Completo,
    Salary as Salario
FROM     
    Employees E
WHERE 
    Salary BETWEEN 4000 AND 7000;

-- Kimberely Grant	7000
-- Charles Johnson	6200
-- Nandita Sarchand	4200
-- Alexis Bull	4100
-- Sarah Bell	4000
-- Jennifer Whalen	4400
-- Shanta Vollman 6500
-- Pat Fay	6000
-- Susan Mavris	6500

--questão 6 
--Executando uma ou mais consultas, apresente o nome completo dos empregados que trabalham no departamento de nome ‘Shipping’. 

-- com dois comandos SQL separados
SELECT 
    Department_Id
FROM
    Departments
WHERE 
    Department_Name = 'Shipping';
SELECT   
    E.First_Name ||' '|| E.Last_Name as Nome_Completo
FROM
    Employees E
WHERE 
    Department_Id = 50; 

-- com um único comando SQL(com select aninhados)
SELECT
    E.First_Name ||' '|| E.Last_Name as Nome_Completo
FROM     
    Employees E
WHERE 
    Department_Id = (SELECT Department_Id
                    FROM Departments
                    WHERE Department_Name = 'Shipping');

-- Matthew Weiss
-- Adam Fripp
-- Payam Kaufling
-- Shanta Vollman
-- Kevin Mourgos
-- Julia Nayer
-- Irene Mikkilineni
-- James Landry
-- Steven Markle
-- Laura Bissot

--questão 7 
--Retorne o nome de todos os empregados que trabalham no departamento ‘Shipping’, ganhando entre 5000 and 8000, admitidos entre 1997 e 1999

SELECT  
    E.First_Name ||' '|| E.Last_Name as Nome_Completo, 
    Salary as Salario, 
    Hire_Date as Data_Admissao
FROM
    Employees E
WHERE 
    Department_Id = (SELECT Department_Id
                    FROM Departments
                    WHERE Department_Name = 'Shipping') 
                    AND Salary between 5000 and 8000 
                    AND to_char(Hire_Date,'YYYY') in (1997,1998,199);
           
-- Shanta Vollman	6500	10/10/1997     

--questao 8 
--Com um ou mais comandos SQL, apresente todos os empregados, com nome e sobrenome, que são gerenciados diretamente pelo empregado “Steven King”. 

--com dois comandos
SELECT 
    Employee_ID
FROM   
    Employees
WHERE 
    First_Name = 'Steven' and Last_Name = 'King';

SELECT  
    E.First_Name ||' '|| E.Last_Name as Nome_Completo
FROM     
    Employees E 
WHERE  
    Manager_Id = 100;

--com um comando
SELECT  
    E.First_Name ||' '|| E.Last_Name as Nome_Completo
FROM     
    Employees E 
WHERE  
    Manager_Id = (SELECT Employee_ID
                 FROM   Employees        
                 WHERE First_Name = 'Steven' and Last_Name = 'King');

-- Neena Kochhar
-- Lex De Haan
-- Den Raphaely
-- Matthew Weiss
-- Adam Fripp
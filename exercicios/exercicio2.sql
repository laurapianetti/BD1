--Exercício 2
--Laura Pianetti

--Apresente os comandos DDL para criação do esquema de dado relacional 

--DEPARTAMENTO(numero_departamento(PK), nome_departamento, cpf_gerente, data_inicio_gerente)
--DEPARTAMENTO[cpf_gerente] --> b FUNCIONARIO[cpf]

CREATE TABLE DEPARTAMENTO (
    numero_departamento  number(5) constraint pK_departamento primary key,
    nome_departamento varchar(30) not null,
    cpf_gerente varchar(11) constraint uk_cpf_gerente unique,
    data_inicio_gerente date);
  
--LOCALIZACOES_DEPARTAMENTO(numero_departamento, localizacao) – PK composta: NUMDPEP e LOCALIZACAO
--LOCALIZACOES_DEPARTAMENTO[Numero_departamento] --> p DEPARTAMENTO[Numero_Departamento]

CREATE TABLE LOCALIZACOES_DEPARTAMENTO (
    numero_departamento number(5),
    localizacao varchar(40),
    constraint pk_localizacoes_departamento primary key (numero_departamento, localizacao),
    constraint fk_localizacoes_departamento_departamento foreign key (numero_departamento) 
    references DEPARTAMENTO(numero_departamento)
    on delete cascade);

--FUNCIONARIO(cpf, primeiro_nome, nome_meio, ultimo_nome, sexo, endereco, salario, data nascimento, numero_departamento, cpf_supervisor)
--FUNCIONARIO[numero_departamento]--> b DEPARTAMENTO[numero_departamento]
--FUNCIONARIO[cpf_supervisor] --> b FUNCIONARIO[cpf]
     
CREATE TABLE FUNCIONARIO (
    cpf varchar(11) constraint pk_funcionario primary key,
    primeiro_nome varchar(20) not null,
    nome_meio varchar(20),
    ultimo_nome varchar(20) not null,
    sexo char(1),
    endereco varchar(40) not null,
    salario  number(10,2) not null,
    data_nascimento date,
    numero_departamento number(5) constraint fk_funcionario_departamento 
    references DEPARTAMENTO(numero_departamento) not null,
    cpf_supervisor varchar(11) constraint fk_funcionario_funcionario 
    references FUNCIONARIO(cpf));
            
--DEPENDENTE(cpf_funcionario, nome, sexo, data_nascimento, parentesco)
--DEPENDENTE[cpf_funcionario] --> p FUNCIONARIO[cpf]

CREATE TABLE DEPENDENTE (
    cpf_funcionario varchar(11) constraint fk_dependente_funcionario 
    references FUNCIONARIO(cpf) 
    on delete cascade,
    nome_dependente varchar(50),
    sexo char(1),
    data_nascimento date not null,
    parentesco varchar(20), 
    constraint pk_dependente primary key (cpf_funcionario, nome_dependente));
     
--PROJETO(numero(PK), nome, localizacao, numero_departamento)
--PROJETO[numero_departamento] --> b DEPARTAMENTO[numero]

CREATE TABLE PROJETO (
    nome_projeto varchar(30) not null,
    numero_projeto number(5) constraint pk_projeto primary key,
    local_projeto varchar(30) not null,
    numero_departamento number(5) not null constraint fk_projeto_departamento    
    references DEPARTAMENTO(numero_departamento));

--TRABALHA_EM(cpf_funcionario, numero_projeto, horas)
--TRABALHA_EM[cpf_funcionario] --> FUNCIONARIO[cpf]
--TRABALHA_EM[numero_projeto] --> PROJETO[numero]

CREATE TABLE TRABALHA_EM (
    cpf_funcionario varchar(11) constraint fk_trabalha_em_funcionario 
    references FUNCIONARIO(cpf),
    numero_projeto number(5) constraint fk_trabalha_em_projeto 
    references PROJETO(numero_projeto),
    horas number(4), 
    constraint pk_trabalha_em primary key (cpf_funcionario, numero_projeto));
         
ALTER TABLE DEPARTAMENTO ADD
    constraint  fk_departamento_funcionario foreign key (cpf_gerente) 
    references  FUNCIONARIO(cpf) 
    on delete cascade;
      
grant select on funcionario to public;
grant select on departamento to public;
grant select on localizacoes_departamento to public;
grant select on trabalha_em to public;
grant select on dependente to public;
grant select on projeto    to public;

--Preencha o banco de dados criado. Apresente todos os comandos DML utilizados.

INSERT INTO Departamento(nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente) VALUES ('Pesquisa', 5, null, '22-05-1988');
INSERT INTO Departamento VALUES ('Administração', 4, null,'01-01-1995');
INSERT INTO Departamento VALUES ('Matriz', 1, null,'19-06-1981');

UPDATE Departamento SET cpf_gerente = '33344555587' WHERE numero_departamento = 5;
UPDATE Departamento SET cpf_gerente = '98765432168' WHERE numero_departamento = 4;
UPDATE Departamento SET cpf_gerente = '88866555576' WHERE numero_departamento = 1;

INSERT INTO Funcionario(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento) VALUES ('João', 'B', 'Silva', '12345678966', '09-01-1965', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000, 5);
INSERT INTO Funcionario VALUES ('Fernando', 'T', 'Wong', '33344555587', '08-12-1955', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000, 5);
INSERT INTO Funcionario VALUES ('Alice', 'J', 'Zelaya', '99988777767', '19-01-1968', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000, 4);

INSERT INTO Dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES ('33344555587', 'Alicia', 'F', '05-04-1986', 'Filha');
INSERT INTO Dependente VALUES ('33344555587', 'Tiago', 'M', '25-10-1983','Filho');
insert into Dependente VALUES ('33344555587', 'Janaína', 'F', '03-05-1958', 'Esposa');

INSERT INTO Localizacoes_Departamento(numero_departamento, localizacao) VALUES (1, 'São Paulo');
INSERT INTO Localizacoes_Departamento VALUES (4, 'Mauá');
INSERT INTO Localizacoes_Departamento VALUES (5, 'Santo André');

DESC Trabalha_Em
INSERT INTO Projeto(nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES ('ProdutoX', 1, 'Santo André', 5);
INSERT INTO Projeto VALUES ('ProdutoY', 2, 'Itu', 5);
INSERT INTO Projeto VALUES ('ProdutoZ', 3, 'São Paulo', 5);

INSERT INTO Trabalha_Em(cpf_funcionario, numero_projeto, horas) VALUES ('12345678966', 1, 32.5);
INSERT INTO Trabalha_Em VALUES ('12345678966', 2, 7.5);
INSERT INTO Trabalha_Em VALUES ('66688444476', 3, 40.0);

COMMIT;
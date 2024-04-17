--Exercício 3
--Laura Pianetti

--Apresente os comandos SQL para as seguintes questões

--questão 1
--Crie as seguintes tabelas, sem chaves primárias e sem chaves estrangeiras
--TIME (Id, Nome)
--JOGO(Data, Placar_Casa, Placar_VIsitante)
--JOGADOR(Cpf, Nome)

CREATE TABLE TIME (
    Id number(2),
    Nome varchar(25)
);

CREATE TABLE JOGO (
    Data date,
    Placar_Casa number(2), 
    Placar_Visitante number(2)
);

CREATE TABLE JOGADOR (
    Cpf number(11),
    Nome varchar(25)
);

--questão 2
--Preencha essas tabelas com dados

INSERT INTO Time VALUES (01, 'Cruzeiro');
INSERT INTO Time VALUES (02, 'São Paulo');
INSERT INTO Time VALUES (03, 'Flamengo');

INSERT INTO Jogo VALUES ('11/Abril/2024', 0, 1);
INSERT INTO Jogo VALUES ('18/Abril/2024', 2, 3);
INSERT INTO Jogo VALUES ('25/Abril/2024', 2, 1);

INSERT INTO Jogador VALUES (12345678900, 'Rafael');
INSERT INTO Jogador VALUES (65462879324, 'Matheus');
INSERT INTO Jogador VALUES (32468357950, 'Lucas');

--questão 3
--Adicione as chaves primárias Time.Id e Jogador.Cpf
ALTER TABLE Time 
add constraint pk_Time primary key (Id);

ALTER TABLE Jogador 
add constraint pk_Jogador primary key (Cpf);

--questão 4
--Adicione as chaves estrangeiras JOGO e JOGADOR
--JOGO[Id_Casa] --> p TIME[Id]
--JOGO[Id_Visitante] --> p TIME[Id]
--JOGADOR[Id_Time] --> b TIME[Id]

ALTER TABLE Jogo 
add Id_Casa number(2);

ALTER TABLE Jogo 
add Id_Visitante number(2);

ALTER TABLE Jogador
add Id_Time number(2);

ALTER TABLE Jogo
add constraint fk_Jogo_Time_Casa foreign key (Id_Casa)
references Time (Id) on delete cascade;

ALTER TABLE Jogo
add constraint fk_Jogo_Time_Visitante foreign key (Id_Visitante)
references Time (Id) on delete cascade;

ALTER TABLE Jogador
add constraint fk_Jogador_Time foreign key (Id_Time)
references Time (Id);

--questão 5
--EStabeleça as integridades referenciais através de dados em todas as tabelas com chaves estrangeiras

UPDATE Jogador SET Id_Time = 02 WHERE Nome = 'Rafael';
UPDATE Jogador SET Id_Time = 01 WHERE Nome = 'Lucas';
UPDATE Jogador SET Id_Time = 03 WHERE Nome = 'Matheus';

UPDATE Jogo SET Id_Casa = 03 WHERE Data = '11/Abril/2024';
UPDATE Jogo SET Id_Visitante = 02 WHERE Data = '11/Abril/2024';
UPDATE Jogo SET Id_Casa = 03 WHERE Data = '18/Abril/2024';
UPDATE Jogo SET Id_Visitante = 01 WHERE Data = '18/Abril/2024';
UPDATE Jogo SET Id_Casa = 02 WHERE Data = '25/Abril/2024';
UPDATE Jogo SET Id_Visitante = 01 WHERE Data = '25/Abril/2024';

--questão 6
--Adicione a chave primária em Jogo, formada pelas chaves estrangeiras e pela coluna data

ALTER TABLE Jogo 
add constraint pk_Jogo primary key (Data, Id_Casa, Id_Visitante);

--questão 7
--Altere a coluna Id_Time de Jogador para obrigatória

ALTER TABLE Jogador
modify Id_Time not null;

--questão 8
--Crie uma chave única em Jogador.Nome

ALTER TABLE Jogador
add constraint uk_Nome unique (Nome);

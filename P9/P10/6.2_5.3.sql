-- ex 6.2 -> 5.3
-- a) criacao das tabelas
-- CREATE SCHEMA Prescricao;

CREATE TABLE Prescricao.medico(
    numSNS              INT         PRIMARY KEY NOT NULL,
    nome                VARCHAR(60) NOT NULL,
    especialidade       VARCHAR(60),                      
);

CREATE TABLE Prescricao.paciente(
    numUtente           INT         PRIMARY KEY NOT NULL,
    nome                VARCHAR(60) NOT NULL,
    dataNasc            DATE        NOT NULL,
    endereco            TEXT,
);

CREATE TABLE Prescricao.farmacia(
    nome                VARCHAR(60) PRIMARY KEY NOT NULL,
    telefone            INT         UNIQUE,
    endereco            TEXT,                      
);

CREATE TABLE Prescricao.farmaceutica(
    numReg              INT         PRIMARY KEY NOT NULL,
    nome                VARCHAR(60) UNIQUE,
    endereco            TEXT,                      
);

CREATE TABLE Prescricao.farmaco(
    numRegFarm          INT         NOT NULL REFERENCES Prescricao.farmaceutica(numReg)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    nome                VARCHAR(60) NOT NULL,
    formula             TEXT,                      
    PRIMARY KEY (numRegFarm, nome),
);

CREATE TABLE Prescricao.prescricao(
    numPresc            INT         PRIMARY KEY NOT NULL,
    numUtente           INT         NOT NULL REFERENCES Prescricao.paciente(numSNS)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    numMedico           INT         NOT NULL REFERENCES Prescricao.medico(numSNS)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    farmacia            VARCHAR(60) REFERENCES Prescricao.farmacia(nome)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    dataProc            DATE,
);

CREATE TABLE Prescricao.presc_farmaco(
    numPresc            INT         NOT NULL REFERENCES Prescricao.prescricao(numPresc)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    numRegFarm          INT         NOT NULL,
    nomeFarmaco         VARCHAR(60) NOT NULL,
    FOREIGN KEY (numRegFarm, nomeFarmaco) REFERENCES Prescricao.farmaco(numRegFarm, nome)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY (numPresc, numRegFarm, nomeFarmaco),
);


-- ###############################################################
-- b) introducao de dados

INSERT INTO PRESCRICAO.MEDICO(numSNS,nome,especialidade)VALUES(101,'Joao Pires Lima','Cardiologia')
INSERT INTO PRESCRICAO.MEDICO(numSNS,nome,especialidade)VALUES(102,'Manuel Jose Rosa','Cardiologia')
INSERT INTO PRESCRICAO.MEDICO(numSNS,nome,especialidade)VALUES(103,'Rui Luis Caraca','Pneumologia')
INSERT INTO PRESCRICAO.MEDICO(numSNS,nome,especialidade)VALUES(104,'Sofia Sousa Silva','Radiologia')
INSERT INTO PRESCRICAO.MEDICO(numSNS,nome,especialidade)VALUES(105,'Ana Barbosa','Neurologia')
INSERT INTO PRESCRICAO.PACIENTE(numUtente,nome,dataNasc,endereco)VALUES(1,'Renato Manuel Cavaco','1980-01-03','Rua Nova do Pilar 35')
INSERT INTO PRESCRICAO.PACIENTE(numUtente,nome,dataNasc,endereco)VALUES(2,'Paula Vasco Silva','1972-10-30','Rua Direita 43')
INSERT INTO PRESCRICAO.PACIENTE(numUtente,nome,dataNasc,endereco)VALUES(3,'Ines Couto Souto','1985-05-12','Rua de Cima 144')
INSERT INTO PRESCRICAO.PACIENTE(numUtente,nome,dataNasc,endereco)VALUES(4,'Rui Moreira Porto','1970-12-12','Rua Zig Zag 235')
INSERT INTO PRESCRICAO.PACIENTE(numUtente,nome,dataNasc,endereco)VALUES(5,'Manuel Zeferico Polaco','1990-06-05','Rua da Baira Rio 1135')
INSERT INTO PRESCRICAO.FARMACIA(nome,telefone,endereco)VALUES('Farmacia BelaVista',221234567,'Avenida Principal 973')
INSERT INTO PRESCRICAO.FARMACIA(nome,telefone,endereco)VALUES('Farmacia Central',234370500,'Avenida da Liberdade 33')
INSERT INTO PRESCRICAO.FARMACIA(nome,telefone,endereco)VALUES('Farmacia Peixoto',234375111,'Largo da Vila 523')
INSERT INTO PRESCRICAO.FARMACIA(nome,telefone,endereco)VALUES('Farmacia Vitalis',229876543,'Rua Visconde Salgado 263')
INSERT INTO PRESCRICAO.FARMACEUTICA(numReg,nome,endereco)VALUES(905,'Roche','Estrada Nacional 249')
INSERT INTO PRESCRICAO.FARMACEUTICA(numReg,nome,endereco)VALUES(906,'Bayer','Rua da Quinta do Pinheiro 5')
INSERT INTO PRESCRICAO.FARMACEUTICA(numReg,nome,endereco)VALUES(907,'Pfizer','Empreendimento Lagoas Park - Edificio 7')
INSERT INTO PRESCRICAO.FARMACEUTICA(numReg,nome,endereco)VALUES(908,'Merck','Alameda Fernão Lopes 12')
INSERT INTO PRESCRICAO.FARMACO(numRegFarm,nome,formula)VALUES(905,'Boa Saude em 3 Dias','XZT9')
INSERT INTO PRESCRICAO.FARMACO(numRegFarm,nome,formula)VALUES(906,'Voltaren Spray','PLTZ32')
INSERT INTO PRESCRICAO.FARMACO(numRegFarm,nome,formula)VALUES(906,'Xelopironi 350','FRR-34')
INSERT INTO PRESCRICAO.FARMACO(numRegFarm,nome,formula)VALUES(906,'Gucolan 1000','VFR-750')
INSERT INTO PRESCRICAO.FARMACO(numRegFarm,nome,formula)VALUES(907,'GEROaero Rapid','DDFS-XEN9')
INSERT INTO PRESCRICAO.FARMACO(numRegFarm,nome,formula)VALUES(908,'Aspirina 1000','BIOZZ02')
INSERT INTO PRESCRICAO.PRESCRICAO(numPresc,numUtente,numMedico,farmacia,dataProc)VALUES(10001,1,105,'Farmacia Central','2015-03-03')
INSERT INTO PRESCRICAO.PRESCRICAO(numPresc,numUtente,numMedico,farmacia,dataProc)VALUES(10002,1,105,NULL,NULL)
INSERT INTO PRESCRICAO.PRESCRICAO(numPresc,numUtente,numMedico,farmacia,dataProc)VALUES(10003,3,102,'Farmacia Central','2015-01-17')
INSERT INTO PRESCRICAO.PRESCRICAO(numPresc,numUtente,numMedico,farmacia,dataProc)VALUES(10004,3,101,'Farmacia BelaVista','2015-02-09')
INSERT INTO PRESCRICAO.PRESCRICAO(numPresc,numUtente,numMedico,farmacia,dataProc)VALUES(10005,3,102,'Farmacia Central','2015-01-17')
INSERT INTO PRESCRICAO.PRESCRICAO(numPresc,numUtente,numMedico,farmacia,dataProc)VALUES(10006,4,102,'Farmacia Vitalis','2015-02-22')
INSERT INTO PRESCRICAO.PRESCRICAO(numPresc,numUtente,numMedico,farmacia,dataProc)VALUES(10007,5,103,NULL,NULL)
INSERT INTO PRESCRICAO.PRESCRICAO(numPresc,numUtente,numMedico,farmacia,dataProc)VALUES(10008,1,103,'Farmacia Central','2015-01-02')
INSERT INTO PRESCRICAO.PRESCRICAO(numPresc,numUtente,numMedico,farmacia,dataProc)VALUES(10009,3,102,'Farmacia Peixoto','2015-02-02')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10001,905,'Boa Saude em 3 Dias')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10002,907,'GEROaero Rapid')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10003,906,'Voltaren Spray')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10003,906,'Xelopironi 350')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10003,908,'Aspirina 1000')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10004,905,'Boa Saude em 3 Dias')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10004,908,'Aspirina 1000')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10005,906,'Voltaren Spray')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10006,905,'Boa Saude em 3 Dias')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10006,906,'Voltaren Spray')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10006,906,'Xelopironi 350')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10006,908,'Aspirina 1000')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10007,906,'Voltaren Spray')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10008,905,'Boa Saude em 3 Dias')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10008,908,'Aspirina 1000')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10009,905,'Boa Saude em 3 Dias')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10009,906,'Voltaren Spray')
INSERT INTO PRESCRICAO.PRESC_FARMACO(numPresc,numRegFarm,nomeFarmaco)VALUES(10009,908,'Aspirina 1000')



-- ######################################################################
-- c) traducao de AR pra SQL 

-- 5.3 a)
-- Lista de pacientes que nunca tiveram prescrição

SELECT paciente.numUtente, paciente.nome
	FROM (
        Prescricao.paciente LEFT JOIN Prescricao.prescricao 
            ON paciente.numUtente=prescricao.numUtente
    )
	WHERE prescricao.numPresc IS NULL


-- 5.3 b)
-- Número de prescrições por especialidade médica

SELECT medico.especialidade, COUNT(medico.especialidade) as numPrescricoes
	FROM(
		Prescricao.prescricao JOIN Prescricao.medico
			ON prescricao.numMedico=medico.numSNS
	)
	GROUP BY medico.especialidade


-- 5.3 c)
-- Número de prescrições processadas por farmácia

SELECT farmacia.nome, COUNT(farmacia.nome) as numPrescricoesProcessadas
	FROM (
		Prescricao.farmacia JOIN Prescricao.prescricao
			ON farmacia.nome=prescricao.farmacia
	)
	GROUP BY farmacia.nome


-- 5.3 d)
-- Lista de fármacos da farmacêutica nr. 906 nunca prescritos

(
	SELECT farmaco.nome
		FROM Prescricao.farmaco
	WHERE farmaco.numRegFarm=906
) EXCEPT (
	SELECT DISTINCT presc_farmaco.nomeFarmaco
		FROM(
			Prescricao.prescricao LEFT JOIN Prescricao.presc_farmaco
				ON prescricao.numPresc=presc_farmaco.numPresc
		)
		WHERE presc_farmaco.numRegFarm=906
)


-- 5.3 e)
-- Para cada farmácia, o número de fármacos de cada farmacêutica vendidos

SELECT prescricao.farmacia, farmaceutica.nome, COUNT(farmaceutica.numReg) AS numFarmacosVendidos
	FROM (
		(Prescricao.prescricao LEFT JOIN Prescricao.presc_farmaco
			ON prescricao.numPresc=presc_farmaco.numPresc) LEFT JOIN Prescricao.farmaceutica
				ON presc_farmaco.numRegFarm=farmaceutica.numReg
	)
	WHERE farmacia IS NOT NULL
	GROUP BY prescricao.farmacia, farmaceutica.nome


-- 5.3 f)
-- Pacientes que tiveram prescrições de médicos diferentes

SELECT prescricao.numUtente
	FROM (
		Prescricao.prescricao LEFT JOIN Prescricao.medico
			ON prescricao.numMedico=medico.numSNS
	)
	GROUP BY prescricao.numUtente
	HAVING COUNT(prescricao.numMedico)>1
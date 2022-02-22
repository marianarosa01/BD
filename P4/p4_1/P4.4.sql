use p3g1 
go

/*
DROP TABLE Especialidade;
DROP TABLE Medico;
DROP TABLE Paciente;
DROP TABLE Farmacia;
DROP TABLE Farmacos;
DROP TABLE Prescricao;
DROP TABLE CompanhiaFarmaceutica;
DROP TABLE ProduzirMedicamentos;
DROP TABLE Venda; */


CREATE TABLE Especialidade(
	tipoEspecialidade				VARCHAR(30)		NOT NULL,	
	codigo							INT				NOT NULL,
	PRIMARY KEY(codigo) 
);

CREATE TABLE Medico (
	n_id							INT				NOT NULL,
	Nome							VARCHAR(30)		NOT NULL,
	codigoEspecialidade				INT				NOT NULL,
	PRIMARY KEY(n_id),
	FOREIGN KEY(codigoEspecialidade)	REFERENCES	Especialidade(codigo));


CREATE TABLE Paciente(
	DataNasc						DATE				NOT NULL,
	endereco						VARCHAR(20), 
	Nome							VARCHAR(30)			NOT NULL,
	N_utente						INT					NOT NULL,
	PRIMARY KEY(N_utente),
);


CREATE TABLE Farmacia (
	Telefone						INT					NOT NULL,
	Endereco						VARCHAR(30),	
	Nome							INT 				NOT NULL,
	F_NIF							INT					NOT NULL,
	PRIMARY KEY(F_NIF),
	); 

CREATE TABLE Farmacos(
	Nome_comercial					VARCHAR(20)			NOT NULL,
	Formula							VARCHAR(20) 		NOT NULL,
	PRIMARY KEY(Formula),
);

CREATE TABLE Prescricao(
	Dataa							DATE,				 
	n_prescricao					INT					NOT NULL,
	Medico_responsavel				INT,
	Farmacia						INT,
	Paciente						INT,
	Farmacos						VARCHAR(20),
	PRIMARY KEY(n_prescricao),
	FOREIGN KEY(Medico_responsavel)	REFERENCES Medico(n_id),
	FOREIGN KEY(Farmacia)	REFERENCES Farmacia(F_NIF),
	FOREIGN KEY(Paciente)	REFERENCES Paciente(N_utente),
	FOREIGN KEY(Farmacos)	REFERENCES Farmacos(Formula));



CREATE TABLE CompanhiaFarmaceutica(
	N_Registo_nacional				INT					NOT NULL,
	Nome							VARCHAR(20),
	Telefone						INT					NOT NULL,
	PRIMARY KEY(N_Registo_Nacional),
);

CREATE TABLE ProduzirMedicamentos(
	companhia_farmaceutica			INT					NOT NULL,
	medicamentos					VARCHAR(20)			NOT NULL,
	PRIMARY KEY (companhia_farmaceutica, medicamentos),
	FOREIGN KEY(companhia_farmaceutica)		REFERENCES	CompanhiaFarmaceutica(N_Registo_nacional),
	FOREIGN KEY(medicamentos)				REFERENCES Farmacos(Formula));


CREATE TABLE Venda(
	Farmacia						INT					NOT NULL,
	Produtos						VARCHAR(20)			NOT NULL,
	PRIMARY KEY (Farmacia, Produtos),
	FOREIGN KEY(Farmacia)	REFERENCES	Farmacia(F_NIF),
	FOREIGN KEY(Produtos)	REFERENCES  Farmacos(Formula));









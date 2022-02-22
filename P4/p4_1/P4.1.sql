use ArtGalery 
go
/*
DROP TABLE RENTACAR.Similaridade;
DROP TABLE RENTACAR.Pesado;
DROP TABLE RENTACAR.Ligeiro;
DROP TABLE RENTACAR.Aluguer;
DROP TABLE RENTACAR.Veiculo;
DROP TABLE RENTACAR.Tipo_Veiculo;
DROP TABLE RENTACAR.Balcao;
DROP TABLE RENTACAR.Cliente;
*/


CREATE TABLE ArtGalery.Pessoa(
	NIF							INT				NOT NULL,	
	Nome						VARCHAR(30)		NOT NULL,
	Endereço					VARCHAR(32),
	Data_Nascimento				VARCHAR(30)		NOT NULL,
	PRIMARY KEY(NIF) );
	

CREATE TABLE ArtGalery.Visitante (
	N_Bilhete					INT				NOT NULL,
	Idade						INT				NOT NULL, 
	PRIMARY KEY(N_Bilhete));


CREATE TABLE ArtGalery.Artista(
	NIF_Artista					INT				NOT NULL,
	PRIMARY KEY(NIF_Artista),
	FOREIGN KEY(NIF_Artista)	REFERENCES ArtGalery.Pessoa(NIF),
	Estilo						VARCHAR(20), 

);

CREATE TABLE ArtGalery.Funcionario(
	NIF_Funcionario					INT				NOT NULL,
	FOREIGN KEY(NIF_Funcionario)	REFERENCES		ArtGalery.Pessoa(NIF),
	Num_Funcionario					INT				NOT NULL,
	PRIMARY KEY(NIF_Funcionario, Num_Funcionario),

);


CREATE TABLE ArtGalery.Gerente (
	NIF_Funcionario					INT				NOT NULL,
	FOREIGN KEY(NIF_Funcionario)	REFERENCES		ArtGalery.Pessoa(NIF),
	Num_Funcionario					INT				NOT NULL,
	FOREIGN KEY(Num_Funcionario)	REFERENCES		ArtGalery.Funcionario(Num_Funcionario),
	PRIMARY KEY(NIF_Funcionario, Num_Funcionario),
	); 


CREATE TABLE ArtGalery.Guia (
	NIF_Funcionario					INT				NOT NULL,
	FOREIGN KEY(NIF_Funcionario)	REFERENCES		ArtGalery.Pessoa(NIF),
	Num_Funcionario					INT				NOT NULL,
	FOREIGN KEY(Num_Funcionario)	REFERENCES		ArtGalery.Funcionario(Num_Funcionario),
	PRIMARY KEY(NIF_Funcionario, Num_Funcionario),
	); 

CREATE TABLE ArtGalery.Seguranca (
	NIF_Funcionario					INT				NOT NULL,
	FOREIGN KEY(NIF_Funcionario)	REFERENCES		ArtGalery.Pessoa(NIF),
	Num_Funcionario					INT				NOT NULL,
	FOREIGN KEY(Num_Funcionario)	REFERENCES		ArtGalery.Funcionario(Num_Funcionario),
	PRIMARY KEY(NIF_Funcionario, Num_Funcionario),
	);

CREATE TABLE ArtGalery.Rececionista (
	NIF_Funcionario					INT				NOT NULL,
	FOREIGN KEY(NIF_Funcionario)	REFERENCES		ArtGalery.Pessoa(NIF),
	Num_Funcionario					INT				NOT NULL,
	FOREIGN KEY(Num_Funcionario)	REFERENCES		ArtGalery.Funcionario(Num_Funcionario),
	PRIMARY KEY(NIF_Funcionario, Num_Funcionario),
	); 

CREATE TABLE ArtGalery.Bilhete (
	Preco							FLOAT			NOT NULL,
	/* incompleto */
);


CREATE TABLE ArtGalery.ObraArte(
	Referencia					INT					NOT NULL,
	Data_Producao				VARCHAR(30)			NOT NULL,
	Valor						INT,
	Descricao					VARCHAR(100),
	Titulo						VARCHAR(30)		NOT NULL,
	PRIMARY KEY(Referencia),	
);	 

CREATE TABLE ArtGalery.Filme(
	Referencia					INT					NOT NULL,
	Genero						VARCHAR(30)			NOT NULL,
	Duracao						VARCHAR(20),
	Realizador					VARCHAR(30),
	Elenco						VARCHAR(100),
	PRIMARY KEY(Referencia),
	FOREIGN KEY(Referencia)		REFERENCES			ArtGalery.ObraArte(Referencia),
);	 

CREATE TABLE ArtGalery.Pintura(
	Referencia					INT					NOT NULL,
	Tecnica						VARCHAR(30),
	PRIMARY KEY(Referencia),
	FOREIGN KEY(Referencia)		REFERENCES			ArtGalery.ObraArte(Referencia),
);	 

CREATE TABLE ArtGalery.Escultura(
	Referencia					INT					NOT NULL,
	Tecnica						VARCHAR(30),
	Material					VARCHAR(50),
	PRIMARY KEY(Referencia),
	FOREIGN KEY(Referencia)		REFERENCES			ArtGalery.ObraArte(Referencia),
);	 

CREATE TABLE ArtGalery.Artista_Produz(
	Arte_Ref					INT					NOT NULL,
	Artista_Id					INT					NOT NULL,
	FOREIGN KEY(Arte_Ref)		REFERENCES			ArtGalery.ObraArte(Referencia),
	FOREIGN KEY(Artista_Id)		REFERENCES			ArtGalery.Artista(NIF_Artista),
	PRIMARY KEY(Arte_Ref, Artista_Id)
);

CREATE TABLE ArtGalery.Sala(
	Num_sala					INT					NOT NULL,
	Piso						INT					NOT NULL,
	PRIMARY KEY(Num_Sala)
);

CREATE TABLE ArtGalery.Exposicao(
	Estilo						VARCHAR(30),
	DataExposicao				VARCHAR(50),
	Nome						VARCHAR(50)		NOT NULL,
	Num_sala					INT					NOT NULL,
	FOREIGN KEY(Num_sala)		REFERENCES			ArtGalery.Sala(Num_Sala),
	PRIMARY KEY(Nome, Num_Sala)
);
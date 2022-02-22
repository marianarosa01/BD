
use Lokals
go

CREATE TABLE Lokals.Users(
	userId						INT	IDENTITY(1,1)				NOT NULL,
	username					VARCHAR(30)		,
	password_					VARCHAR(50),
	email						VARCHAR(30)		,
	name_						VARCHAR(30),
	cellphone					INT,
	country						VARCHAR(30),
	is_a_host				BIT,				
	PRIMARY KEY(userId) );

	
/*
CREATE TABLE ArtGallery.Visitante (
	ID_Visitante				INT	  IDENTITY(1,1)		NOT NULL,
	FK_NIF						INT				NOT NULL,
	FOREIGN KEY(FK_NIF)			REFERENCES		ArtGallery.Pessoa(NIF),
	PRIMARY KEY(ID_Visitante, FK_NIF)
	);


CREATE TABLE ArtGallery.Artista(
	ID_Artista					INT			NOT NULL,
	Especialidade				VARCHAR(20), 
	Nome						VARCHAR(30)		NOT NULL,
	Data_Nascimento				VARCHAR(30)		NOT NULL,
	Data_obito					VARCHAR(30),
	PRIMARY KEY(ID_Artista)
);

CREATE TABLE ArtGallery.Funcionario(
	NIF_Funcionario					INT				NOT NULL,
	FOREIGN KEY(NIF_Funcionario)	REFERENCES		ArtGallery.Pessoa(NIF),
	Num_Funcionario					INT		IDENTITY(1,1)		NOT NULL,
	Palavra_Pass					VARCHAR(15)			NOT NULL,
	PRIMARY KEY(Num_Funcionario,NIF_Funcionario),
);




CREATE TABLE ArtGallery.Gerente (
	NIF_Funcionario							INT				NOT NULL,
	Num_Funcionario_Gerente					INT				NOT NULL,
	FOREIGN KEY(Num_Funcionario_Gerente,NIF_Funcionario)	REFERENCES		ArtGallery.Funcionario(Num_Funcionario,NIF_Funcionario),
	PRIMARY KEY(NIF_Funcionario, Num_Funcionario_Gerente),
	); 


CREATE TABLE ArtGallery.Guia (
	NIF_Funcionario					INT				NOT NULL,
	Num_Funcionario					INT				NOT NULL,
	FOREIGN KEY(Num_Funcionario, NIF_Funcionario)	REFERENCES		ArtGallery.Funcionario(Num_Funcionario,NIF_Funcionario),
	PRIMARY KEY(Num_Funcionario),
	); 

CREATE TABLE ArtGallery.Seguranca (
	NIF_Funcionario					INT				NOT NULL,
	Num_Funcionario					INT				NOT NULL,
	FOREIGN KEY(Num_Funcionario, NIF_Funcionario)	REFERENCES		ArtGallery.Funcionario(Num_Funcionario,NIF_Funcionario),
	PRIMARY KEY(Num_Funcionario),
	);

CREATE TABLE ArtGallery.Rececionista (
	NIF_Funcionario					INT				NOT NULL,
	Num_Funcionario					INT				NOT NULL,
	FOREIGN KEY(Num_Funcionario, NIF_Funcionario)	REFERENCES		ArtGallery.Funcionario(Num_Funcionario,NIF_Funcionario),
	PRIMARY KEY(Num_Funcionario, NIF_Funcionario),
	); 



CREATE TABLE ArtGallery.Grupo (
	N_pessoas						INT			NOT NULL, 
	ID_grupo						INT		IDENTITY(1,1)		NOT NULL,
	PRIMARY KEY (ID_grupo)

);

CREATE TABLE ArtGallery.Bilhete (
	Preco							FLOAT,
	N_bilhete						INT		IDENTITY(1,1)   NOT NULL,
	Validade						VARCHAR(20),
	NIF_Rececionista				INT				NOT NULL,
	Num_Func_Rececionista			INT				NOT NULL,
	Data_venda						VARCHAR(12),
	FOREIGN KEY(Num_Func_Rececionista, NIF_Rececionista)	REFERENCES		ArtGallery.Rececionista(Num_Funcionario, NIF_Funcionario),
	PRIMARY KEY (N_bilhete,Data_venda)
);



CREATE TABLE ArtGallery.Bilhetes_Grupo (
	FK_Grupo_ID						INT,
	N_bilhete						INT									NOT NULL,
	Max_visitantes					INT,
	Data_venda_bilhete				VARCHAR(12),								
	FOREIGN KEY(FK_Grupo_ID)		REFERENCES							ArtGallery.Grupo(ID_grupo),
	FOREIGN KEY(N_bilhete,Data_venda_bilhete)			REFERENCES		ArtGallery.Bilhete(N_bilhete,Data_venda),
	PRIMARY KEY (N_bilhete,Data_venda_bilhete)

);


CREATE TABLE ArtGallery.Bilhete_individual (
	ID_visitante					INT				NOT NULL,
	N_bilhete						INT				NOT NULL,
	NIF_visitante					INT,
	Data_venda_bilhete				VARCHAR(12),
	PRIMARY KEY (N_bilhete),
	FOREIGN KEY(N_bilhete,Data_venda_bilhete)	REFERENCES	ArtGallery.Bilhete(N_bilhete,Data_venda),
	FOREIGN KEY (ID_visitante,NIF_visitante) REFERENCES ArtGallery.Visitante(ID_Visitante, FK_NIF)
);

CREATE TABLE ArtGallery.Sala(
	Num_sala					INT					NOT NULL,
	Piso						INT					NOT NULL,
	PRIMARY KEY(Num_Sala)
);


CREATE TABLE ArtGallery.Exposicao(
	Estilo						VARCHAR(30),
	DataExposicao				VARCHAR(50),
	Nome						VARCHAR(50)			NOT NULL,
	Num_sala_id					INT					NOT NULL,
	PRIMARY KEY(Nome,Num_sala_id),
	FOREIGN KEY(Num_sala_id)	REFERENCES		ArtGallery.Sala(Num_Sala)
	
);



GO


CREATE TABLE ArtGallery.ObrasDeArtes(
	Referencia					INT			IDENTITY(1,1)		NOT NULL,
	Data_Producao				VARCHAR(30)			NOT NULL,
	Valor						INT,
	Descricao					VARCHAR(700),
	Titulo						VARCHAR(100)		NOT NULL,
	FK_Exposicao_Nome			VARCHAR(50)			NOT NULL,
	FK_Artista					INT,
	Num_sala					INT,
	PRIMARY KEY(Referencia),	
	FOREIGN KEY(FK_Artista)	REFERENCES			ArtGallery.Artista(ID_Artista),
	FOREIGN KEY(FK_Exposicao_Nome,Num_sala)	REFERENCES	 ArtGallery.Exposicao(Nome,Num_sala_id),
);	 



CREATE TABLE ArtGallery.Filme(
	Referencia					INT					NOT NULL,
	Genero						VARCHAR(30)			NOT NULL,
	Duracao						VARCHAR(20),
	Realizador					VARCHAR(30),
	Elenco						VARCHAR(100),
	PRIMARY KEY(Referencia),
	FOREIGN KEY(Referencia)		REFERENCES			ArtGallery.ObrasDeArtes(Referencia),
);	 

CREATE TABLE ArtGallery.Pintura(
	Referencia					INT					NOT NULL,
	Tecnica						VARCHAR(30),
	PRIMARY KEY(Referencia),
	FOREIGN KEY(Referencia)		REFERENCES			ArtGallery.ObrasDeArtes(Referencia),
);	 

CREATE TABLE ArtGallery.Escultura(
	Referencia					INT					NOT NULL,
	Tecnica						VARCHAR(30),
	Material					VARCHAR(50),
	PRIMARY KEY(Referencia),
	FOREIGN KEY(Referencia)		REFERENCES			ArtGallery.ObrasDeArtes(Referencia),
);	 

CREATE TABLE ArtGallery.Artista_Produz(
	Arte_Ref					INT					NOT NULL,
	Artista_Id					INT					NOT NULL,
	FOREIGN KEY(Arte_Ref)		REFERENCES			ArtGallery.ObrasDeArtes(Referencia),
	FOREIGN KEY(Artista_Id)		REFERENCES			ArtGallery.Artista(ID_Artista),
	PRIMARY KEY(Arte_Ref, Artista_Id)
);

CREATE TABLE ArtGallery.VisitasGuiadas(
	FK_Grupo_ID					INT					NOT NULL,
	N_bilhete_Grupo				INT,
	Data_visita					VARCHAR(12),
	N_Fun_Guia					INT,
	FOREIGN KEY(N_bilhete_Grupo, Data_visita)	REFERENCES  ArtGallery.Bilhetes_Grupo(N_bilhete,Data_venda_bilhete),
	FOREIGN KEY(N_Fun_Guia) REFERENCES ArtGallery.Guia(Num_Funcionario)
);





*/
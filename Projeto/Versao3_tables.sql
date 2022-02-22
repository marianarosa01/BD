DROP	SCHEMA ArtGallery;
go
DROP TABLE ArtGallery.Exposicao;
GO
DROP TABLE ArtGallery.Sala;
GO
DROP TABLE ArtGallery.Artista_Produz;
GO
DROP TABLE ArtGallery.Escultura;
GO
DROP TABLE ArtGallery.Pintura;
GO
DROP TABLE ArtGallery.Filme;
GO
DROP TABLE ArtGallery.ObraArte;
GO
DROP TABLE ArtGallery.Bilhete_individual;
GO
DROP TABLE ArtGallery.Bilhete_Grupo;
GO
DROP TABLE ArtGallery.Bilhete;
GO
DROP TABLE ArtGallery.Grupo;
GO
DROP TABLE ArtGallery.Rececionista;
GO
DROP TABLE ArtGallery.Segurança;
GO
DROP TABLE ArtGallery.Guia;
GO
DROP TABLE ArtGallery.Gerente;
GO

DROP TABLE ArtGallery.Artista;
GO
DROP TABLE ArtGallery.Visitante;
GO
DROP TABLE ArtGallery.Pessoa;
GO
DROP TABLE ArtGallery.Funcionario;
GO


CREATE SCHEMA ArtGallery;
go



CREATE TABLE ArtGallery.Pessoa(
	NIF							INT			NOT NULL,
	Nome						VARCHAR(30)		NOT NULL,
	Endereco					VARCHAR(32),
	Data_Nascimento				VARCHAR(30)		NOT NULL,
	PRIMARY KEY(NIF) );
	

CREATE TABLE ArtGallery.Visitante (
	ID_Visitante				INT				NOT NULL,
	FK_NIF						INT				NOT NULL,
	FOREIGN KEY(FK_NIF)			REFERENCES		ArtGallery.Pessoa(NIF),
	PRIMARY KEY(ID_Visitante, FK_NIF)
	);

CREATE TABLE ArtGallery.Artista(
	ID_Artista					INT				NOT NULL,
	Especialidade				VARCHAR(20), 
	Nome						VARCHAR(30)		NOT NULL,
	Data_Nascimento				VARCHAR(30)		NOT NULL,
	Data_obito					VARCHAR(30),
	PRIMARY KEY(ID_Artista)
);

CREATE TABLE ArtGallery.Funcionario(
	NIF_Funcionario					INT				NOT NULL,
	FOREIGN KEY(NIF_Funcionario)	REFERENCES		ArtGallery.Pessoa(NIF),
	Num_Funcionario					INT				NOT NULL,
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
	PRIMARY KEY(Num_Funcionario),
	); 


CREATE TABLE ArtGallery.Grupo (
	N_pessoas						INT				NOT NULL,
	ID_grupo						INT				NOT NULL,
	PRIMARY KEY (ID_grupo)

);

CREATE TABLE ArtGallery.Bilhete (
	Preco							FLOAT,
	N_bilhete						INT				NOT NULL,
	Validade						VARCHAR(20),
	NIF_Rececionista				INT				NOT NULL,
	Num_Func_Rececionista			INT				Not Null,
	Data_venda						Date,
	FOREIGN KEY(Num_Func_Rececionista, NIF_Rececionista)	REFERENCES		ArtGallery.Rececionista(Num_Funcionario, NIF_Funcionario),
	PRIMARY KEY (N_bilhete,Data_venda)
);

 Update ArtGallery.Bilhete
      SET Data_venda= DateAdd(d, ROUND(DateDiff(d, '2015-01-01', '2020-12-31') * RAND(CHECKSUM(NEWID())), 0),
      DATEADD(second,CHECKSUM(NEWID())%48000, '2010-01-01'))

CREATE TABLE ArtGallery.Bilhete_Grupo (
	FK_Grupo_ID						INT,
	N_bilhete						INT				NOT NULL,
	Max_visitantes					INT,
	Data_venda_bilhete				Date			NOT NULL,
	FOREIGN KEY(FK_Grupo_ID)		REFERENCES		ArtGallery.Grupo(ID_grupo),
	FOREIGN KEY(N_bilhete,Data_venda_bilhete)			REFERENCES		ArtGallery.Bilhete(N_bilhete,Data_venda),
	PRIMARY KEY (N_bilhete,Data_venda_bilhete)

);

CREATE TABLE ArtGallery.Bilhete_individual (
	ID_visitante					INT				NOT NULL,
	N_bilhete						INT				NOT NULL,
	NIF_visitante					INT,
	Data_venda_bilhete				Date			NOT NULL,
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

-- atualizar esta tb
CREATE TABLE ArtGallery.ObraArte(
	Referencia					INT					NOT NULL,
	Data_Producao				VARCHAR(30)			NOT NULL,
	Valor						INT,
	Descricao					VARCHAR(100),
	Titulo						VARCHAR(30)		NOT NULL,
	FK_Exposicao_Nome			VARCHAR(50)		NOT NULL,
	FK_Artista					INT,
	Num_sala					INT,
	PRIMARY KEY(Referencia),	
	FOREIGN KEY(FK_Artista)	REFERENCES			ArtGallery.Artista(ID_Artista),
	FOREIGN KEY(FK_Exposicao_Nome,Num_sala)	REFERENCES	 ArtGallery.Exposicao(Nome,Num_sala_id),
	-- nao funciona :/
);	 

CREATE TABLE ArtGallery.Filme(
	Referencia					INT					NOT NULL,
	Genero						VARCHAR(30)			NOT NULL,
	Duracao						VARCHAR(20),
	Realizador					VARCHAR(30),
	Elenco						VARCHAR(100),
	PRIMARY KEY(Referencia),
	FOREIGN KEY(Referencia)		REFERENCES			ArtGallery.ObraArte(Referencia),
);	 

CREATE TABLE ArtGallery.Pintura(
	Referencia					INT					NOT NULL,
	Tecnica						VARCHAR(30),
	PRIMARY KEY(Referencia),
	FOREIGN KEY(Referencia)		REFERENCES			ArtGallery.ObraArte(Referencia),
);	 

CREATE TABLE ArtGallery.Escultura(
	Referencia					INT					NOT NULL,
	Tecnica						VARCHAR(30),
	Material					VARCHAR(50),
	PRIMARY KEY(Referencia),
	FOREIGN KEY(Referencia)		REFERENCES			ArtGallery.ObraArte(Referencia),
);	 

CREATE TABLE ArtGallery.Artista_Produz(
	Arte_Ref					INT					NOT NULL,
	Artista_Id					INT					NOT NULL,
	FOREIGN KEY(Arte_Ref)		REFERENCES			ArtGallery.ObraArte(Referencia),
	FOREIGN KEY(Artista_Id)		REFERENCES			ArtGallery.Artista(ID_Artista),
	PRIMARY KEY(Arte_Ref, Artista_Id)
);

CREATE TABLE ArtGallery.VisitaGuiada(
	FK_Grupo_ID					INT					NOT NULL,
	N_bilhete_Grupo				INT,
	Data_visita					DATE,
	N_Fun_Guia					INT,
	FOREIGN KEY(N_bilhete_Grupo, Data_visita)	REFERENCES  ArtGallery.Bilhete_Grupo(N_bilhete,Data_venda_bilhete),
	FOREIGN KEY(N_Fun_Guia) REFERENCES ArtGallery.Guia(Num_Funcionario)
);



--insert into ArtGallery.Pintura (FK_Referencia,Tecnica, DataProducao, Valor, Titulo) values (‘1234512345’, ‘pintura a óleo’,’1503’,’850M’,’Mona Lisa’)


-- Pessoa
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (383018520,'Noel Bruffell','74 Mariners Cove Road','15/06/1987');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (382429264,'Marv Pinnegar','4 Beilfuss Trail','13/03/2019');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (325127818,'Corrinne Sandell','249 Pierstorff Place','01/10/2008');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (288556962,'Brandea Accum','83 Ridge Oak Lane','12/11/2008');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (310168972,'Carmela Girardi','8 Logan Center','13/01/1996');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (362058041,'Alicia Wasylkiewicz','544 Bonner Hill','02/03/2006');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (396130510,'Olva Standage','60774 Grasskamp Park','10/06/2013');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (322981446,'Rosetta Allderidge','629 Division Hill','10/10/2014');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (376665950,'Nickie Dameisele','2 Mosinee Drive','17/08/2001');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (230728524,'Gennifer Baldacchino','1 Waxwing Terrace','15/10/1995');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (297985648,'Alisander Player','942 Pawling Plaza','17/04/2017');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (216872294,'Debby Harriday','8 Lerdahl Way','06/09/2013');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (211278590,'Fina Jurick','94177 Farwell Center','20/07/1997');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (343244790,'Butch Cluderay','54973 South Hill','15/04/2017');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (263697967,'Emmaline Rableau','7 Fieldstone Place','19/03/1994');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (349000112,'Lilith Ferruzzi','82174 Eggendart Alley','23/12/2006');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (398186618,'Emmit Ochterlony','705 Nomekagon Alley','23/04/1992');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (234470537,'Marlowe Cajkler','163 Knutson Hill','05/02/1997');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (328783621,'Pip Phipard-Shears','83737 Gale Circle','07/09/1992');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (341880686,'Sadella Edwards','1356 Grasskamp Alley','05/04/1995');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (297972294,'Adam Elcox','99854 Ridge Oak Place','28/06/1992');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (262593095,'Padgett Greydon','03 Ohio Junction','10/10/2009');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (233650675,'Gilberte Pelzer','1615 Waywood Avenue','23/05/1983');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (341809992,'Eberhard Sheringham','55 Prairieview Circle','20/10/2017');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (385866285,'Gusta Buxey','4869 Eggendart Trail','24/05/1996');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (247468906,'Skipper Pimblott','82 Sloan Junction','18/12/2012');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (276343918,'Janessa Ivanishin','679 American Ash Circle','14/11/2002');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (224356397,'Damiano Sprowson','98 Marcy Crossing','05/02/2008');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (200661103,'Clemmy Sher','63 Manufacturers Park','09/08/2009');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (383054042,'Janina Flucks','0785 Burrows Drive','26/02/2000');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (273413582,'Nicola Pedler','7433 Old Gate Point','18/05/2020');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (276863639,'Lanni Lingley','42081 Riverside Circle','31/08/2013');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (338378623,'Charo Lindup','4795 4th Hill','29/04/2017');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (238871715,'Zelig Walling','13 Nobel Crossing','01/07/2000');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (213220450,'Erica Chilcotte','5263 Dixon Road','02/07/2016');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (343520899,'Gabriella Freschini','727 Ridgeway Junction','16/01/1999');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (398118032,'Levin Branche','07 Susan Point','27/10/2020');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (354161339,'Jillana Cattanach','2689 Sherman Point','28/02/2013');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (370193895,'Harley Sewell','7 Colorado Street','13/08/1999');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (241014943,'Harris Nettle','492 Brown Junction','23/06/1982');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (286953478,'Delora Whatford','0 Harper Plaza','17/02/1997');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (224322824,'Ninette Appleby','1225 Sunnyside Drive','28/02/2003');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (309937850,'Rosalinde Blastock','32860 Myrtle Center','19/09/2011');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (379626507,'Evered Assandri','820 Hansons Alley','30/07/1982');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (252297335,'Nicko Lowless','9 Corben Court','03/11/2001');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (316228195,'Coriss Derry','48 Sunfield Drive','18/11/1989');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (350656720,'Emiline Cockland','15851 Sage Place','27/11/1999');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (231964187,'Kristine Gomm','61 Milwaukee Terrace','18/06/2000');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (214716582,'Cort Lymer','83 Meadow Valley Court','07/05/1996');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (389231761,'Ronny MacEntee','4 Oakridge Alley','27/04/1987');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (221230072,'Conrado Briscoe','816 Dorton Road','18/06/2013');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (233631338,'Verge Regus','0 Village Court','01/11/1992');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (250951356,'Derrick Blackstone','9 Saint Paul Alley','04/08/2012');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (373982929,'Audrey Dominick','6276 Hayes Pass','25/09/1994');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (294681055,'Kevyn Bootell','70776 Drewry Circle','01/02/1997');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (327073571,'Gwenette Watman','604 Cody Junction','03/01/1988');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (236215877,'Gail Panswick','97 Muir Alley','15/08/1998');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (337569045,'Selina Ogden','648 Northwestern Drive','05/10/1997');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (307097663,'Neddie Adamek','8 Hallows Hill','10/09/2008');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (224292339,'Osmond Rubega','13 Nova Court','12/03/1991');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (339097470,'Gnni Coolican','155 Garrison Avenue','27/06/2014');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (218392894,'Lyndell Mounce','994 Acker Lane','20/09/1997');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (236066394,'Reynold Townley','2 Corscot Pass','23/08/2020');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (355866247,'Kris Claussen','81731 Superior Terrace','12/12/2002');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (235762164,'Abby Sonschein','45722 Debs Pass','20/11/2010');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (335563249,'Kayle Cheeseman','256 Hanson Avenue','14/02/1984');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (275548182,'Letty Verden','01879 Walton Street','12/04/2004');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (387352872,'Melisande Aronovich','1494 Trailsway Junction','05/08/1983');
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (271842864,'Ari Duplain','3 Comanche Terrace','08/03/2017');

-- Visitante
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (1,383018520);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (2,382429264);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (3,325127818);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (4,288556962);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (5,310168972);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (6,362058041);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (7,396130510);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (8,322981446);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (9,376665950);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (10,230728524);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (11,297985648);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (12,216872294);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (13,211278590);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (14,343244790);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (15,263697967);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (16,349000112);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (17,398186618);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (18,234470537);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (19,328783621);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (20,341880686);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (21,297972294);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (22,262593095);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (23,233650675);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (24,341809992);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (25,385866285);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (26,247468906);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (27,276343918);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (28,224356397);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (29,200661103);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (30,383054042);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (31,273413582);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (32,276863639);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (33,338378623);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (34,238871715);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (35,213220450);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (36,343520899);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (37,398118032);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (38,354161339);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (39,370193895);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (40,241014943);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (41,286953478);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (42,224322824);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (43,309937850);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (44,379626507);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (45,252297335);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (46,316228195);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (47,350656720);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (48,231964187);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (49,214716582);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (50,389231761);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (51,221230072);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (52,233631338);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (53,250951356);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (54,373982929);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (55,294681055);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (56,327073571);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (57,236215877);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (58,337569045);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (59,307097663);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (60,224292339);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (61,339097470);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (62,218392894);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (63,236066394);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (64,355866247);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (65,235762164);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (66,335563249);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (67,275548182);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (68,387352872);
INSERT INTO ArtGallery.Visitante(ID_Visitante,FK_NIF) VALUES (69,271842864);


--grupo

INSERT INTO ArtGallery.Grupo(N_pessoas,ID_grupo) VALUES (8,1);
INSERT INTO ArtGallery.Grupo(N_pessoas,ID_grupo) VALUES (15,2);
INSERT INTO ArtGallery.Grupo(N_pessoas,ID_grupo) VALUES (35,3);
INSERT INTO ArtGallery.Grupo(N_pessoas,ID_grupo) VALUES (9,4);
INSERT INTO ArtGallery.Grupo(N_pessoas,ID_grupo) VALUES (9,5);
INSERT INTO ArtGallery.Grupo(N_pessoas,ID_grupo) VALUES (12,6);
INSERT INTO ArtGallery.Grupo(N_pessoas,ID_grupo) VALUES (14,7);
INSERT INTO ArtGallery.Grupo(N_pessoas,ID_grupo) VALUES (19,8);
INSERT INTO ArtGallery.Grupo(N_pessoas,ID_grupo) VALUES (21,9);
INSERT INTO ArtGallery.Grupo(N_pessoas,ID_grupo) VALUES (39,10);


-- gerentes
INSERT INTO ArtGallery.Pessoa (NIF,Data_Nascimento, Nome,Endereco) values (888855533,'12-04-1975','Rui Mesquita Peres','rua da Saudade, n6, Sintra'),
													(888844433,'10-07-1970','Fátima Seabra Santos','rua Vasco da Gama, n30,Azenhas do Mar')
INSERT INTO ArtGallery.Funcionario values (888855533, 100000), (888844433,100001)
INSERT INTO ArtGallery.Gerente values (888855533, 100000), (888844433,100001)

-- inserçao de guias
INSERT INTO ArtGallery.Pessoa (NIF,Data_Nascimento, Nome,Endereco) values (888842266, '20-05-1980','Artur Mendes Aguiar dos Santos','rua das Laranjeiras, ‘Azóia’'),
					(882242266, '14-08-1984','Rafael Robalo dos Santos','rua do Carvalho,n7,Azenhas do Mar'),
					(886662266, '15-07-1980','Patrícia Rebelo Nunes','rua da Coutada, n8,Azenhas do Mar'),
					(8866627878, '01-08-1979','Ana Sofia Gomes Ferreira','rua Padre António Fidalgo, n5, Almuinhas Velhas')

INSERT INTO ArtGallery.Funcionario (NIF_Funcionario, Num_funcionario) values (888842266,100002), (882242266,100003),(886662266,100004),(8866627878,100005)
INSERT INTO ArtGallery.Guia (Num_funcionario) values (100002), (100003),(100004)

-- rececionistas
INSERT INTO ArtGallery.Pessoa (NIF,Data_Nascimento, Nome,Endereco) values (882242266, '05-05-1970','Rui Malhoa Soares Mendes', 'rua Ferreira Castro')
INSERT INTO ArtGallery.Funcionario (NIF_Funcionario, Num_funcionario) values (882242266,100010)
INSERT INTO ArtGallery.Rececionista (NIF_Funcionario, Num_funcionario) values (882242266,100010)
INSERT INTO ArtGallery.Pessoa (NIF,Data_Nascimento, Nome,Endereco) values (882242276, '01-02-1990','Leonor Patrício', 'Rua Dr. Mario Sacramento')
INSERT INTO ArtGallery.Funcionario (NIF_Funcionario, Num_funcionario) values (882242276,100333)
INSERT INTO ArtGallery.Rececionista (NIF_Funcionario, Num_funcionario) values (882242276,100333)

-- segurança
INSERT INTO ArtGallery.Pessoa (NIF,Data_Nascimento, Nome,Endereco) values (182242277, '25-12-1980','Mónica Ferreira Andrade', 'rua da Fábrica da Vista Alegre'),
													(881142266, '30-08-1979','André Soares Madaíl', 'Avenida das Flores')
INSERT INTO ArtGallery.Funcionario (NIF_Funcionario, Num_funcionario) values (182242277,100015),
															(881142266,100020)
INSERT INTO ArtGallery.Seguranca (NIF_Funcionario, Num_funcionario) values (182242277,100015),
															(881142266,100020)


-- salas
INSERT INTO ArtGallery.Sala (Num_sala, Piso) 
	values (1,0), (2,0),(3,0),(4,0),(5,0),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1)													

-- exposiçao
INSERT INTO ArtGallery.Exposicao (Estilo, DataExposicao, Nome, Num_sala)
    values ('variado', '20jul2020-4ago2020', 'Classicos de Arte',1),
           ('variado', '20jul2020-4ago2020', 'Esculturas da Antiguidade',2),
           ('variado', '21jun2020-26jun2020','Selecao Semanal de Curtas - Filme 1',6),
           ('variado', '21jun2020-26jun2020','Selecao Semanal de Curtas - Filme 2',7),
           ('variado', '21jun2020-26jun2020','Selecao Semanal de Curtas - Filme 3',8),
           ('variado', '21jun2020-26jun2020','Selecao Semanal de Curtas - Filme 4',9),
           ('variado', '21jun2020-26jun2020','Selecao Semanal de Curtas - Filme 5',10),
           ('variado', '21jun2020-26jun2020','Selecao Semanal de Curtas - Filme 6',11)



-- artistas
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (1,'Pintor','Vincent van Gogh','30 de marco de 1853','29 de julho de 1890');
INSERT INTO ArtGallery.Artista(ID_FK_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (2,'Pintor/Escultor','Pablo Picasso','25 de outubro de 1881','8 de abril de 1973');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (3,'Pintor','Gustav Klimt','14 de julho de 1862','6 de fevereiro de 191');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (4,'Pintor','Hans Holbein','1497','1543');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (5,'Pintor','Titian','1490','27 de agosto de 1576');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (6,'Pintor','Qi Baishi','1 de janeiro de 1864','16 de setembro de 1957');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (7,'Pintor','Andy Warhol','6 de agosto de 1928','22 de fevereiro de 1987');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (8,'Pintor','Jasper Johns','15 de maio de 1930',NULL);
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (9,'Pintor','Claude Monet','14 de novembro de 1840','5 de dezembro de 1926');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (10,'Pintor','Peter Paul Rubens','28 de junho de 1577','30 de maio de 1640');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (11,'Pintor','Mark Rothko','25 de setembro de 1903','25 de fevereiro de 1970');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (12,'Pintor','Amedeo Modigliani','12 de julho de 1884','24 de janeiro de 1920');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (13,'Pintor','Willem de Kooning','24 de abril de 1904','19 de março de 1997');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (14,'Pintor','Pontormo','24 de maio de 1494','2 de janeiro de 1557');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (15,'Pintor','Kazimir Malevich','23 de fevereiro de 1879','15 de maio de 1935');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (16,'Pintor','Paul Cezanne','19 de janeiro de 1839','22 de outubro de 1906');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (17,'Pintor','Thomas Eakins','25 de julho de 1844','25 de junho de 1916');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (18,'Pintor','Edvard Munch','12 de dezembro de 1863','23 de janeiro de 1944');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (19,'Pintor','Francis Bacon','22 de janeiro de 1561','9 de abril de 1626');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (20,'Pintor','Wang Meng','15 de outubro de 1934',NULL);
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (21,'Pintor','Barnett Newman','29 de janeiro de 1905','4 de julho de 1970');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (22,'Pintor','Pierre-Auguste Renoir','25 de fevereiro de 1841','3 de dezembro de 1919');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (23,'Pintor','Alberto Giacometti','10 de outubro de 1901','11 de janeiro de 1966');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (24,'Escultor','Jeff Koons','21 de janeiro de 1955',NULL);
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (25,'Escultor','Constantin Brancusi','19 de fevereiro de 1876','16 de marco de 1957');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (26,'Escultor','Alberto Giacometti','10 de outubro de 1901','11 de janeiro de 1966');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (27,'Escultor','Henry Moore','30 de julho de 1898','31 de agosto de 1986');
INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_obito) VALUES (28,'Escultor','Amedeo Modigliani','12 de julho de 1884','24 de janeiro de 1920');


-- ObrasArte
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposicao) VALUES (1,'A Wheatfield with Cypresses',1,'1889','57000000','A Wheatfield with Cypresses (occasionally called A Cornfield with Cypresses) is any of three similar 1889 oil paintings by Vincent van Gogh, as part of his wheat field series. All were executed at the Saint-Paul-de-Mausole mental asylum at Saint-RÃ©my near Arles, France, where Van Gogh was voluntarily a patient from May 1889 to May 1890. The works were inspired by the view from the window at the asylum towards the Les Alpilles mountains.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (2,'Acrobate et jeune arlequin',2,'1905','38500000',NULL,'Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (3,'Adele Bloch-Bauer II',3,'1912','87900000','Adele Bloch-Bauer II is a 1912 painting by Gustav Klimt. Adele Bloch-Bauer was the wife of Ferdinand Bloch-Bauer, who was a wealthy industrialist who sponsored the arts and supported Gustav Klimt. Adele Bloch-Bauer was the only model to be painted twice by Klimt','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (4,'Darmstadt Madonna',4,'1526','75000000','The Darmstadt Madonna (also known as the Madonna of Jakob Meyer zum Hasen) is an oil painting by Hans Holbein the Younger. Completed in 1526 in Basel, the work shows the BÃ¼rgermeister of Basel Jakob Meyer zum Hasen, his first wife (who had died earlier), his current wife, and his daughter grouped around the Madonna and infant Jesus. The meaning of the two other male figures on the left side is, like the overall iconography of the image, not entirely clear. The image testified to the resolutely Catholic faith of the BÃ¼rgermeister, who actively opposed the Reformation.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (5,'Diana and Actaeon',5,'1556, 1559','70600000','Diana and Actaeon is a painting by the Italian Renaissance master Titian, finished in 1556â€“1559, and is considered amongst Titian''s greatest works. It portrays the moment in which the goddess Diana meets Actaeon. In 2008â€“2009, the National Gallery, London and National Gallery of Scotland successfully campaigned to acquire the painting from the Bridgewater Collection for Â£50 million. As a result, Diana and Actaeon will remain on display in the UK, and will alternate between the two galleries on five-year terms.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (6,'Diana and Callisto',5,'1556, 1559','71700000','Diana and Callisto is a painting completed between 1556 and 1559 by the Venetian artist Titian. It portrays the moment in which the goddess Diana discovers that her maid Callisto has become pregnant by Jupiter. The painting was jointly purchased by the National Gallery and the National Galleries of Scotland for Â£45 million in March 2012. The painting is currently on display at the National Gallery in London. There is a later version by Titian and his workshop in the Kunsthistorisches Museum in Vienna.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (7,'Dora Maar au Chat',2,'1941','95200000','Dora Maar au Chat (Dora Maar with Cat) is a 1941 painting by Pablo Picasso. It depicts Dora Maar, the painter''s lover, seated on a chair with a small cat perched on her shoulders. This work is one of the world''s most expensive paintings.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (8,'Eagle Standing on Pine Tree',6,'1946','65500000',NULL,'Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (9,'Eight Elvises',7,'1963','100000000','Eight Elvises is a 1963 silkscreen painting by American pop artistAndy Warhol. In 2008 it was sold for $100 million to a private buyer, making the painting the most valuable work by Andy Warhol at the time. The current owner and location of the painting, which has not been seen publicly since the 1960s, are unknown.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (10,'False Start',8,'1959','80000000',NULL,'Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (11,'Femme assise dans un jardin',2,'1938','49500000',NULL,'Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (12,'Femme aux Bras CroisÃ©s',2,'1902','55000000','Femme aux Bras CroisÃ©s (Woman with Folded Arms), is a painting by Pablo Picasso done in 1902 during his Blue Period. The subject of the painting is unknown, but she may be an inmate of the Saint-Lazare hospital-prison in Paris.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (13,'Flag',8,'1954','110000000','Flag is an encaustic painting by the American artist Jasper Johns. Created when Johns was 24 (1954â€“55), two years after he was discharged from the US Army, this painting was the first of many works that Johns has said were inspired by a dream of the U.S. flag in 1954. It is arguably the painting for which Johns is best known.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (14,'GarÃ§on Ã  la pipe',2,'1905','104200000','GarÃ§on Ã  la Pipe (English: Boy with a Pipe) is a painting by Pablo Picasso. It was painted in 1905 when Picasso was 24 years old, during his Rose Period, soon after he settled in the Montmartre section of Paris, France. The oil on canvas painting depicts a Parisian boy holding a pipe in his left hand and wearing a garland or wreath of flowers.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (15,'Green Car Crash (Green Burning Car I)',7,'1963','71700000','Green Car Crash (Green Burning Car I) is a painting by the American artist Andy Warhol. In May 16, 2007 at 7 P.M, it sold for $71.7m (Â£42.3m) at auction.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (16,'Irises',1,'1889','53900000','Irises is one of many paintings and prints of irises by the Dutch artist Vincent van Gogh. Irises was painted while Vincent van Gogh was living at the asylum at Saint Paul-de-Mausole in Saint-RÃ©my-de-Provence, France, in the last year before his death in 1890.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (17,'Le Bassin aux NymphÃ©as',9,'1919','80500000','Le Bassin Aux NymphÃ©as (Water Lily Pond','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (18,'Le RÃªve',2,'1932','155000000','Le RÃªve (French, "The Dream") is a 1932 oil painting (130 Ã— 97 cm) by Pablo Picasso, then 50 years old, portraying his 22-year-old mistress Marie-ThÃ©rÃ¨se Walter. It is said to have been painted in one afternoon, on 24 January 1932. It belongs to Picasso''s period of distorted depictions, with its oversimplified outlines and contrasted colors resembling early Fauvism.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (19,'Les Noces de Pierrette',2,'1905','49300000','Les Noces de Pierrette (English:The marriage of Pierrette) is a painting by the Spanish artist and sculptor, Pablo Picasso. Painted in 1905, during Picasso''s Blue Period','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (20,'Massacre of the Innocents',10,'1611','76700000','The Massacre of the Innocents is the subject of two paintings by Peter Paul Rubens depicting the episode of the biblical Massacre of the Innocents of Bethlehem, as related in the Gospel of Matthew.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (21,'Men in Her Life',7,'1962','63400000','Men in Her Life is a 1962 painting by Andy Warhol. It is a black and white painting inspired by the life of Elizabeth Taylor, a seven foot tall creation of the artist.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (22,'No 1 (Royal Red and Blue)',11,'1954','75100000','No 1 (Royal Red and Blue) is a 1954 Color Field painting by the Abstract expressionist artist Mark Rothko. In November 2012, the painting sold for US$75.1 million (Â£47.2m) at a Sotheby''s auction.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (23,'Nude Sitting on a Divan',12,'1917','69000000','Nude Sitting on a Divan (The Beautiful Roman Woman) is an oil on canvas painting by Italian artist Amedeo Modigliani depicting a partially draped woman seated with crossed legs against a warm red background. The work was one of a series of nudes painted by Modigliani in 1917 that created a sensation when exhibited in Paris that year. On November 2, 2010, the painting sold at a New York auction for $68.9 million, a record price for an artwork by Modigliani.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (24,'Peasant Woman Against a Background of Wheat',1,'1890','47500000','Peasant Woman Against a Background of Wheat is an 1890 painting by Vincent van Gogh. Van Gogh went on to paint several versions of this painting.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (25,'Police Gazette',13,'1955','63500000',NULL,'Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (26,'Portrait de l''artiste sans barbe',1,'1889','71500000','The dozens of self-portraits by Vincent van Gogh were an important part of his oeuvre as a painter. Vincent van Gogh (1853â€“1890) created many self-portraits during his lifetime. Most probably, Van Gogh''s self-portraits are depicting the face as it appeared in the mirror he used to reproduce his face, i.e. his right side in the image is in reality the left side of his face.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (27,'Portrait of a Halberdier',14,'1537','35200000',NULL,'Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (28,'Portrait of Adele Bloch-Bauer I',3,'1907','135000000','Portrait of Adele Bloch-Bauer I is a 1907 painting by Gustav Klimt. The first of two portraits Klimt painted of Bloch-Bauer, it has been referred to as the final and most fully representative work of his golden phase.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (29,'Portrait of Dr. Gachet',1,'1890','82500000','Portrait of Dr. Gachet is one of the most revered paintings by the Dutch artist Vincent van Gogh. It depicts Dr. Paul Gachet who took care of Van Gogh during the final months of his life. There are two authenticated versions of the portrait, both painted in June 1890 at Auvers-sur-Oise. Both show Gachet sitting at a table and leaning his head on his right arm but they are easily differentiated in color and style. In 1990, the first version fetched a record price of $82.5 million ($75 million, plus a 10 percent buyer''s commission) when sold at auction in New York. When accounting for inflation, this is still the highest price paid for art at a public auction.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (30,'Portrait of Joseph Roulin',1,'1889','58000000',NULL,'Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (31,'Silver Car Crash (Double Disaster)',7,'1963','105400000','Silver Car Crash (Double Disaster) is a 1963 painting by the American artist Andy Warhol. In November 2013 it sold for $105m (Â£65.5m) at auction, setting a new highest price for a painting by Warhol.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (32,'Suprematist Composition',15,'1916','60000000','Suprematist Composition (blue rectangle over the red beam) is a painting by Kazimir Malevich, a Russian painter known as a pioneer of geometric abstraction. The painting represents a constellation of geometry and color in space with remarkable austerity.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (33,'The Card Players',16,'1892','259000000','The Card Players is a series of oil paintings by the French Post-Impressionist artist Paul CÃ©zanne. Painted during CÃ©zanne''s final period in the early 1890s, there are five paintings in the series. The versions vary in size and in the number of players depicted. CÃ©zanne also completed numerous drawings and studies in preparation for The Card Players series. One version of The Card Players was sold in 2011 to the Royal Family of Qatar for a price variously estimated at between $250 million and $300 million, making it the most expensive work of art ever sold.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (34,'The Gross Clinic',17,'1875','68000000','The Gross Clinic, or, The Clinic of Dr. Gross, is an 1875 painting by American artist Thomas Eakins. It is oil on canvas and measures 8 feet (240 cm) by 6.5 feet (200 cm). Dr. Samuel D. Gross, a seventy-year-old professor dressed in a black frock coat, lectures a group of Jefferson Medical College students. Included among the group is a self-portrait of Eakins, who is seated to the right of the tunnel railing, sketching or writing. Seen over Dr. Gross''s right shoulder is the clinic clerk, Dr. Franklin West, taking notes on the operation. Eakins''s signature is painted into the painting, on the front of the surgical table.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (35,'The Scream',18,'1895','119900000','The Scream (Norwegian: Skrik) is the popular Nome given to each of four versions of a composition, created as both paintings and pastels, by the Expressionist artist Edvard Munch between 1893 and 1910. Der Schrei der Natur (The Scream of Nature) is the title Munch gave to these works, all of which show a figure with an agonized expression against a landscape with a tumultuous orange sky. Arthur Lubow has described The Scream as "an icon of modern art, a Mona Lisa for our time."','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (36,'Three Studies for a Portrait of John Edwards',19,'1984','80800000',NULL,'Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (37,'Three Studies of Lucian Freud',19,'1969','142400000','Three Studies of Lucian Freud is a 1969 oil-on-canvastriptych by the Irish-born British painter Francis Bacon, depicting artist Lucian Freud. It was sold in November 2013 for US$142.4 millionâ€”the highest price attained at auction for a work of art when not factoring in inflation.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (38,'Turquoise Marilyn',7,'1964','80000000','The Shot Marilyns is a work of art produced in 1964 by Andy Warhol. It consists of four canvases, each a square measuring 40 inches and each consisting of a painting of a Marilyn Monroe, each shot through in the forehead by a single bullet.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (39,'Untitled',11,'1952','66200000',NULL,'Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (40,'Vase with Fifteen Sunflowers',1,'1888','39700000','Sunflowers (original title, in French: Tournesols) are the subject of two series of still life paintings by the Dutch painter Vincent van Gogh. The earlier series executed in Paris in 1887 depicts the flowers lying on the ground, while the second set executed a year later in Arles shows bouquets of sunflowers in a vase. In the artist''s mind both sets were linked by the Nome of his friend Paul Gauguin, who acquired two of the Paris versions. About eight months later Van Gogh hoped to welcome and to impress Gauguin again with Sunflowers, now part of the painted dÃ©coration that he prepared for the guestroom of his Yellow House, where Gauguin was supposed to stay in Arles. After Gauguin''s departure, Van Gogh imagined the two major versions as wings of the Berceuse Triptych, and finally he included them in his exhibit at Les XX in Bruxelles.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (41,'Woman III',13,'1953','137500000','Woman III is a painting by abstract expressionist painter Willem de Kooning. Woman III is one of a series of six paintings by de Kooning done between 1951 and 1953 in which the central theme was a woman. It measures 68 by 481â„2 inches (1.73 by 1.23 m) and was completed in 1953.','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (42,'Zhichuan Resettlemen',20,'1350','62100000',NULL,'Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (43,'Anna''s Light',21,'1968','105700000',NULL,'Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (44,'Au Lapin Agile',2,'1904','40700000',NULL,'Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (45,'Bal du moulin de la Galette',22,'1876','78100000','Bal du moulin de la Galette (commonly known as Dance at Le moulin de la Galette) is an 1876 painting by French artist Pierre-Auguste Renoir. It is housed at the MusÃ©e d''Orsay in Paris and is one of Impressionisms most celebrated masterpieces. The painting depicts a typical Sunday afternoon at Moulin de la Galette in the district of Montmartre in Paris. In the late 19th century, working class Parisians would dress up and spend time there dancing, drinking, and eating galettes into the evening.:121-3','Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (46,'Black Fire I',21,'1961','84200000',NULL,'Clássicos de Arte');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (47,'Balloon Dog (Orange)',24,'1994, 2000','$58,400,000',NULL,'Esculturas da Antiguidade');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (48,'Bird in Space',12,'1922, 1923','$27,500,000','Bird in Space (L''Oiseau dans l''espace) is a series of sculptures by Romanian sculptor Constantin BrÃ¢ncuÈ™i. The original work was created in 1923. It was sold in 2005 for $27.5 million, at the time a record price for a sculpture sold in an auction. The original title in Romanian is "PasÄƒrea Ã®n vÄƒzduh."','Esculturas da Antiguidade');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (49,'Grand tÃªte mince (2)',23,'1955','$50,000,000','Grande mince is a bronze sculpture by Alberto Giacometti. The work was conceived in 1954 and cast the following year. Auctioned in 2010, Grande tÃªte mince became one of the most valuable sculptures ever sold when it fetched $53.3 million.','Esculturas da Antiguidade');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (50,'Grande Femme Debout II',23,'1959, 1960','$27,400,000',NULL,'Esculturas da Antiguidade');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (51,'Grande tÃªte mince (1)',23,'1955','$53,300,000','Grande tÃªte mince is a bronze sculpture by Alberto Giacometti. The work was conceived in 1954 and cast the following year. Auctioned in 2010, Grande tÃªte mince became one of the most valuable sculptures ever sold when it fetched $53.3 million.','Esculturas da Antiguidade');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (52,'L''Homme qui marcheÂ I',23,'1961','$104,300,000','Lâ€™Homme qui marche I (The Walking Man I or The Striding Man I, lit. The Man who Walks I) is the Nome of any one of the cast bronze sculptures that comprise six numbered editions plus four artist proofs created by Swiss sculptor Alberto Giacometti in 1961. On 3 February 2010, the second edition of the cast of the sculpture became one of the most expensive works of art ever sold at auction, and the most expensive sculpture.','Esculturas da Antiguidade');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (53,'Madame LR (Portrait de Mme LR)',25,'1914, 1917','$37,600,000',NULL,'Esculturas da Antiguidade');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (54,'Reclining Figure: Festival',27,'1951','$30,100,000','Reclining Figure: Festival (LH 293) is a bronze sculpture by English artist Henry Moore, commissioned by the Arts Council in 1949 for the Festival of Britain in 1951. The sculpture can be viewed as an abstraction of a reclining female human figure, resting on two arms, with a small head.','Esculturas da Antiguidade');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (55,'Tete de femme (Dora Maar)',2,'1941','$29,100,000','Tete de femme (Dora Maar) is a plaster-modelled, bronze-cast sculpture by Pablo Picasso. Dora Maar, Picasso''s lover at the time, was the subject of the work which was originally conceived in 1941. Four copies of the bust were cast in the 1950s, several years after the relationship ended.','Esculturas da Antiguidade');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (56,'Doodlebug',NULL,'1997',NULL,'The story concerns a dishevelled man in a filthy flat. He is anxious and paranoid, trying to kill a small bug-like creature that is scurrying on the floor. It is revealed that the bug resembles a miniature version of himself, with every movement it makes being later matched by the man himself. He crushes the bug with his shoe but is subsequently squashed by a larger version of himself.','Selecao Semanal de Curtas - Filme 1');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (57,'Don''t Be A Hero',NULL,'2018',NULL,'A middle-aged woman battles her loneliness and boredom by robbing banks in the guise of a cowboy on her lunch break. But after the adrenaline rush wears off, she still has to deal with her deeply unhappy life. Inspired by a true story.','Selecao Semanal de Curtas - Filme 2');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (58,'Eden',NULL,'2014',NULL,'Eden is a high concept LGBT short film written by Jason Rostovsky and directed by Sean Willis. Set in the near future, this gay drama presents us with a world in which young homosexuals are incarcerated until they undergo a fix.','Selecao Semanal de Curtas - Filme 3');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (59,'Edmond',NULL,'2015',NULL,'Edmond is a stop-motion animation about a man who has suffered with a life-long affliction: cannibalism. We first meet him contemplating suicide at the edge of a lake before sliding back through time to witness individual moments when his craving for human flesh has taken over, revealing that he was a cannibal even before he was born. How is that possible?','Selecao Semanal de Curtas - Filme 4');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (60,'Endemic Albert',NULL,'2016',NULL,'Endemic Albert (Endemit Albert) was directed by Polish film student Zuzanna Slawinska, who shared the writing credit with Jakub W—jcik. Made at the Polish National Film School, it tells the story of Albert, whose only real friend is a tortoise. Bullied at school and afraid of girls, he decides to take inspiration from the animal world and become an alpha male.','Selecao Semanal de Curtas - Filme 5');
INSERT INTO ArtGallery.ObraArte(Referencia,Titulo,FK_Artista,Data_Producao,Valor,Descricao,Exposition) VALUES (61,'The Fantastic Flying Books of Mr Morris LessmoreÊ*',NULL,'2011',NULL,'The Fantastic Flying Books of Mr Morris Lessmore by William Joyce and Brandon Oldenburg won the Best Short Animation Oscar in 2012. There are lots of ideas crammed into this inventive short animation and it is a lovingly crafted animation using a variety of techniques.','Selecao Semanal de Curtas - Filme 6');

--filmes

INSERT INTO ArtGallery.Filme(Referencia,Genero,Duracao,Realizador,Elenco) VALUES (56,'Drama','3m','Christopher Nolan','Jeremy Theobald');
INSERT INTO ArtGallery.Filme(Referencia,Genero,Duracao,Realizador,Elenco) VALUES (57,'Drama','15m','Peter Lee','Missi Pyle, Ashley Spillers, Lew Temple, etc.');
INSERT INTO ArtGallery.Filme(Referencia,Genero,Duracao,Realizador,Elenco) VALUES (58,'Sci-Fi','15m','Sean Willis','George Anagnostou; Sean Burgos; Lora Lee');
INSERT INTO ArtGallery.Filme(Referencia,Genero,Duracao,Realizador,Elenco) VALUES (59,'Animation','8m','Nina Gantz','Nina Gantz');
INSERT INTO ArtGallery.Filme(Referencia,Genero,Duracao,Realizador,Elenco) VALUES (60,'Drama/Comedy','12m','Zuzanna Slawinska','Olaf Marchwicki;Zosia Charczun;Janusz Chabior');
INSERT INTO ArtGallery.Filme(Referencia,Genero,Duracao,Realizador,Elenco) VALUES (61,'Animation','15m','William Joyce & Brandon Oldenburg');

--pintura

INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (1,'Tecnica');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (2,'Acrilico');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (3,'Guache');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (4,'Guache');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (5,'Guache');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (6,'Guache');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (7,'Guache');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (8,'Guache');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (9,'Guache');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (10,'Guache');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (11,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (12,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (13,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (14,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (15,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (16,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (17,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (18,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (19,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (20,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (21,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (22,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (23,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (24,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (25,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (26,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (27,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (28,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (29,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (30,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (31,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (32,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (33,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (34,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (35,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (36,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (37,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (38,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (39,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (40,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (41,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (42,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (43,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (44,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (45,'Oleo');
INSERT INTO ArtGallery.Pintura(Referencia,Tecnica) VALUES (46,'Oleo');


--escultura
INSERT INTO ArtGallery.Escultura(Referencia,Tecnica,Material) VALUES (47,'Carving','Bronze');
INSERT INTO ArtGallery.Escultura(Referencia,Tecnica,Material) VALUES (48,'Assembling','Gold');
INSERT INTO ArtGallery.Escultura(Referencia,Tecnica,Material) VALUES (49,'Assembling','Silver');
INSERT INTO ArtGallery.Escultura(Referencia,Tecnica,Material) VALUES (50,'Assembling','Silver');
INSERT INTO ArtGallery.Escultura(Referencia,Tecnica,Material) VALUES (51,'Assembling','Silver');
INSERT INTO ArtGallery.Escultura(Referencia,Tecnica,Material) VALUES (52,'Casting','Silver');
INSERT INTO ArtGallery.Escultura(Referencia,Tecnica,Material) VALUES (53,'Casting','Copper');
INSERT INTO ArtGallery.Escultura(Referencia,Tecnica,Material) VALUES (54,'Casting','Copper');
INSERT INTO ArtGallery.Escultura(Referencia,Tecnica,Material) VALUES (55,'Casting','Copper');
INSERT INTO ArtGallery.Escultura(Referencia,Tecnica,Material) VALUES (56,'Casting','Copper');

-- bilhete


INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (25,1,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (45,2,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (80,3,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (25,4,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (25,5,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (45,6,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (45,7,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (45,8,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (60,9,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (80,10,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,11,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,12,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,13,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,14,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,15,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,16,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,17,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,18,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,19,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,20,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,21,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,22,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,23,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,24,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,25,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,26,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,27,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,28,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,29,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,30,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,31,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,32,'Diario',100010,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,33,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,34,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,35,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,36,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,37,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,38,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,39,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,40,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,41,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,42,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,43,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,44,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,45,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,46,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,47,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,48,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,49,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,50,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,51,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,52,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,53,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,54,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,55,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,56,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,57,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,58,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,59,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (5,60,'Diario',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (16,61,'Semanal',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (16,62,'Semanal',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (16,63,'Semanal',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (16,64,'Semanal',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (16,65,'Semanal',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (16,66,'Semanal',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (16,67,'Semanal',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (16,68,'Semanal',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (16,69,'Semanal',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (16,70,'Semanal',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (16,71,'Semanal',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (16,72,'Semanal',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (16,73,'Semanal',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (49,74,'Anual',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (49,75,'Anual',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (49,76,'Anual',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (49,77,'Anual',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (49,78,'Anual',100333,NULL);
INSERT INTO ArtGallery.Bilhete(Preco,N_bilhete,Validade,Num_Func_Rececionista,Data_venda) VALUES (49,79,'Anual',100333,NULL);

 Update ArtGallery.Bilhete
      SET Data_venda= DateAdd(d, ROUND(DateDiff(d, '2015-01-01', '2020-12-31') * RAND(CHECKSUM(NEWID())), 0),
      DATEADD(second,CHECKSUM(NEWID())%48000, '2010-01-01'))
/*
CREATE TRIGGER TGR_DATA
ON ArtGallery.VisitaGuiada
AFTER INSERT
AS
BEGIN
    SELECT ArtGallery.Bilhete_Grupo.Data_venda 
	FROM ArtGallery.Bilhete_Grupo
		JOIN ArtGallery.VisitaGuiada ON  ArtGallery.Bilhete_Grupo.ID_Grupo=ArtGallery.VisitaGuiada.FK_Grupo_ID
    UPDATE ArtGallery.VisitaGuiada.Data_visita=ArtGallery.Bilhete_Grupo.Data_venda 

END
GO
*/
--bilhete grupo

INSERT INTO ArtGallery.Bilhete_Grupo(FK_Grupo_ID,N_bilhete,Max_visitantes) VALUES (1,1,10);
INSERT INTO ArtGallery.Bilhete_Grupo(FK_Grupo_ID,N_bilhete,Max_visitantes) VALUES (2,2,20);
INSERT INTO ArtGallery.Bilhete_Grupo(FK_Grupo_ID,N_bilhete,Max_visitantes) VALUES (3,3,40);
INSERT INTO ArtGallery.Bilhete_Grupo(FK_Grupo_ID,N_bilhete,Max_visitantes) VALUES (4,4,10);
INSERT INTO ArtGallery.Bilhete_Grupo(FK_Grupo_ID,N_bilhete,Max_visitantes) VALUES (5,5,10);
INSERT INTO ArtGallery.Bilhete_Grupo(FK_Grupo_ID,N_bilhete,Max_visitantes) VALUES (6,6,20);
INSERT INTO ArtGallery.Bilhete_Grupo(FK_Grupo_ID,N_bilhete,Max_visitantes) VALUES (7,7,20);
INSERT INTO ArtGallery.Bilhete_Grupo(FK_Grupo_ID,N_bilhete,Max_visitantes) VALUES (8,8,20);
INSERT INTO ArtGallery.Bilhete_Grupo(FK_Grupo_ID,N_bilhete,Max_visitantes) VALUES (9,9,30);
INSERT INTO ArtGallery.Bilhete_Grupo(FK_Grupo_ID,N_bilhete,Max_visitantes) VALUES (10,10,40);


-- bilhete individual
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (1,11,383018520);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (2,12,382429264);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (3,13,325127818);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (4,14,288556962);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (5,15,310168972);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (6,16,362058041);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (7,17,396130510);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (8,18,322981446);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (9,19,376665950);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (10,20,230728524);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (11,21,297985648);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (12,22,216872294);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (13,23,211278590);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (14,24,343244790);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (15,25,263697967);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (16,26,349000112);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (17,27,398186618);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (18,28,234470537);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (19,29,328783621);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (20,30,341880686);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (21,31,297972294);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (22,32,262593095);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (23,33,233650675);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (24,34,341809992);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (25,35,385866285);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (26,36,247468906);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (27,37,276343918);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (28,38,224356397);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (29,39,200661103);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (30,40,383054042);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (31,41,273413582);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (32,42,276863639);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (33,43,338378623);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (34,44,238871715);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (35,45,213220450);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (36,46,343520899);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (37,47,398118032);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (38,48,354161339);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (39,49,370193895);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (40,50,241014943);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (41,51,286953478);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (42,52,224322824);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (43,53,309937850);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (44,54,379626507);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (45,55,252297335);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (46,56,316228195);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (47,57,350656720);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (48,58,231964187);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (49,59,214716582);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (50,60,389231761);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (51,61,221230072);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (52,62,233631338);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (53,63,250951356);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (54,64,373982929);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (55,65,294681055);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (56,66,327073571);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (57,67,236215877);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (58,68,337569045);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (59,69,307097663);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (60,70,224292339);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (61,71,339097470);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (62,72,218392894);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (63,73,236066394);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (64,74,355866247);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (65,75,235762164);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (66,76,335563249);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (67,77,275548182);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (68,78,387352872);
INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante) VALUES (69,79,271842864);

--VISITA GUIADA
INSERT INTO ArtGallery.VisitaGuiada(FK_Grupo_ID,N_bilhete_Grupo,N_Fun_Guia) VALUES (1,1,100002);
INSERT INTO ArtGallery.VisitaGuiada(FK_Grupo_ID,N_bilhete_Grupo,N_Fun_Guia) VALUES (2,2,100002);
INSERT INTO ArtGallery.VisitaGuiada(FK_Grupo_ID,N_bilhete_Grupo,N_Fun_Guia) VALUES (3,3,100002);
INSERT INTO ArtGallery.VisitaGuiada(FK_Grupo_ID,N_bilhete_Grupo,N_Fun_Guia) VALUES (4,4,100003);
INSERT INTO ArtGallery.VisitaGuiada(FK_Grupo_ID,N_bilhete_Grupo,N_Fun_Guia) VALUES (5,5,100003);
INSERT INTO ArtGallery.VisitaGuiada(FK_Grupo_ID,N_bilhete_Grupo,N_Fun_Guia) VALUES (6,6,100003);
INSERT INTO ArtGallery.VisitaGuiada(FK_Grupo_ID,N_bilhete_Grupo,N_Fun_Guia) VALUES (7,7,100004);
INSERT INTO ArtGallery.VisitaGuiada(FK_Grupo_ID,N_bilhete_Grupo,N_Fun_Guia) VALUES (8,8,100004);
INSERT INTO ArtGallery.VisitaGuiada(FK_Grupo_ID,N_bilhete_Grupo,N_Fun_Guia) VALUES (9,9,100004);
INSERT INTO ArtGallery.VisitaGuiada(FK_Grupo_ID,N_bilhete_Grupo,N_Fun_Guia) VALUES (10,10,100004);


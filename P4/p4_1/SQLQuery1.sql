use p3g1 
go
/*drop schema rentacar*/
create schema rentacar 
go
/*DROP TABLE rentacar.client*/


CREATE TABLE	RENTACAR.Cliente(
	NIF							INT				NOT NULL,	
	Nome						VARCHAR(30)		NOT NULL,
	Endereço					VARCHAR(32),
	Num_Carta					INT				NOT NULL
	PRIMARY KEY(NIF) );
	

CREATE TABLE RENTACAR.Balcao (
	NUM			INT		NOT NULL,
	Endereco	VARCHAR(30), 
	Nome		VARCHAR(30)		NOT NULL,
	PRIMARY KEY(NUM));

CREATE TABLE RENTACAR.Aluguer (
	NUM		INT		NOT NULL,
	Dataa	DATE,	
	Duracao		INT,
	C_NIF		INT,
	B_Num		INT,
	V_Matricula		VARCHAR(8),
	PRIMARY KEY(NUM),
	FOREIGN KEY(C_NIF) REFERENCES	RENTACAR.Cliente(NIF),
	FOREIGN KEY(B_Num)		REFERENCES RENTACAR.Balcao(Numero),
	FOREIGN KEY(V_Matricula)	REFERENCES	RENTACAR.Veiculo(Matricula)
	);

CREATE TABLE RENTACAR.Veiculo(
	Matricula					VARCHAR(8)		NOT NULL, 
	Marca						VARCHAR(20), 
	Ano							INT, 
	TP_Codigo					INT, 
	PRIMARY KEY(Matricula),
	FOREIGN KEY(TP_Codigo)		REFERENCES	RentaCar.Tipo_Veiculo(Codigo),
)

CREATE TABLE RentaCar.Ligeiro(
	TP_Codigo					INT, 
	Portas						INT,
	Num_lugares					INT,
	Combustivel					VARCHAR(10),
	PRIMARY KEY(TP_Codigo),
	FOREIGN KEY(TP_Codigo)		REFERENCES	RentaCar.Tipo_Veiculo(Codigo)
);

CREATE TABLE RentaCar.Pesado(
	TP_Codigo					INT, 
	Peso						REAL, 
	Passageiros					BIT, 
	PRIMARY KEY(TP_Codigo),
	FOREIGN KEY(TP_Codigo) REFERENCES	RentaCar.Tipo_Veiculo(Codigo)
);
CREATE TABLE RentaCar.Similaridade(
	TPV_Codigo_1				INT, 
	TPV_Codigo_2				INT,  
	PRIMARY KEY(TPV_Codigo_1,TPV_Codigo_2),
	FOREIGN KEY(TPV_Codigo_1)	REFERENCES	RentaCar.Tipo_Veiculo(Codigo),
	FOREIGN KEY(TPV_Codigo_2)	REFERENCES	RentaCar.Tipo_Veiculo(Codigo),
);






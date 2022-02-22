use p3g1
go

CREATE TABLE CategoriaTipo(
    Codigo                  INT             NOT NULL ,
    Designacao              VARCHAR(30)     NOT NULL,
	PRIMARY KEY (Codigo)
);

CREATE TABLE Fornecedor(
    NIF                     INT             NOT NULL,
    Fax                     INT             NOT NULL,
    Nome                    VARCHAR(30),
    Endereco                VARCHAR(30),
    CodigoCondPagamento     INT             NOT NULL,
	PRIMARY KEY(NIF),
);

CREATE TABLE Produto(
    Codigo                  INT             NOT NULL ,
    Nome                    VARCHAR(30),
    Preco                   MONEY,
    Stock					INT DEFAULT 0,
    IVA				        INT DEFAULT 23,
    NIFEmpresa              INT, 
	PRIMARY KEY(Codigo),
	FOREIGN KEY(Codigo)		REFERENCES	 CategoriaTipo(Codigo)
);


CREATE TABLE Encomenda(
    Numero                  INT             NOT NULL PRIMARY KEY,
    Dataa                 DATETIME,
	NIF_Fornecedor			INT,
    FOREIGN KEY(NIF_Fornecedor)		REFERENCES		Fornecedor(NIF),
);

CREATE TABLE Item(
    CodigoProduto           INT             NOT NULL,
    Nome					VARCHAR(30),
	N_encomenda				INT				NOT NULL,
	Fornecedor				INT,			
	PRIMARY KEY(CodigoProduto, N_encomenda),
	FOREIGN KEY	(CodigoProduto)		REFERENCES		Produto(Codigo),
	FOREIGN KEY (N_encomenda)		REFERENCES		Encomenda(Numero),
	FOREIGN KEY (Fornecedor)		REFERENCES		CategoriaTipo(Codigo)



);

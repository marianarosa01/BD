use p3g1;
go;


-- Views 
CREATE VIEW ArtGallery.PeopleWithAnualTickets AS
SELECT NIF,Data_venda_bilhete
FROM ((ArtGallery.Bilhete_individual JOIN ArtGallery.Bilhete ON ArtGallery.Bilhete_individual.N_bilhete= ArtGallery.Bilhete.N_bilhete)
JOIN ArtGallery.Pessoa ON ArtGallery.Bilhete_individual.NIF_visitante = ArtGallery.Pessoa.NIF ) 
WHERE ArtGallery.Bilhete.Validade = 'anual'

GO


CREATE VIEW ArtGallery.ObrasAntigas AS
select * from ArtGallery.ObrasDeArtes 
where cast(right(Data_Producao,4) AS INT) < 1900
GO


-- Examples

Select * from ArtGallery.PeopleWithAnualTickets
Select * from ArtGallery.ObrasAntigas



-- PROCEDURES


-- procedure simples para ir buscar a lista de artistas
GO
CREATE PROCEDURE SelectAllArtists
AS 
SELECT * FROM ArtGallery.Artista 
-- execução deste procedure
exec SelectAllArtists


-- seleciona o artista dado um fragmento do nome
GO
CREATE PROCEDURE SelectArtistInfo @NameFragment varchar(30)
AS
SELECT * FROM ArtGallery.Artista 
WHERE ArtGallery.Artista.Nome LIKE '%'+ @NameFragment + '%'

EXEC SelectArtistInfo @NameFragment = 'V'



-- DELETE DE UM BILHETE INDIVIDUAL E DE GRUPO, também altera a tabela bilhetes. Procedure

CREATE PROCEDURE DeleteBilhete @N_bilhete AS INT, @ID_visitante AS INT
as
begin
	DELETE FROM ArtGallery.Bilhete_individual 
			WHERE @N_bilhete = ArtGallery.Bilhete_individual.N_bilhete
	DELETE FROM ArtGallery.Bilhetes_grupo
			WHERE @N_bilhete = ArtGallery.Bilhetes_grupo.N_bilhete

			DELETE FROM ArtGallery.Bilhete 
			WHERE @N_bilhete = ArtGallery.Bilhete.N_bilhete

end

select * from ArtGallery.Funcionario




-- PESQUISA AVANÇADA


--Encontrar obra de arte a partir do nome/id da obra ou do nome/id do artista
GO
CREATE PROCEDURE SelectObraDeArteBYtext @expression varchar(30)
AS
IF ISNUMERIC(@expression) = 1 
	BEGIN
	-- SELECT CAST(@expression AS int)
	SELECT ArtGallery.ObrasDeArtes.Titulo,ArtGallery.Artista.Nome,ID_Artista, Referencia, Num_sala FROM ArtGallery.Artista JOIN ArtGallery.ObrasDeArtes ON ID_Artista=FK_Artista
	WHERE CAST(ArtGallery.Artista.ID_Artista AS VARCHAR) LIKE '%'+ @expression + '%' OR CAST(ArtGallery.ObrasDeArtes.Referencia AS VARCHAR) LIKE '%' + @expression + '%'
	END
ELSE
SELECT ArtGallery.ObrasDeArtes.Titulo,ArtGallery.Artista.Nome,ID_Artista, Referencia,Num_sala FROM ArtGallery.Artista JOIN ArtGallery.ObrasDeArtes ON ID_Artista=FK_Artista
WHERE ArtGallery.Artista.Nome LIKE '%'+ @expression + '%' OR ArtGallery.ObrasDeArtes.Titulo LIKE '%'+ @expression + '%'

Select  Referencia, Titulo, Nome, Data_Producao, Valor, Descricao, Titulo, FK_Exposicao_Nome, FK_Artista, Num_sala
FROM ArtGallery.ObrasDeArtes JOIN ArtGallery.Artista ON ID_Artista=FK_Artista
SELECT * FROM artgallery.ObrasDeArtes
-- exemplo

Execute SelectObraDeArteBYtext @expression='Van'

-- VENDER BILHETE Individual
GO
CREATE PROCEDURE InserirVisitante @NIF AS INT, @Nome AS VARCHAR(30), @Endereco AS VARCHAR(50), @Data_Nascimento AS VARCHAR(30)
as
begin
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) values (@NIF,@Nome,@Endereco,@Data_Nascimento)
INSERT INTO ArtGallery.Visitante(NIF) values (@NIF)
end




--- FUNCOES

-- udf escalar: quantos bilhetes vendeu-se naquele dia?

CREATE FUNCTION ArtGallery.getVisitors_date (@date VARCHAR(12)) RETURNS INTEGER
AS 
BEGIN
	DECLARE @total INTEGER
	SELECT @total = count(*)
	FROM ArtGallery.Bilhete 
	WHERE ArtGallery.Bilhete.Data_venda = @date
	RETURN @total
END
GO



--- Artista, associar o que fez, as suas obras (ou as referencias), pode ser um trigger!


-- udf escalar naquele mes daquele ano?
-- ...

 
-- UDF, inline-table COM CURSOR : tabela com o numero de bilhetes vendidos de diferentes tipo


DROP FUNCTION ArtGallery.TicketsByType 
CREATE FUNCTION ArtGallery.TicketsByType () 
RETURNS @table TABLE(	
		ticket_type VARCHAR(10),
		number_tickets INT
)
AS 
BEGIN
	DECLARE @numDaily INT, @numWeekly INT, @numYearly INT, @type VARCHAR(10);
	SET @numDaily = 0
	SET @numWeekly = 0
	SET @numYearly = 0
	
	DECLARE cursorBilhetes CURSOR FOR
	SELECT Validade FROM ArtGallery.Bilhete
	
	OPEN cursorBilhetes
	FETCH NEXT FROM cursorBilhetes INTO @type

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @type = 'Diario'
			BEGIN 
				SET @numDaily = @numDaily + 1;
			END

		ELSE IF @type = 'Semanal'
			BEGIN 
				SET @numWeekly = @numWeekly + 1;
			END

		ELSE IF @type = 'Anual'
			BEGIN 
				SET @numYearly = @numYearly + 1;
			END
		FETCH NEXT FROM cursorBilhetes INTO @type
	END
	
	INSERT INTO @table (ticket_type, number_tickets)
		VALUES  ('Diario', @numDaily),
				('Semanal', @numWeekly),
				('Anual', @numYearly);
	RETURN
END

GO
SELECT * FROM ArtGallery.TicketsByType ();
SELECT * FROM ArtGallery.Bilhete


SELECT ArtGallery.Escultura.Referencia, Titulo, Nome AS Artista, Data_Producao, Valor, Descricao, FK_Exposicao_Nome, FK_Artista, Num_sala, Tecnica, Material
FROM (ArtGallery.ObrasDeArtes JOIN ArtGallery.Artista ON ID_Artista=FK_Artista) JOIN ArtGallery.Escultura ON ArtGallery.ObrasDeArtes.Referencia = ArtGallery.Escultura.Referencia



-- inline-table valued com cursor
-- tabela para calcular quanto é que o museu faturou naquele dia | no total

SELECT * FROM ArtGallery.TicketsByType ();


-- Scalar function que rececionista vendeu os bilhetes 


CREATE FUNCTION ArtGallery.getRececionista (@n_bilhete INT) RETURNS VARCHAR(30)
AS 
BEGIN
	DECLARE @nif_func_rececionista INTEGER,  @name VARCHAR(30)
	SELECT @nif_func_rececionista = NIF_Rececionista
	FROM ArtGallery.Bilhete 
	WHERE ArtGallery.Bilhete.N_bilhete = @n_bilhete

	SELECT @name = Nome
	FROM ArtGallery.Pessoa
	WHERE ArtGallery.Pessoa.NIF = @nif_func_rececionista

	RETURN @name
END

-- Exemplo:
select ArtGallery.getRececionista ('41') 



GO

-- UDF COM CURSOR 


Select * from ArtGallery.Funcionario
Select * from ArtGallery.Gerente
Select * from ArtGallery.Rececionista
Select * from ArtGallery.Funcionario



--- TRIGGERS

-- TRIGGER: Adicionar funcionário, não pode estar já registado. Assim garantimos que não há funcionários duplicados mesmo que em cargos distintos


CREATE TRIGGER AddEmployee ON ArtGallery.Funcionario
AFTER INSERT
AS
BEGIN
    DECLARE @NIF_Func AS INT, @num_func AS INT;
	SELECT @NIF_Func= NIF_Funcionario, @num_func= Num_Funcionario FROM INSERTED;
	IF exists (
	SELECT * FROM ArtGallery.Funcionario 
	WHERE ArtGallery.Funcionario.NIF_Funcionario=@NIF_Func) 
		Rollback transaction
		RETURN
END

-- Example
Insert INTO ArtGallery.Funcionario (NIF_Funcionario, Num_Funcionario)
VALUES(888855533,14141)

CREATE TRIGGER InserirBilheteGrupo ON ArtGallery.Bilhetes_Grupo
INSTEAD OF INSERT 
AS
BEGIN
    DECLARE @data AS VARCHAR(12), @n_bilhete AS INT, @grupo_id AS INT, @max_visitantes AS INT;
	SELECT @n_bilhete= N_bilhete, @grupo_id= FK_Grupo_ID, @max_visitantes = Max_visitantes FROM INSERTED;
    SELECT @data=Data_venda FROM ArtGallery.Bilhete WHERE N_bilhete = @n_bilhete;
    INSERT INTO ArtGallery.Bilhetes_Grupo values (@grupo_id, @n_bilhete,@max_visitantes,@data);

END
GO 

CREATE TRIGGER InserirBilheteIndividual ON ArtGallery.Bilhete_individual
INSTEAD OF INSERT 
AS
BEGIN
    DECLARE @data AS VARCHAR(12), @n_bilhete AS INT, @nif_visitante AS INT, @id_visitante AS INT;
	SELECT @n_bilhete= N_bilhete, @nif_visitante= NIF_visitante, @id_visitante = ID_visitante FROM INSERTED;
    SELECT @data=Data_venda FROM ArtGallery.Bilhete WHERE N_bilhete = @n_bilhete;
    INSERT INTO ArtGallery.Bilhete_individual values (@id_visitante, @n_bilhete,@nif_visitante,@data);
END
GO 

CREATE TRIGGER InserirDataVisita ON ArtGallery.VisitasGuiadas 
INSTEAD OF INSERT 
AS
BEGIN
    DECLARE @data AS VARCHAR(12), @n_bilhete_grupo AS INT, @grupo_id AS INT, @n_func_guia AS INT;
	SELECT @n_bilhete_grupo= N_bilhete_Grupo, @grupo_id= FK_Grupo_ID, @n_func_guia = N_Fun_Guia FROM INSERTED;
    SELECT @data=Data_venda FROM ArtGallery.Bilhete WHERE N_bilhete = @n_bilhete_grupo;
    INSERT INTO ArtGallery.VisitasGuiadas values (@grupo_id,@n_bilhete_grupo, @data,@n_func_guia);
END
GO 


--- auxiliares, apoio à interface


SELECT  Referencia, Titulo, Nome, Data_Producao, Valor, Descricao, Titulo, FK_Exposicao_Nome, FK_Artista, Num_sala
FROM ArtGallery.ObrasDeArtes JOIN ArtGallery.Artista ON ID_Artista=FK_Artista



SELECT Titulo, Nome AS Artista, Data_Producao, Valor, Descricao, FK_Exposicao_Nome, FK_Artista, Num_sala, Tecnica
FROM (ArtGallery.ObrasDeArtes JOIN ArtGallery.Artista ON ID_Artista=FK_Artista) JOIN ArtGallery.Pintura ON ArtGallery.ObrasDeArtes.Referencia = ArtGallery.Pintura.Referencia



SELECT ArtGallery.ObrasDeArtes.Referencia, Titulo, Data_Producao, Descricao, FK_Exposicao_Nome Num_sala, Genero, Duracao, Realizador, Elenco
FROM (ArtGallery.ObrasDeArtes JOIN ArtGallery.Filme ON ArtGallery.ObrasDeArtes.Referencia=ArtGallery.Filme.Referencia) 

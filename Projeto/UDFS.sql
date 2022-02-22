
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

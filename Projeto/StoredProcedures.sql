
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


--- INSERIR VALORES EM Artista_Produz
INSERT INTO ArtGallery.Artista_Produz(Arte_Ref,Artista_Id)
SELECT Referencia, ID_Artista 
FROM ArtGallery.ObrasDeArtes INNER JOIN ArtGallery.Artista ON ArtGallery.ObrasDeArtes.FK_Artista=ArtGallery.Artista.ID_Artista


--- ATUALIZAR NUM DE SALA DA OBRA DE ARTE DEPOIS DOS INSERTS
	UPDATE ArtGallery.ObrasDeArtes
	SET ArtGallery.ObrasDeArtes.Num_sala = ArtGallery.Exposicao.Num_sala_id
	FROM ArtGallery.ObrasDeArtes JOIN ArtGallery.Exposicao ON ArtGallery.ObrasDeArtes.FK_Exposicao_Nome=ArtGallery.Exposicao.Nome





--- DELETE ObraDeArte
go
CREATE PROCEDURE ApagarObraDeArte @expression AS INT
AS
BEGIN
	DECLARE @artistaID AS INT
	DECLARE @totalObras AS INT
	SET NOCOUNT ON;

	SELECT @artistaID = Artista_Id FROM ArtGallery.Artista_Produz WHERE Arte_Ref=@expression
	SELECT @totalObras= count(Arte_Ref) FROM ArtGallery.Artista_Produz 
	GROUP BY Artista_Id
	HAVING Artista_Id=@artistaID
	
	IF EXISTS(SELECT Referencia FROM ArtGallery.Pintura WHERE Referencia = @expression)
		DELETE FROM ArtGallery.Pintura WHERE Referencia=@expression;
	ELSE IF EXISTS(SELECT Referencia FROM ArtGallery.Escultura WHERE Referencia = @expression)
		DELETE FROM ArtGallery.Escultura WHERE Referencia=@expression;
	ELSE IF EXISTS(SELECT Referencia FROM ArtGallery.Filme WHERE Referencia = @expression)
		DELETE FROM ArtGallery.Filme WHERE Referencia=@expression;
	
	DELETE FROM ArtGallery.Artista_Produz WHERE Artista_Id=@ArtistaID;
	DELETE FROM ArtGallery.ObrasDeArtes WHERE Referencia=@expression;
	IF (@totalObras = 1)
		DELETE FROM ArtGallery.Artista WHERE ID_Artista=@ArtistaID;	
	
END

DROP PROCEDURE ApagarObraDeArte

EXEC ApagarObraDeArte @expression=4
-- inserir visitante
INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) VALUES (383018527,'Noel Bruffell','74 Mariners Cove Road','15/06/1987');
GO
CREATE PROCEDURE InserirVisitante @NIF AS INT, @Nome AS VARCHAR(30) =NULL , @Endereco AS VARCHAR(50) =null, @Data_Nascimento AS VARCHAR(30) = NULL,@new_identity INT = NULL OUTPUT
as
begin
	SET NOCOUNT ON;
	INSERT INTO ArtGallery.Pessoa(NIF,Nome,Endereco,Data_Nascimento) values (@NIF,@Nome,@Endereco,@Data_Nascimento);
	INSERT INTO ArtGallery.Visitante(FK_NIF) values (@NIF)
	SET @new_identity = SCOPE_IDENTITY();
	RETURN @new_identity
END

DROP PROCEDURE InserirVisitante


--execução da inserção do visitante
DECLARE @newID as INT
EXECUTE @newID= InserirVisitante @NIF =78301851
PRINT @newID

-- ADD funcionario

--- INSERE UM BILHETE DE VISITANTE

GO



--- Vender Bilhete de Grupo
GO
CREATE PROCEDURE InserirBilheteGrupo @Preco AS FLOAT,@Validade AS VARCHAR(20),@NIF_Rececionista AS INT,@Num_Func_Rececionista AS INT,@Max_visitantes AS INT, @new_identity1 INT = NULL OUTPUT,@new_identity2 INT = NULL OUTPUT  
AS 
BEGIN
	SET NOCOUNT ON;
	INSERT INTO ArtGallery.Bilhete(Preco,Validade,NIF_Rececionista,Num_Func_Rececionista,Data_venda) VALUES (@Preco,@Validade, @NIF_Rececionista,@Num_Func_Rececionista,CAST( GETDATE() AS Date ));
	SET @new_identity1 = SCOPE_IDENTITY();
	INSERT INTO ArtGallery.Grupo(N_pessoas) values (@Max_visitantes)
	SET @new_identity2 = SCOPE_IDENTITY();
	INSERT INTO ArtGallery.Bilhetes_Grupo(FK_Grupo_ID,N_bilhete,Max_visitantes,Data_venda_bilhete) values (@new_identity2,@new_identity1,@Max_visitantes,CAST( GETDATE() AS Date ))
END
GO

EXEC InserirBilheteGrupo @Preco=25,@Validade="Diario",@NIF_Rececionista=882242266,@Num_Func_Rececionista=100010,@Max_visitantes=10





---- INSERE UM BILHETE DE VISITANTE

GO
CREATE PROCEDURE InserirBilheteVisitante @Preco AS FLOAT,@Validade AS VARCHAR(20),@NIF_Rececionista AS INT,@Num_Func_Rececionista AS INT,@Id_Visitante AS INT,@NIF_Visitante AS INT, @new_identity INT = NULL OUTPUT
AS 
BEGIN
    SET NOCOUNT ON;
    INSERT INTO ArtGallery.Bilhete(Preco,Validade,NIF_Rececionista,Num_Func_Rececionista,Data_venda) VALUES (@Preco,@Validade, @NIF_Rececionista,@Num_Func_Rececionista,CAST( GETDATE() AS Date ));
    SET @new_identity = SCOPE_IDENTITY();
    INSERT INTO ArtGallery.Bilhete_individual(ID_visitante,N_bilhete,NIF_visitante,Data_venda_bilhete) values (@Id_visitante,@new_identity,@NIF_Visitante,CAST( GETDATE() AS Date ))
END
GO

DELETE FROM ArtGallery.Bilhete WHERE N_bilhete=90
EXEC InserirBilheteVisitante @Preco=5,@Validade="Diario",@NIF_Rececionista=882242266,@Num_Func_Rececionista=100010,@Id_Visitante=106,@NIF_Visitante=398118032



------ INSERIR/UPDATE funcionário

EXEC ArtGallery.InsertUpdateFunc @NIF=11121487, @Nome='camila',  @edit=0, @tipoFunc=1, @pass='mendes'
DROP PROCEDURE ArtGallery.InsertUpdateFunc
CREATE PROCEDURE ArtGallery.InsertUpdateFunc

	@NIF AS INT, @Nome AS VARCHAR(30)=NULL,  @Endereco AS VARCHAR(50) =NULL, @Data_Nascimento AS VARCHAR(30) =NULL, @edit AS INT, 
	@tipoFunc AS INT, @pass AS VARCHAR(15) , @new_identity INT = NULL OUTPUT
AS
BEGIN
	DECLARE @NumFunc AS INT
	IF (@NIF IS NULL )
			begin
            PRINT 'Erro! NIF nao pode ser NULL!'
			end
	
	SELECT * FROM ArtGallery.Pessoa WHERE NIF=@NIF
    DECLARE @RowsAffected int = @@ROWCOUNT
    IF (@RowsAffected!=0 AND @edit=0)
		begin
            PRINT 'Erro! NIF já registado. Tente outro.'
        end
    IF (@RowsAffected!=1 AND @edit=1)
		begin
            PRINT 'Error! NIF não  se encontra registado! '
		end
       
    BEGIN TRANSACTION  

        IF @Edit=0
				BEGIN
				INSERT INTO ArtGallery.Pessoa(NIF) VALUES(@NIF);
				INSERT INTO ArtGallery.Funcionario(NIF_Funcionario,Palavra_Pass) values (@NIF,@pass)
				SET @new_identity = SCOPE_IDENTITY()

				IF @tipoFunc = 1
					BEGIN
						INSERT INTO ArtGallery.Guia (NIF_Funcionario,Num_Funcionario)  VALUES (@NIF, @new_identity)
					END
				ELSE IF @tipoFunc = 2
					BEGIN
						INSERT INTO ArtGallery.Gerente (NIF_Funcionario,Num_Funcionario_Gerente)    VALUES (@NIF, @new_identity)
					END

				ELSE IF @tipoFunc = 3
					BEGIN
						INSERT INTO ArtGallery.Rececionista (NIF_Funcionario,Num_Funcionario)    VALUES (@NIF, @new_identity)
					END

				ELSE IF @tipoFunc = 4
					BEGIN
						INSERT INTO ArtGallery.Seguranca (NIF_Funcionario,Num_Funcionario)    VALUES (@NIF,@new_identity)
					END
				end
        ELSE
			BEGIN
				UPDATE ArtGallery.Pessoa SET  Endereco=@Endereco  WHERE NIF=@NIF
			END

        IF (@@ROWCOUNT!=1)
		BEGIN
			PRINT 'Error!'
			ROLLBACK TRAN
		END
            

		ELSE
		BEGIN
			IF @Edit=0
				BEGIN
					PRINT 'FUNCIONÁRIO ADICIONADO!'
				END
			ELSE
				BEGIN
					PRINT 'FUNCIONÁRIO EDITADO!'
				END
		END
		COMMIT TRAN
END
GO



Alter PROCEDURE InserirArtista @ID_Artista AS INT,@Nome AS VARCHAR(30),  @data_nascimento AS VARCHAR(30) , @data_obito AS VARCHAR(30),  @especialidade AS VARCHAR(20)
AS 
BEGIN
    INSERT INTO ArtGallery.Artista(ID_Artista,Especialidade,Nome,Data_Nascimento,Data_Obito) VALUES (@ID_Artista,@especialidade,@nome,@data_nascimento,@data_obito);
END
GO

EXEC InserirArtista @ID_Artista=30, @especialidade = 'Pintora', @Nome='Lena Gal', @Data_Nascimento='7 junho 1957', @data_obito=NULL


DROP PROCEDURE InserirFilme
CREATE PROCEDURE InserirFilme @genero AS VARCHAR(30),@duracao AS VARCHAR(20),@realizador AS VARCHAR(30), @elenco AS VARCHAR(100), 
@data_producao AS VARCHAR(30), @valor AS INT, @descricao  AS VARCHAR(100) , @titulo  AS VARCHAR(30), @artistaName AS VARCHAR(30), @exposition_name AS VARCHAR(50)
AS 
BEGIN
	DECLARE @id_artista AS INT,  @new_identity INT 
    IF exists (
	SELECT ID_Artista FROM ArtGallery.Artista 
	WHERE ArtGallery.Artista.Nome=@artistaName)
	BEGIN
		SET NOCOUNT ON;
		SELECT @id_artista = ID_Artista FROM ArtGallery.Artista WHERE ArtGallery.Artista.Nome=@artistaName
		PRINT @titulo
		PRINT @id_artista
		INSERT INTO ArtGallery.ObrasDeArtes( Data_Producao, Valor, Descricao, Titulo,FK_Exposicao_Nome, FK_Artista) 
		values (@data_producao,@valor, @descricao,@titulo,@exposition_name, @id_artista)


		SET @new_identity = SCOPE_IDENTITY();

		INSERT INTO ArtGallery.Filme(Referencia,Genero,Duracao,Realizador,Elenco) VALUES (@new_identity,@genero, @duracao,@realizador,@elenco)
	 END 
GO



Exec InserirFilme 'Drama', '4m','realizador', 'c elenco','5885 de marco',67890, 'descricaoo','nome a toa', 'Pablo Picasso','Movies'

---LOGIN

-- LOGIN RECECAO
go
CREATE PROCEDURE LoginRececao @numfunc AS INT, @pass as varchar(15), @output int = null output
AS
BEGIN
	IF EXISTS(SELECT * from ArtGallery.Rececionista JOIN ArtGallery.Funcionario ON ArtGallery.Rececionista.Num_Funcionario=ArtGallery.Funcionario.Num_Funcionario
			WHERE ArtGallery.Rececionista.Num_Funcionario=@numfunc AND Palavra_Pass = @pass)
		RETURN 1
	ELSE IF EXISTS(SELECT * from ArtGallery.Gerente JOIN ArtGallery.Funcionario ON ArtGallery.Gerente.Num_Funcionario_Gerente=ArtGallery.Funcionario.Num_Funcionario
			WHERE ArtGallery.Gerente.Num_Funcionario_Gerente=@numfunc AND Palavra_Pass = @pass)
		RETURN 1
	ELSE 
		RETURN 0
END
go

--LOGIN SECRETARIA
go
CREATE PROCEDURE LoginSecretaria @numfunc AS INT, @pass as varchar(15), @output int = null output
AS
BEGIN
	IF EXISTS(SELECT * from ArtGallery.Secretaria JOIN ArtGallery.Funcionario ON ArtGallery.Secretaria.Num_Funcionario=ArtGallery.Funcionario.Num_Funcionario
			WHERE ArtGallery.Secretaria.Num_Funcionario=@numfunc AND Palavra_Pass = @pass)
		RETURN 1
	ELSE IF EXISTS(SELECT * from ArtGallery.Gerente JOIN ArtGallery.Funcionario ON ArtGallery.Gerente.Num_Funcionario_Gerente=ArtGallery.Funcionario.Num_Funcionario
			WHERE ArtGallery.Gerente.Num_Funcionario_Gerente=@numfunc AND Palavra_Pass = @pass)
		RETURN 1
	ELSE 
		RETURN 0
END
go


--LOGIN	Gerencia
go
CREATE PROCEDURE LoginGerencia @numfunc AS INT, @pass as varchar(15), @output int = null output
AS
BEGIN
	IF EXISTS(SELECT * from ArtGallery.Gerente JOIN ArtGallery.Funcionario ON ArtGallery.Gerente.Num_Funcionario_Gerente=ArtGallery.Funcionario.Num_Funcionario
			WHERE ArtGallery.Gerente.Num_Funcionario_Gerente=@numfunc AND Palavra_Pass = @pass)
		RETURN 1
	ELSE 
		RETURN 0
END
go

DROP PROCEDURE LoginRececao
DROP PROCEDURE LoginSecretaria
DROP PROCEDURE LoginGerencia

--- devolve 1 se funcionar e 0 se falhar
DECLARE @ret as int
EXEC @ret = LoginGerencia @numfunc=25, @pass='funcionario1'
PRINT @ret


--- devolve 1 se funcionar e 0 se falhar
DECLARE @ret as int
EXEC @ret = LoginRececao @numfunc=7, @pass='funcionario2'
PRINT @ret




-- procurar visitante por NIF/Id/Nome

GO
CREATE PROCEDURE SelectVisitanteByText @expression varchar(30)
AS
IF ISNUMERIC(@expression) = 1 
	BEGIN
	-- SELECT CAST(@expression AS int)
	SELECT * FROM ArtGallery.Visitante JOIN ArtGallery.Pessoa ON NIF=FK_NIF
	WHERE CAST(ArtGallery.Visitante.FK_NIF AS VARCHAR) LIKE '%'+ @expression + '%' OR CAST(ArtGallery.Visitante.ID_Visitante AS VARCHAR) LIKE '%' + @expression + '%'
	END
ELSE
SELECT * FROM ArtGallery.Visitante JOIN ArtGallery.Pessoa ON NIF=FK_NIF
WHERE ArtGallery.Pessoa.Nome LIKE '%'+ @expression + '%' 


EXEC SelectVisitanteByText @expression=a

select * from ArtGallery.ObrasDeArtes
---eliminar artista e obras de arte associadas



DROP PROCEDURE EliminarArtista
CREATE PROCEDURE EliminarArtista @id as int
AS
BEGIN
	DECLARE @obraArteID INT , @ID_artista INT
	SET @obraArteID=0
	SET @ID_artista=0

	DECLARE cursorObra CURSOR LOCAL FOR 
	SELECT Referencia FROM ArtGallery.ObrasDeArtes
	WHERE FK_Artista = @id
	
	OPEN cursorObra
	FETCH NEXT FROM cursorObra INTO @obraArteID
	

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC ApagarObraDeArte @obraArteID
		FETCH NEXT FROM cursorObra INTO @obraArteID
	END
	CLOSE cursorObra
	DEALLOCATE cursorObra
	DELETE FROM ArtGallery.Artista WHERE ID_Artista=@id

END
EXEC EliminarArtista @id=5

select * from ArtGallery.Artista


GO
CREATE PROCEDURE ApagarFuncionario @NumFunc AS INT
AS
BEGIN
    DECLARE @nif as int
    IF EXISTS(SELECT Num_Funcionario_Gerente FROM ArtGallery.Gerente WHERE Num_Funcionario_Gerente = @NumFunc)
        DELETE FROM ArtGallery.Gerente WHERE Num_Funcionario_Gerente = @NumFunc
    ELSE IF EXISTS(SELECT Num_Funcionario FROM ArtGallery.Guia WHERE Num_Funcionario = @NumFunc)
        DELETE FROM ArtGallery.Guia WHERE Num_Funcionario = @NumFunc
    ELSE IF EXISTS(SELECT Num_Funcionario FROM ArtGallery.Seguranca WHERE Num_Funcionario = @NumFunc)
        DELETE FROM ArtGallery.Seguranca WHERE Num_Funcionario = @NumFunc
    ELSE IF EXISTS(SELECT Num_Funcionario FROM ArtGallery.Rececionista WHERE Num_Funcionario = @NumFunc)
        DELETE FROM ArtGallery.Rececionista WHERE Num_Funcionario = @NumFunc
    ELSE IF EXISTS(SELECT Num_Funcionario FROM ArtGallery.Secretaria WHERE Num_Funcionario = @NumFunc)
        DELETE FROM ArtGallery.Secretaria WHERE Num_Funcionario = @NumFunc

    SELECT @nif = NIF_Funcionario FROM ArtGallery.Funcionario WHERE Num_Funcionario=@NumFunc
    DELETE FROM ArtGallery.Funcionario WHERE Num_Funcionario=@NumFunc
    DELETE FROM ArtGallery.Pessoa WHERE NIF=@nif

END
GO


EXEC ApagarFuncionario @NumFunc = 10

SELECT * FROM ArtGallery.Visitante 


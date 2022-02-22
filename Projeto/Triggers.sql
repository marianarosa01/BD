
-- Triggers 

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

select * from ArtGallery.ObrasdeArtes

DROP TRIGGER ArtGallery.notAddDuplicateObraArte
CREATE TRIGGER ArtGallery.notAddDuplicateObraArte ON ArtGallery.ObrasdeArtes
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @name AS VARCHAR(30);
	SELECT @name = Titulo FROM INSERTED;
	IF exists (
	SELECT * FROM ArtGallery.ObrasDeArtes 
	WHERE ArtGallery.ObrasDeArtes.Titulo=@name) 
		BEGIN
			Rollback transaction
			RETURN
		END

	INSERT INTO ArtGallery.ObrasDeArtes( Data_Producao, Valor, Descricao, Titulo,FK_Exposicao_Nome, FK_Artista) 
	SELECT * FROM INSERTED 
END


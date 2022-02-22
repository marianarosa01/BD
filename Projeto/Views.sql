
-- Views 

select * from ArtGallery.PeopleWithAnualTickets

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

-- faturaçao total

GO
CREATE VIEW FaturacaoTotal
AS
SELECT SUM(Preco) AS totalVendas
FROM ArtGallery.Bilhete
GO

--Faturacao dos Bilhetes de Grupo
GO
CREATE VIEW FaturacaoTotalBilhetesGrupo
AS
SELECT SUM(Preco) AS totalVendasBilhetesGrupo 
FROM ArtGallery.Bilhete JOIN  ArtGallery.Bilhetes_Grupo ON ArtGallery.Bilhete.N_bilhete=ArtGallery.Bilhetes_Grupo.N_bilhete

--Faturaçao media diaria
GO 
CREATE VIEW FaturacaoMediaDiaria
AS
SELECT AVG(totalVenda) AS MediaVendas
from (SELECT Count(Preco)*Preco AS totalVenda,Data_venda
FROM ArtGallery.Bilhete
GROUP BY Data_venda, Preco) as Q1
GO
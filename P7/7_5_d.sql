-- d)
use pubs;

insert into BusinessTitles(title_id, title, type, pub_id, price, notes)
values('BDTst1', 'New BD Book','popular_comp', '1389', $30.00, 'A must-read for DB course.')

-- não executou porque faltam atributos nas tabelas que estamos a usar
-- mesmo que tivessemos as tabelas acabaria por surgir um problema porque estamos a inserir um livro de tipo "popular_comp"
-- numa tabela que só tem livros do tipo "Business"

-- deve-se criar um view diferente para a pesquisa acima funcionar:
CREATE VIEW TitlesBusinessPopularComp ( title, title_id, type, pub_id,price, notes) AS 
SELECT title, title_id, type, pub_id,price, notes
FROM titles
WHERE type='Business' AND type='popular_comp'
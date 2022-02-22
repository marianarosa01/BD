-- 7.5
-- Anastasiya Lykholat (93436)
-- Mariana Rosa (98390)

use pubs;
CREATE VIEW Autores_VIEW AS

	SELECT title, au_fname + ' ' + au_lname as Author_name
	FROM((authors JOIN titleauthor
		ON authors.au_id = titleauthor.au_id ) JOIN titles
											ON titleauthor.title_id = titles.title_id)
		GROUP BY title, au_fname, au_lname;

		


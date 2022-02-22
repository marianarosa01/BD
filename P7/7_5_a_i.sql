--a)
--i)
CREATE VIEW Title_Author(title, au_fname, au_lname) AS
SELECT title, au_lname, au_fname
FROM authors JOIN (
	SELECT au_id, title, title.title_id
	FROM titles JOIN titleauthor ON title.tile_id = titleauthor.title_id) AS q1
	ON authors.au_id=q1.au_id



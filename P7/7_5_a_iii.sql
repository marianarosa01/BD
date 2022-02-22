CREATE VIEW StorTitles ( title, stor_name) AS
SELECT title, stor_name
FROM titles JOIN (
SELECT stor_name, title_id
FROM sales JOIN stores ON sales.stor_id=stores.stor_id) AS q1
ON titles.title_id=q1.title_id
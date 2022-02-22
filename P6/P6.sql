use pubs;
-- a)
SELECT * from authors

-- b)

SELECT au_fname,  au_lname, phone from authors

-- c)
SELECT au_fname,  au_lname, phone from authors
ORDER BY au_fname, au_lname

-- d)

SELECT au_fname as first_name,  au_lname as last_name, phone as telephone from authors


-- e)
SELECT au_fname as first_name,  au_lname as last_name, phone as telephone, state from authors
WHERE state = 'CA' AND au_lname <> 'Ringer';

-- f) 
SELECT pub_name from publishers
WHERE pub_name LIKE '%Bo%'

--g)

SELECT pub_name 
FROM publishers AS P, titles as T
WHERE P.pub_id=T.pub_id AND type='Business'


-- h) ??????????????
/*
SELECT pub_name, SUM(sales.qty)
--FROM (publishers AS P, titles as T, sales as S)
FROM ((publishers AS P JOIN titles as T ON P.pub_id=T.pub_id) JOIN sales ON T.title_id=sales.title_id)
GROUP BY P.pub_name */


-- h)
SELECT pub_name, totalVendas
FROM publishers LEFT JOIN ( SELECT pub_id, SUM(qtyVendas) AS totalVendas
                            FROM ( SELECT title,pub_id, SUM(qty) AS qtyVendas
                                   FROM sales JOIN titles ON sales.title_id=titles.title_id
                                   GROUP BY title, pub_id)  AS hhh
                            GROUP BY pub_id) AS k ON publishers.pub_id=k.pub_id


-- i)
SELECT pub_name, title, qtyVendas
FROM publishers LEFT JOIN ( SELECT title,pub_id, SUM(qty) AS qtyVendas
                       FROM sales JOIN titles ON sales.title_id=titles.title_id
                       GROUP BY title, pub_id) AS k ON publishers.pub_id=k.pub_id;

--- j) Nome dos títulos vendidos pela loja ‘Bookbeat’;

SELECT title, stor_name
FROM ((stores JOIN sales ON stores.stor_id=sales.stor_id) JOIN titles ON sales.title_id=titles.title_id)
WHERE stores.stor_name='Bookbeat'

-- k) Nome de autores que tenham publicações de tipos diferentes;
SELECT  au_lname, au_fname, COUNT([type]) AS num_type_pub
FROM authors
JOIN titleauthor ON authors.au_id=titleauthor.au_id 
JOIN titles ON titleauthor.title_id=titles.title_id
GROUP BY au_fname, au_lname
HAVING COUNT(DISTINCT(titles.[type] ))>=2

-- l) Para os títulos, obter o preço médio e o número total de vendas agrupado por tipo (type) e editora (pub_id); 

SELECT pub_name, [type], publishers.pub_id, AVG(titles.price) AS avg_price, SUM(sales.qty) AS total_sales
FROM titles
JOIN sales ON titles.title_id=sales.title_id
JOIN publishers ON titles.pub_id=publishers.pub_id 
GROUP BY [type], publishers.pub_id, pub_name

-- m) Obter o(s) tipo(s) de título(s) para o(s) qual(is) o máximo de dinheiro “à cabeça” (advance) é uma vez e meia superior à média do grupo (tipo);

SELECT type FROM titles  GROUP BY type HAVING MAX(advance)>1.5*AVG(advance)

-- o) Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, a faturação total, o valor da faturação relativa aos autores e o valor da faturação relativa à editora;

SELECT title, ytd_sales,price*ytd_sales AS revenue, price*ytd_sales*royalty/100 AS auths_revenue,price*ytd_sales-price*ytd_sales*royalty/100 AS publisher_revenue 
FROM titles 
WHERE ytd_sales is not NULL
ORDER BY title


-- q)  Lista de lojas que venderam pelo menos um exemplar de todos os livros;

SELECT stor_name, count(title) AS num_titles
FROM ((stores JOIN sales ON stores.stor_id=sales.stor_id) 
JOIN titles ON sales.title_id=titles.title_id) 
GROUP BY stor_name 
HAVING count(title)=(SELECT count(title_id) FROM titles);

-- s) Nome dos títulos que nunca foram vendidos na loja “Bookbeat”
SELECT title
FROM titles 
WHERE title_id NOT IN (SELECT title_id FROM sales WHERE sales.stor_id=8042)


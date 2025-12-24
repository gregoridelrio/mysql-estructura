USE db_optica;
-- ---------------------------
-- Llista el total de compres d’un client/a.
-- ---------------------------
select c.nom , COUNT(*) AS total_compres
from venda v 
join client c on v.id_Client = c.id_Client 
where c.id_Client = 1;
-- ---------------------------
-- Llista les diferents ulleres que ha venut un empleat durant un any.
-- ---------------------------
select distinct u.marca, u.muntura_tipus, u.muntura_color
from venda v 
join ulleres u on v.id_Ulleres = u.id_Ulleres
where v.id_Empleat = 1
and year(v.data_venda) = 2025;
-- ---------------------------
-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.
-- ---------------------------
select distinct p.nom
from venda v
join ulleres u on v.id_Ulleres = u.id_Ulleres
join proveidor p ON u.id_Proveidor = p.id_Proveidor;
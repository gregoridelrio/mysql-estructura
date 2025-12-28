use db_pizzeria;

-- ---------------------------
-- Llista quants productes de tipus “Begudes” s'han venut en una determinada localitat.
-- ---------------------------
select SUM(cp.quantitat) as begudes
from comanda_producte cp
join comanda c on cp.Comanda_id_Comanda = c.id_Comanda
join producte p on cp.Producte_id_Producte = p.id_Producte
join botiga b on c.id_Botiga = b.id_Botiga
where p.tipus = 'beguda'
and b.localitat = 'Barcelona';

-- ---------------------------
-- Llista quantes comandes ha efectuat un determinat empleat/da.
-- ---------------------------
select e.nom, COUNT(l.id_Comanda) AS comandes
from lliurament l
join empleat e ON l.id_Empleat = e.id_Empleat
where e.id_Empleat = 2
group by e.id_Empleat;

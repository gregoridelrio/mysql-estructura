use db_pizzeria;

INSERT INTO Categoria (id_Categoria, nom) VALUES
(1, 'Clàssiques'),
(2, 'Especials');

INSERT INTO Producte (id_Producte, nom, descripcio, imatge, preu,tipus, id_Categoria) VALUES
(1, 'Pizza Margarita', 'Tomàquet i mozzarella', 'margarita.jpg', 8.50, 'pizza', 1),
(2, 'Pizza BBQ', 'Carn i salsa BBQ', 'bbq.jpg', 10.00, 'pizza', 2),
(3, 'Hamburguesa Classic', 'Vedella i formatge', 'burger.jpg', 7.00, 'hamburguesa', NULL),
(4, 'Coca-Cola', 'Beguda refrescant Cola', 'cocacola.jpg', 2.00, 'beguda', NULL),
(5, 'Fanta', 'Beguda refrescant Taronja', 'fanta.jpg', 2.00, 'beguda', NULL);

INSERT INTO Botiga (id_Botiga, adreca, codi_postal, localitat, provincia) VALUES
(1, 'Carrer Gran 1', '08001', 'Barcelona', 'Barcelona'),
(2, 'Carrer Gran 2', '08001', 'Barcelona', 'Barcelona');

INSERT INTO Empleat (id_Empleat, nom, cognoms, NIF, telefon, id_Botiga, carrec) VALUES
(1, 'Anna', 'Garcia', '12345678A', '600111222', 1, 'cuiner'),
(2, 'Marc', 'Lopez', '87654321B', '600333444', 1, 'repartidor'),
(3, 'Josep', 'Jimenez', '12345678Z', '600111285', 2, 'cuiner'),
(4, 'Marta', 'Perez', '87654321S', '600333486', 2, 'repartidor');

INSERT INTO Client (id_Client, nom, cognoms, adreca, codi_postal, localitat, provincia, telefon) VALUES
(1, 'Laura', 'Martinez', 'Carrer Nou 5', '08002', 'Barcelona', 'Barcelona', '611222333'),
(2, 'Maria', 'Martinez', 'Carrer Nou 6', '08002', 'Barcelona', 'Barcelona', '611222334');

INSERT INTO Comanda (id_Comanda, data_hora_comanda, tipus_comanda, preu_total, id_Client, id_Botiga) VALUES
(1, '2025-05-10 20:30:00', 'domicili', 20.50, 1, 1),
(2, '2025-05-11 20:30:00', 'domicili', 25, 2, 2);
INSERT INTO Comanda_Producte (Comanda_id_Comanda, Producte_id_Producte, quantitat) VALUES
(1, 1, 1), 
(1, 4, 2),
(2, 3, 2), 
(2, 5, 2);

INSERT INTO Lliurament (id_Comanda, id_Empleat, data_hora_lliura) VALUES
(1, 2, '2025-05-10 21:00:00'),
(2, 4, '2025-05-11 21:00:00');

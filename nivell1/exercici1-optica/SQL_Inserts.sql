USE db_optica;

-- ---------------------------
-- Inserciones en Adreca
-- ---------------------------
INSERT INTO Adreca (id_Adreca, carrer, numero, pis, porta, ciutat, CP, pais) VALUES
(1, 'Carrer Proveidor 1', '1', '1', 'A', 'Barcelona', '08001', 'España'),
(2, 'Carrer Proveidor 2', '2', '2', 'B', 'Madrid', '28001', 'España'),
(3, 'Carrer Proveidor 3', '3', NULL, NULL, 'Valencia', '46001', 'España'),
(4, 'Carrer Client 1', '10', 1, NULL, 'Barcelona', '08001', 'España'),
(5, 'Carrer Client 2', '20', 2, NULL, 'Barcelona', '08001', 'España'),
(6, 'Carrer Client 3', '30', 3, NULL, 'Barcelona', '08001', 'España');

-- ---------------------------
-- Inserciones en Proveidor
-- ---------------------------
INSERT INTO Proveidor (id_Proveidor, nom, telefon, fax, NIF, email, id_adreca) VALUES
(1, 'Optica 1', '912345678', NULL, 'A12345678', 'info@optica1.com', 1),
(2, 'Optica 2', '912345679', '912345670', 'B87654321', 'info@optica2.com', 2),
(3, 'Optica 3', '912345680', '912345671', 'B87654322', 'info@optica3.com', 3);

-- ---------------------------
-- Inserciones en Ulleres
-- ---------------------------
INSERT INTO Ulleres (id_Ulleres, marca, grad_vidre_dreta, grad_vidre_esquerra, muntura_tipus, muntura_color, color_vidre_dreta, color_vidre_esquerra, preu, id_Proveidor) VALUES
(1, 'Ray-Ban', '-1.25', '-1.50', 'Pasta', 'Negra', 'Transparente', 'Transparente', 120.50, 1),
(2, 'Oakley', '-2.00', '-2.00', 'Metalica', 'Plateada', 'Gris', 'Gris', 150.00, 2);

-- ---------------------------
-- Inserciones en Client
-- ---------------------------
INSERT INTO Client (id_Client, nom, telefon, email, data_registre, id_Adreca, id_Client_recomanador) VALUES
(1, 'Laura Perez', '600123456', 'laura@mail.com', '2025-12-01', 4, NULL),
(2, 'Carlos Ruiz', '600654321', 'carlos@mail.com', '2025-12-05', 5, 1),
(3, 'Ana Gomez', '600987654', 'ana@mail.com', '2025-12-10', 6, 2);

-- ---------------------------
-- Inserciones en Empleat
-- ---------------------------
INSERT INTO Empleat (id_Empleat) VALUES
(1),
(2);

-- ---------------------------
-- Inserciones en Venda
-- ---------------------------
INSERT INTO Venda (id_Venda, data_venda, id_Empleat, id_Client, id_Ulleres) VALUES
(1, '2025-12-15', 1, 1, 1),
(2, '2025-12-16', 2, 2, 2),
(3, '2025-12-17', 1, 3, 1),
(4, '2025-12-18', 1, 1, 1),
(5, '2025-12-19', 2, 2, 2),
(6, '2025-12-20', 1, 3, 1);

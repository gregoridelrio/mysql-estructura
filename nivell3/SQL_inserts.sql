USE db_spotify;

INSERT INTO Usuari (id_usuari, email, password, nom, data_naixement, sexe, pais, codi_postal, tipus) VALUES
(1, 'usuari1@ex.com', 'pass1', 'Usuari 1', '1990-01-01', 'Home', 'Espanya', '08001', 'premium'),
(2, 'usuari2@ex.com', 'pass2', 'Usuari 2', '1995-05-05', 'Dona', 'Espanya', '08002', 'free'),
(3, 'usuari3@ex.com', 'pass3', 'Usuari 3', '1988-03-12', 'Home', 'Espanya', '08003', 'premium'),
(4, 'usuari4@ex.com', 'pass4', 'Usuari 4', '2000-07-25', 'Dona', 'Espanya', '08004', 'free');

INSERT INTO Targeta (id_targeta, numero, mes, any, codi_seguretat) VALUES
(1, '1111222233334444', 01, 2030, '123'),
(2, '5555666677778888', 06, 2028, '456');

INSERT INTO Paypal (id_paypal, nom) VALUES
(1, 'Paypal Usuari 1'),
(2, 'Paypal Usuari 3');

INSERT INTO Suscripcio (id_suscripcio, data_inici, data_renovacio, pagament, Targeta_id_targeta, id_paypal, id_usuari) VALUES
(1, '2024-01-01', '2025-01-01', 'targeta', 1, NULL, 1),
(2, '2024-02-15', '2025-02-15', 'paypal', NULL, 2, 3);

INSERT INTO Pagament (id_pagament, data_pagament, ordre, total, id_usuari) VALUES
(1, '2024-01-01', 'ORDRE-001', 10.00, 1),
(2, '2024-02-15', 'ORDRE-002', 10.00, 3);

INSERT INTO Artista (id_artista, nom, imatge) VALUES
(1, 'Artista 1', 'imatge1.jpg'),
(2, 'Artista 2', 'imatge2.jpg'),
(3, 'Artista 3', 'imatge3.jpg'),
(4, 'Artista 4', 'imatge4.jpg');

INSERT INTO Album (id_album, titol, any_publicacio, portada, id_artista) VALUES
(1, 'Album 1', 2024, 'portada1.jpg', 1),
(2, 'Album 2', 2023, 'portada2.jpg', 2),
(3, 'Album 3', 2022, 'portada3.jpg', 3),
(4, 'Album 4', 2024, 'portada4.jpg', 4);

INSERT INTO Canco (id_canco, titol, durada, reproduccions, id_album) VALUES
(1, 'Canco 1', 180, 500, 1),
(2, 'Canco 2', 200, 300, 1),
(3, 'Canco 3', 210, 1000, 2),
(4, 'Canco 4', 195, 250, 2),
(5, 'Canco 5', 150, 400, 3),
(6, 'Canco 6', 175, 600, 4);

INSERT INTO Playlist (id_playlist, titol, num_cancons, data_creacio, id_usuari, data_esborrada) VALUES
(1, 'Playlist 1', 2, '2024-02-01', 1, NULL),
(2, 'Playlist 2', 1, '2024-02-10', 2, NULL),
(3, 'Playlist 3', 2, '2024-03-01', 3, NULL),
(4, 'Playlist 4', 1, '2024-03-05', 4, NULL);

INSERT INTO Playlist_Canco (id_playlist, id_canco, data_afegida, id_usuari) VALUES
(1, 1, '2024-02-01', 1),
(1, 2, '2024-02-01', 1),
(2, 3, '2024-02-10', 2),
(3, 4, '2024-03-01', 3),
(3, 5, '2024-03-01', 3),
(4, 6, '2024-03-05', 4);

INSERT INTO usuari_segueix_artista (id_usuari, id_artista) VALUES
(1, 1), (1, 2),
(2, 1), (2, 3),
(3, 4), (4, 2);

INSERT INTO artista_relaciona_artista (id_artista, id_artista2) VALUES
(1, 2), (2, 1),
(3, 4), (4, 3);

INSERT INTO usuari_fav_canco (Usuari_id_usuari, Canco_id_canco) VALUES
(1, 1), (2, 3), (3, 5), (4, 6);

INSERT INTO usuari_fav_album (id_usuari, id_album) VALUES
(1, 1), (2, 2), (3, 3), (4, 4);


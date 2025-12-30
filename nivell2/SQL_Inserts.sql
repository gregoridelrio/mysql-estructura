USE db_youtube;

INSERT INTO Usuari (id_Usuari, email, password, nom, data_naixement, sexe, pais, codi_postal) VALUES
(1, 'joan@exemple.com', 'pass123', 'JoanTecno', '1995-05-15', 'Home', 'Espanya', '08001'),
(2, 'anna@exemple.com', 'anna2024', 'AnnaVlogs', '1998-10-20', 'Dona', 'Espanya', '17001');

INSERT INTO Canal (id_Canal, nom, descripcio, data_creacio, id_Usuari) VALUES
(1, 'Canal Joan', 'Tutorials', '2023-01-10', 1),
(2, 'Canal Anna', 'Viatges', '2023-02-15', 2);

INSERT INTO Video (id_Video, titol, descripcio, grandaria, nom_arxiu, durada, thumbnail, reproduccions, estat, data_publicacio, id_Usuari) VALUES
(1, 'Aprendre a programar', 'Breu tutorial', '50MB', 'programar.mp4', 300, 'thumb1.jpg', 1500, 'public', '2023-05-01 10:00:00', 1),
(2, 'Viatge a Italia', 'Dos dies a la Toscana', '500MB', 'italia.mp4', 600, 'thumb2.jpg', 3000, 'public', '2023-06-20 18:30:00', 2);

INSERT INTO Etiqueta (id_Etiqueta, nom) VALUES
(1, 'Educació'),
(2, 'Viatges'),
(3, 'Tecnologia');

INSERT INTO Etiquetes_video (id_Video, id_Etiqueta) VALUES
(1, 1),
(1, 3),
(2, 2);

INSERT INTO Suscripcio (id_Usuari, id_Canal) VALUES
(2, 1);

INSERT INTO Reaccio_Video (id_Usuari, id_Video, tipus_reaccio, data_reaccio) VALUES
(2, 1, 'like', '2023-05-02 12:00:00');

INSERT INTO Comentari (id_Comentari, text, data_comentari, id_Video, id_Usuari) VALUES
(1, 'Molt bon vídeo, Anna!', '2023-06-21 09:15:00', 2, 1);

INSERT INTO Reaccio_Comentari (id_Usuari, id_Comentari, tipus, data_reaccio) VALUES
(2, 1, 'like', '2023-06-21 10:00:00');

INSERT INTO Playlist (id_Playlist, nom, data_creacio, estat, id_Usuari) VALUES
(1, 'Favorits Programació', '2023-07-01', 'publica', 2);

INSERT INTO Playlist_Video (id_Video, id_Playlist) VALUES
(1, 1);

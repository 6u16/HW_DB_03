-- Заполнение БД BD_Music

--Очистка
DELETE FROM musicgenre
WHERE id = 0;

DELETE FROM musicbands
WHERE id = 0;

DELETE FROM albums
WHERE id = 0;

DELETE FROM tracks
WHERE id = 0;

DELETE FROM musicgenre_musicbands
WHERE id = 0;

DELETE FROM musicbands_albums
WHERE id = 0;

DELETE FROM collection_of_songs
WHERE id = 0;

DELETE FROM collection_tracks
WHERE collection_id = 0;

-- обнуление автоинкремента каскадом в связанных ключах таблиц
TRUNCATE TABLE musicbands RESTART identity CASCADE;
TRUNCATE TABLE musicgenre RESTART identity CASCADE;
TRUNCATE TABLE albums RESTART identity CASCADE;
TRUNCATE TABLE tracks RESTART identity CASCADE;
TRUNCATE TABLE musicgenre_musicbands RESTART identity CASCADE;
TRUNCATE TABLE musicbands_albums RESTART identity CASCADE;
TRUNCATE TABLE collection_of_songs RESTART identity CASCADE;
TRUNCATE TABLE collection_tracks RESTART identity CASCADE;


-- musicgenre load
INSERT INTO musicgenre(genre)
VALUES('Grindcore'), ('Brutal Death Metal'), ('Progressive Metalcore'), ('Experimental');

-- musicbands load
INSERT INTO musicbands(bands_name)
VALUES('Napalm Death'), ('Nasum'), ('Anaal Nathrakh'), ('Elitist'), ('Architects'), ('Tony Danza Topdance Extravaganza'), ('Psichofagist'), ('Fallujah');

-- albums load
INSERT INTO albums(album_name, release_date)
VALUES('Fear Emptines Despair', '1991-01-1'), ('Scum','1987-01-1');
INSERT INTO albums(album_name, release_date)
VALUES('Grind Finale I', '2002-01-1'), ('Grind Finale II', '2002-01-1');
INSERT INTO albums(album_name, release_date)
VALUES('The Whole Of The Law', '2008-01-1');
INSERT INTO albums(album_name, release_date)
VALUES('Reshape | Reason', '2012-01-1'), ('Between the Balance', '2013-01-1');
INSERT INTO albums(album_name, release_date)
VALUES('All Our Gods Have Abandoned Us', '2005-01-1'), ('Daybreaker', '2007-01-1');
INSERT INTO albums(album_name, release_date)
VALUES('Danza III: The Series Of Unfortunate Events', '2010-01-1'), ('Danza IIII: The Alpha - The Omega', '2012-01-1');
INSERT INTO albums(album_name, release_date)
VALUES('Il Secondo Tragico', '2009-01-1');
INSERT INTO albums(album_name, release_date)
VALUES('Nomadic', '2013-01-1');

-- tracks load
INSERT INTO tracks(track_name, duration, album_id)
VALUES('More Than Meets The Eye', 154, 1), ('Greed Killing', 201, 1), ('Scum', 41, 2), ('Taste The Poison', 85, 2);
INSERT INTO tracks(track_name, duration, album_id)
VALUES('Detonator', 121, 3), ('Closer To The End', 124, 3), ('Inhale/Exhale', 125, 4), ('Lat Inte Asen Styra Dritt Liv', 126, 4);
INSERT INTO tracks(track_name, duration, album_id)
VALUES('Forging Towards the Sunset', 126, 5), ('You Cant Save Me, So Stop Fucking Trying', 131, 5);
INSERT INTO tracks(track_name, duration, album_id)
VALUES('Sacred Geometry', 132, 6), ('Trace the Sky', 133, 6), ('Lonely Giant', 134, 7), ('Domino Theory (Instrumental)', 135, 7);
INSERT INTO tracks(track_name, duration, album_id)
VALUES('Gone With The Wind', 140, 8), ('Gravity', 141, 8), ('Alpha Omega', 142, 9), ('Outsider Heart', 143, 9);
INSERT INTO tracks(track_name, duration, album_id)
VALUES('I Am Sammy Jankis', 150, 10), ('Yippie-Kay-Yay Mother Fucker', 151, 10), ('Hold The Line', 152, 11), ('This Cut Was The Deepest', 153, 11);
INSERT INTO tracks(track_name, duration, album_id)
VALUES('Free-Non-Jazz Powerviolence Sonata', 160, 12), ('Apophtegma nonsense', 161, 12), ('The Dead Sea', 41, 13);

-- musicgenre_musicbands load
INSERT INTO musicgenre_musicbands(genre_id, bands_name_id)
VALUES(1, 1), (1, 2), (2, 3), (3, 4), (3, 5), (4, 6), (4, 7), (3, 8);

-- musicbands_albums load
INSERT INTO musicbands_albums(bands_name_id, album_id)
VALUES(1, 1), (1, 2), (2, 3), (2, 4), (3, 5), (4, 6), (4, 7), (5, 8), (5, 9), (6, 10), (6, 11), (7, 12), (8, 13);
--mix musicbands_albums
INSERT INTO musicbands_albums(bands_name_id, album_id)
VALUES(3, 8), (6, 12), (5, 1);

-- collection_of_songs load
INSERT INTO collection_of_songs(collection_name, release_date)
VALUES('col_01', '2005-01-1'), ('col_02', '2008-01-1'), ('col_03', '2018-01-1'), ('col_04', '2019-01-1');

-- collection_tracks load
INSERT INTO collection_tracks(collection_id, track_id)
VALUES(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6);

INSERT INTO collection_tracks(collection_id, track_id)
VALUES(2, 7), (2, 8), (2, 9), (2, 10), (2, 11), (2, 12);

INSERT INTO collection_tracks(collection_id, track_id)
VALUES(3, 13), (3, 14), (3, 15), (3, 16), (3, 17), (3, 18);

INSERT INTO collection_tracks(collection_id, track_id)
VALUES(4, 19), (4, 20), (4, 21), (4, 22), (4, 23);
-- Запросы SELECT к БД BD_Music

-- Задание 1,2,3
--1 Название и продолжительность самого длительного трека.
SELECT track_name, duration maxi FROM tracks
WHERE duration = (SELECT max(duration) FROM tracks);

--2 Название треков, продолжительность которых не менее 2.6 минут.
SELECT track_name, duration FROM tracks
WHERE duration >= 2.6*60;

--3 Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT collection_name, release_date FROM collection_of_songs
WHERE release_date BETWEEN '2018-01-1' AND '2020-01-1'

--4 Исполнители, чьё имя состоит из одного слова
SELECT bands_name FROM musicbands
WHERE position(' ' IN bands_name) < 1;

--5 Название треков, которые содержат слово «мой» или «my»
SELECT track_name FROM tracks
WHERE position('my' IN track_name) > 1;

--6 Количество исполнителей в каждом жанре
SELECT genre, COUNT(*)  FROM musicgenre g
LEFT JOIN musicgenre_musicbands m ON m.genre_id = g.id
GROUP BY g.id
ORDER BY g.id ASC;

--7 Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(id) FROM collection_tracks c
LEFT JOIN collection_of_songs cs ON cs.id = c.collection_id
WHERE release_date BETWEEN '2018-01-1' AND '2020-01-1'

--8 Средняя продолжительность треков по каждому альбому
SELECT album_name, AVG(duration) FROM tracks tr
LEFT JOIN albums al ON al.id = tr.album_id
GROUP BY album_name;

--9 Все исполнители, которые не выпустили альбомы в 2020 году
SELECT  bands_name  from musicbands m
LEFT JOIN musicbands_albums ma ON ma.bands_name_id  = m.id
LEFT JOIN albums a ON a.id = ma.album_id
WHERE release_date != '2020-01-1'
GROUP BY bands_name;

--10 Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами)
SELECT collection_name FROM collection_of_songs cs
LEFT JOIN collection_tracks ct ON ct.collection_id = cs.id
LEFT JOIN tracks t ON t.id = ct.track_id
LEFT JOIN albums a ON a.id = t.album_id
LEFT JOIN musicbands_albums ma ON ma.album_id = a.id
right JOIN musicbands m ON m.id = ma.bands_name_id
WHERE bands_name LIKE 'Tony Danza Topdance Extravaganza'
GROUP BY collection_name; -- Группировка для того чтобы вывести коллекцию не по кол.треков в ней

-- Стразу проверка на связь таблиц, так как истинная связь Исполнитель-Альбом нарушена заданием ДЗ
-- HW_DB_02_insert.sql <строка 86> --mix musicbands_albums (альбом выпущеный совместно несколькими группами) (3, 8), (6, 12), (5, 1);
-- Таблица всех связей
SELECT collection_name, COUNT(*), track_name, album_name, bands_name, genre FROM collection_of_songs cs
LEFT JOIN collection_tracks ct ON ct.collection_id = cs.id
LEFT JOIN tracks t ON t.id = ct.track_id
LEFT JOIN albums a ON a.id = t.album_id
LEFT JOIN musicbands_albums ma ON ma.album_id = a.id
LEFT JOIN musicbands m ON m.id = ma.bands_name_id
LEFT JOIN musicgenre_musicbands mm ON mm.bands_name_id = m.id
LEFT JOIN musicgenre mg ON mg.id = mm.genre_id
WHERE duration > 1
GROUP BY collection_name, track_name, album_name, bands_name, genre;

-- Задание 4
--11 Названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT album_name, COUNT(DISTINCT genre) FROM collection_of_songs cs
LEFT JOIN collection_tracks ct ON ct.collection_id = cs.id
LEFT JOIN tracks t ON t.id = ct.track_id
LEFT JOIN albums a ON a.id = t.album_id
LEFT JOIN musicbands_albums ma ON ma.album_id = a.id
LEFT JOIN musicbands m ON m.id = ma.bands_name_id
LEFT JOIN musicgenre_musicbands mm ON mm.bands_name_id = m.id
LEFT JOIN musicgenre mg ON mg.id = mm.genre_id
GROUP BY album_name
HAVING COUNT(DISTINCT genre) > 1
-- покажет 2 альбома, но микса 3, в третьем 2 исполнителя одного жанра "Experimental"

--12 Наименования треков, которые не входят в сборники
SELECT track_name, track_id FROM tracks t
LEFT JOIN collection_tracks ct ON ct.track_id = t.id
WHERE track_id ISNULL

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек,
-- — теоретически таких треков может быть несколько
--13 вариант 1
SELECT bands_name, MIN(duration) mini FROM musicbands m
LEFT JOIN musicbands_albums ma ON ma.bands_name_id  = m.id
LEFT JOIN albums a ON a.id = ma.album_id
LEFT JOIN tracks t ON t.album_id = a.id
GROUP BY bands_name
ORDER BY mini ASC
LIMIT 2;

-- вариант 2
SELECT bands_name, duration mini FROM musicbands m
LEFT JOIN musicbands_albums ma ON ma.bands_name_id  = m.id
LEFT JOIN albums a ON a.id = ma.album_id
LEFT JOIN tracks t ON t.album_id = a.id
GROUP BY bands_name, duration
HAVING (SELECT MIN(duration) FROM tracks) = duration;

-- Не засчитывайте, необязательное задание. 

--14 Названия альбомов, содержащих наименьшее количество треков
--14 Так и не разобрался как сделать по другому, однако это точно РАБОТАЕТ, проверял добавляя альбомы с одинаковым минимальным кол. треков
-- SELECT album_name, COUNT(album_id) FROM albums a
-- LEFT JOIN tracks t ON t.album_id = a.id
-- GROUP BY album_name
-- HAVING NOT (SELECT MIN(album_id) FROM tracks) < COUNT(album_id);

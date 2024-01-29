-- DB Music
-- Все переменные и названия таблиц пишем с МАЛЕНЬКОЙ буквы!!!!!!

CREATE TABLE IF NOT EXISTS musicgenre (
	id SERIAL PRIMARY KEY,  -- автоинкремент id
	genre VARCHAR(40) NOT NULL,
	UNIQUE(genre) -- добавил ограничение
);
	
CREATE TABLE IF NOT EXISTS musicbands (
	id SERIAL PRIMARY KEY,
	bands_name VARCHAR(80) NOT NULL
);
	
-- CREATE TABLE IF NOT EXISTS musicgenre_musicbands ( -- повторяться не могут, не подходит для нас
-- 	genre_id INTEGER REFERENCES musicgenre(id),
-- 	bands_name_id INTEGER REFERENCES musicbands(id),
-- 	CONSTRAINT pk PRIMARY KEY (genre_id, bands_name_id)
-- 	);

CREATE TABLE IF NOT EXISTS musicgenre_musicbands (
	id SERIAL PRIMARY KEY, -- идентификатор для каждой запс ДЗрешение
	genre_id INTEGER REFERENCES musicgenre(id),
	bands_name_id INTEGER REFERENCES musicbands(id)
);
	
CREATE TABLE IF NOT EXISTS albums (
	id SERIAL PRIMARY KEY,
	release_date date NOT NULL CHECK (release_date > '1917-01-01'), -- добавил ограничение
	album_name VARCHAR(80) NOT null
	);
	
-- CREATE TABLE IF NOT EXISTS musicbands_albums ( -- повторяться не могут, не подходит для нас
-- 	bands_name_id INTEGER REFERENCES musicbands(id),
-- 	album_id INTEGER REFERENCES albums(id),
-- 	CONSTRAINT pk_MBA PRIMARY KEY (bands_name_id, album_id)
--);

CREATE TABLE IF NOT EXISTS musicbands_albums (
	id SERIAL PRIMARY KEY,
	bands_name_id INTEGER REFERENCES musicbands(id),
	album_id INTEGER REFERENCES albums(id)
);
	
CREATE TABLE IF NOT EXISTS tracks (
	id SERIAL PRIMARY KEY,
	album_id INTEGER REFERENCES albums(id),
	duration SMALLINT NOT NULL,
	track_name VARCHAR(80) NOT NULL
);
	
CREATE TABLE IF NOT EXISTS collection_of_songs (
	id SERIAL PRIMARY KEY,
	collection_name VARCHAR(80) NOT NULL,
	release_date DATE NOT NULL CHECK (release_date > '1917-01-01') -- добавил ограничение
);

CREATE TABLE IF NOT EXISTS collection_tracks (
	collection_id INTEGER REFERENCES collection_of_songs(id),
	track_id INTEGER REFERENCES tracks(id)
);

-- схема отношений "Сотрудник"
-- вариант 1 (мой)
-- CREATE TABLE IF NOT EXISTS employee (
-- 	emp_id INTEGER PRIMARY KEY,
-- 	emp_name VARCHAR(20) NOT NULL,
-- 	dept VARCHAR(128) NOT NULL,
-- 	boss VARCHAR(20)
-- );
	
-- CREATE TABLE IF NOT EXISTS boss (
-- 	boss_person_id INTEGER PRIMARY KEY,
-- 	emp_id INTEGER NOT NULL REFERENCES employee(emp_id)
-- );

-- правка таблицы Employee
-- ALTER TABLE employee ALTER COLUMN boss TYPE integer USING boss::integer; -- заметил ошибку, приводим к integer

-- Альтернативое решение схемы отношений "Сотрудник", оптимальнее моего, предложил Олег Булыгин ПРЕПОДАВАТЕЛЬ
CREATE TABLE employee (
	id SERIAL PRIMARY KEY,
	name VARCHAR(30),
	dept VARCHAR(128) NOT NULL,
	id_manager INT REFERENCES employee(id) -- ссылка на свой же id, реализация однотабличная вместо моих двух
);

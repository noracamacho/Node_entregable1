-- Crear base de datos
CREATE DATABASE blog_db;

-- Crear Tabla users
CREATE TABLE users (
id serial primary key,
first_name varchar(30) NOT NULL,
last_name varchar(30) NOT NULL,
email varchar(50) UNIQUE NOT NULL
);

-- Crear Tabla posts
CREATE TABLE posts (
id serial primary key,
creator_id int NOT NULL,
title varchar(30) UNIQUE NOT NULL,
text varchar(200) NOT NULL,
date date
);

-- Crear tabla likes
CREATE TABLE likes (
id serial primary key,
user_id int NOT NULL,
post_id int NOT NULL
);

ALTER TABLE posts ADD FOREIGN KEY (creator_id) REFERENCES users (id);
ALTER TABLE likes ADD FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE likes ADD FOREIGN KEY (post_id) REFERENCES posts (id);

-- Instertar datos de users
INSERT INTO users (first_name, last_name, email) 
VALUES 
('Jürgen', 'Smith', 'smith@gmail.com'), 
('Lara', 'Croft', 'croft@gmail.com'), 
('Alejandro', 'Arias', 'alex@gmail.com');

-- Insertar datos de posts
INSERT INTO posts (creator_id, title, text, date) 
VALUES 
(1, 'Post 1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euismod neque metus, non elementum ex vulputate eu. Vestibulum mattis ac orci vitae rhoncusa.', '2023-02-20'),
(3, 'Post 2', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euismod neque metus, non elementum ex vulputate eu. Vestibulum mattis ac orci vitae rhoncusa.', '2023-02-20'),
(2, 'Post 3', 'Lorem ipsukjhhgjk jhgljhh uygiyrders, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euismod neque metus, non elementum ex vulputate eu. Vestibulum mattis ac orci vitae rhoncusa.', '2023-04-02'),
(3, 'Post 4', 'Lorem jh usksdhf  ipsukjhhgjk jhgljhh uygiyrders, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euismod neque metus, non elementum ex vulputate eu. Vestibulum mattis ac orci vitae rhoncus jhgslj dlska.', '2023-04-16'),
(1, 'Post 5', 'Lorem heie jh usksdhf ipsukjhhgjk jhgljhh uygiyrders, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euisjdshfbv mod neque metus, non elementum ex vulputate eu. Vestibulum mattis a.', '2023-04-21');

-- Instertar datos de likes
INSERT INTO likes (user_id, post_id) 
VALUES 
(1,5),
(2,1),
(3,2),
(3,4),
(2,5);

-- Trae todos los posts y la información del usuario del campo creator_id
SELECT * FROM posts INNER JOIN users on posts.creator_id = users.id;

 id | creator_id | title  |                                                                                                   text                                                                                                   |    date    | id | first_name | last_name |      email      
----+------------+--------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+----+------------+-----------+-----------------
  1 |          1 | Post 1 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euismod neque metus, non elementum ex vulputate eu. Vestibulum mattis ac orci vitae rhoncusa.               | 2023-02-20 |  1 | Jürgen     | Smith     | smith@gmail.com
  2 |          3 | Post 2 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euismod neque metus, non elementum ex vulputate eu. Vestibulum mattis ac orci vitae rhoncusa.               | 2023-02-20 |  3 | Alejandro  | Arias     | alex@gmail.com
  3 |          2 | Post 3 | Lorem ipsukjhhgjk jhgljhh uygiyrders, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euismod neque metus, non elementum ex vulputate eu. Vestibulum mattis ac orci vitae rhoncusa.     | 2023-04-02 |  2 | Lara       | Croft     | croft@gmail.com
  4 |          3 | Post 4 | Lorem jh usksdhf  ipsukjhhgjk jhgljhh uygiyrders, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euismod neque metus, non elementum ex vulputate eu. Vestibulum mattis ac orci vitaea. | 2023-04-16 |  3 | Alejandro  | Arias     | alex@gmail.com
  5 |          1 | Post 5 | Lorem heie jh usksdhf ipsukjhhgjk jhgljhh uygiyrders, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euisjdshfbv mod neque metus, non elementum ex vulputate eu. Vestibulum mattis a.  | 2023-04-21 |  1 | Jürgen     | Smith     | smith@gmail.com
(5 rows)


-- SELECT * FROM likes INNER JOIN posts ON likes.post_id = posts.id INNER JOIN users ON likes.user_id = users.id;

-- Trae todos los posts, con la información de los usuarios que les dieron like.
SELECT * FROM likes INNER JOIN posts ON likes.post_id = posts.id INNER JOIN users ON likes.user_id = users.id;
 id | user_id | post_id | id | creator_id | title  |                                                                                                   text                                                                                                   |    date    | id | first_name | last_name |      email      
----+---------+---------+----+------------+--------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+----+------------+-----------+-----------------
  1 |       1 |       5 |  5 |          1 | Post 5 | Lorem heie jh usksdhf ipsukjhhgjk jhgljhh uygiyrders, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euisjdshfbv mod neque metus, non elementum ex vulputate eu. Vestibulum mattis a.  | 2023-04-21 |  1 | Jürgen     | Smith     | smith@gmail.com
  2 |       2 |       1 |  1 |          1 | Post 1 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euismod neque metus, non elementum ex vulputate eu. Vestibulum mattis ac orci vitae rhoncusa.               | 2023-02-20 |  2 | Lara       | Croft     | croft@gmail.com
  3 |       3 |       2 |  2 |          3 | Post 2 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euismod neque metus, non elementum ex vulputate eu. Vestibulum mattis ac orci vitae rhoncusa.               | 2023-02-20 |  3 | Alejandro  | Arias     | alex@gmail.com
  4 |       3 |       4 |  4 |          3 | Post 4 | Lorem jh usksdhf  ipsukjhhgjk jhgljhh uygiyrders, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euismod neque metus, non elementum ex vulputate eu. Vestibulum mattis ac orci vitaea. | 2023-04-16 |  3 | Alejandro  | Arias     | alex@gmail.com
  5 |       2 |       5 |  5 |          1 | Post 5 | Lorem heie jh usksdhf ipsukjhhgjk jhgljhh uygiyrders, consectetur adipiscing elit. In quis laoreet velit. Pellentesque euisjdshfbv mod neque metus, non elementum ex vulputate eu. Vestibulum mattis a.  | 2023-04-21 |  2 | Lara       | Croft     | croft@gmail.com
(5 rows)


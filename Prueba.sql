/*
*PROYECTO 2
*@version 1.0 4/12/2019
*@author Albert Diaz 11-10278
*@author Kevin Mena 13-10869
*/

/*DROP TABLE SI EXISTEN */
DROP TABLE IF EXISTS usuario, subasta, bid, metodo_pago, producto, categoria;
DROP DATABASE IF EXISTS "1310869_1110278";

/* CREA LA BASE DE DATOS*/
CREATE DATABASE "1310869_1110278" OWNER postgres;

/* INGRESAMOS A LA BASE DE DATOS*/
\connect "1310869_1110278";

/*Tablas*/

CREATE TABLE metodo_pago (
    id_metodo INT PRIMARY KEY,
    nombre_metodo VARCHAR(20)
);

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY,
    nombre_usuario VARCHAR(30),
    registrado BOOLEAN,
    id_pago INT,

    FOREIGN KEY (id_pago) REFERENCES metodo_pago (id_metodo)
);

CREATE TABLE categoria (
    id_cat INT PRIMARY KEY,
    nombre_cat VARCHAR(30),
    cat_padre INT,

    FOREIGN KEY (cat_padre) REFERENCES categoria (id_cat)
);

CREATE TABLE producto (
    id_prod INT PRIMARY KEY,
    nombre_prod VARCHAR(50),
    desc_prod VARCHAR(100),
    espec_prod VARCHAR(100)
);

CREATE TABLE prod_cat (
    id INT PRIMARY KEY,
    id_prod INT,
    id_cat INT,

    FOREIGN KEY (id_prod) REFERENCES producto (id_prod),
    FOREIGN KEY (id_cat) REFERENCES categoria (id_cat)
);

CREATE TABLE subasta (
    id_subasta INT PRIMARY KEY,
    activa BOOLEAN,
    fecha_ini TIMESTAMP,
    fecha_fin TIMESTAMP,
    precio_base REAL,
    precio_reserva REAL,
    precio_actual REAL,
    bid_subida REAL,
    id_vendedor INT,
    prod_vend INT,

    FOREIGN KEY (id_vendedor) REFERENCES usuario (id_usuario),
    FOREIGN KEY (prod_vend) REFERENCES producto (id_prod)
);

CREATE TABLE bid (
    id_bid INT PRIMARY KEY,
    id_usuario INT,
    id_subasta INT,
    fecha DATE,
    monto REAL,

    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
    FOREIGN KEY (id_subasta) REFERENCES subasta (id_subasta)
);

/* RELLENAR DATOS EN LA TABLA QUE USAMOS */
INSERT INTO metodo_pago (id_metodo, nombre_metodo)
VALUES (0, 'Tarjeta debito'),
        (1, 'Tarjeta credito'),
        (2, 'Paypal'),
        (3, 'Zelle'),
        (4, 'Transferencia');

INSERT INTO usuario (id_usuario, nombre_usuario, registrado, id_pago)
VALUES (0, 'luis_perez', TRUE, 2),
        (1, 'super_bidder', TRUE, 0),
        (2, 'antonio14', TRUE, 1),
        (3, 'sasha1357', TRUE, 4),
        (4, 'CarmenGomez', TRUE, 3),
        (5, 'carovillegas', TRUE, 2),
        (6, 'kidruler', TRUE, 2),
        (7, 'angel16', TRUE, 1),
        (8, 'lina_18_stuart', TRUE, 1),
        (9, 'kari3020', TRUE, 4),
        (10, 'pedroMax', TRUE, 4),
        (11, 'julio_ramirez', TRUE, 0),
        (12, 'kristiannana', TRUE, 0),
        (13, 'juannauj', TRUE, 3),
        (14, 'postgres', TRUE, 3);

INSERT INTO categoria (id_cat, nombre_cat, cat_padre)
VALUES (0, 'Fashion', 0),
        (1, 'Ropa Mujeres', 0),
        (2, 'Ropa Hombres', 0),
        (10, 'Electronicos', 10),
        (11, 'Computadoras', 10),
        (12, 'Accerorios', 11),
        (13, 'Videojuegos', 10),
        (20, 'Autos', 20),
        (21, 'Partes', 20),
        (22, 'Partes de carros', 21);

INSERT INTO producto (id_prod, nombre_prod, desc_prod, espec_prod)
VALUES (0, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (1, 'Informal Manga Larga con escote', 'Largo Chifón Blusa Suelta', 'Talla XS, Color rojo'),
        (2, 'Laptop DELL', 'Dell-Inspiron 2 en 1 13.3" Pantalla táctil Laptop-Intel Core i7-Memoria 8GB', 'Intel Core i7 - 8GB Memory - 256GB Solid State Drive'),
        (3, 'DAYS GONE PS4', 'Juego de accion y aventuras, tu objetivo es sobrevivir a los zombies', 'PS4 - Region libre'),
        (4, 'BMW Volante Deportivo', 'Volante ajustado de cuero negro reconstruido', 'Volante Deportivo con el pulgar descansa, E36 M3, Nuevo Cuero'),
        (5, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (6, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (7, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (8, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (9, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (10, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (11, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (12, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (13, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (14, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (15, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (16, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (17, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (18, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (19, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (20, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (21, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (22, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (23, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (24, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (25, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (26, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (27, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (28, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M'),
        (29, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M');

INSERT INTO prod_cat(id, id_prod, id_cat)
VALUES (0, 0, 2),
        (1, 1, 1),
        (2, 2, 11),
        (3, 3, 13),
        (4, 4, 22),
        (5, 5, 1),
        (6, 6, 1),
        (7, 7, 1),
        (8, 8, 1),
        (9, 9, 1),
        (10, 10, 1),
        (11, 11, 1),
        (12, 12, 1),
        (13, 13, 1),
        (14, 14, 1),
        (15, 15, 1),
        (16, 16, 1),
        (17, 17, 1),
        (18, 18, 1),
        (19, 19, 1),
        (20, 20, 1),
        (21, 21, 1),
        (22, 22, 1),
        (23, 23, 1),
        (24, 24, 1),
        (25, 25, 1),
        (26, 26, 1),
        (27, 27, 1),
        (28, 28, 1),
        (29, 29, 1);

INSERT INTO subasta (id_subasta, activa, fecha_ini, fecha_fin, precio_base, precio_reserva, precio_actual, bid_subida, id_vendedor, prod_vend)
VALUES (0, TRUE, '16/08/2019 10:00:00', '26/08/2019 12:00:00', 5.0, 5.0, 5.0, 0.1, 0, 3),
        (1, TRUE, '12/08/2019 08:00:00', '20/08/2019 12:00:00', 10.0, 15.0, 25.0, 1.0, 3, 25),
        (2, TRUE, '02/08/2019 06:00:00', '02/09/2019 12:00:00', 25.0, 30.0, 72.0, 5.0, 7, 17),
        (3, TRUE, '13/08/2019 12:00:00', '31/08/2019 12:00:00', 200.0, 200.0, 200.0, 20.0, 14, 5),
        (4, TRUE, '05/08/2019 14:00:00', '10/08/2019 12:00:00', 1.0, 0.5, 3.2, 0.01, 8, 10);
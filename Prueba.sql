/*
*PROYECTO 2
*@version 1.0 4/12/2019
*@author Albert Diaz 11-10278
*@author Kevin Mena 13-10869
*/

/*DROP TABLE SI EXISTEN */
DROP TABLE IF EXISTS usuario, subasta, bid, metodo_pago, producto, categoria;
DROP DATABASE IF EXISTS 13-10869_11-10278;

/* CREA LA BASE DE DATOS*/
CREATE DATABASE 13-10869_11-10278 OWNER postgres;

/* INGRESAMOS A LA BASE DE DATOS*/
\connect 13-10869/11-10278;

/*Tablas*/

CREATE TABLE metodo_pago {
    id_metodo SERIAL PRIMARY KEY,
    nombre_metodo VARCHAR(20)
}

CREATE TABLE usuario {
    id_usuario SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(30),
    registrado BOOLEAN,
    id_pago SERIAL,

    FOREIGN KEY (id_pago) REFERENCES metodo_pago (id_metodo)
}

CREATE TABLE categoria {
    id_cat SERIAL PRIMARY KEY,
    nombre_cat VARCHAR(30),
    cat_padre SERIAL,

    FOREIGN KEY (cat_padre) REFERENCES categoria (id_cat)
}

CREATE TABLE producto {
    id_prod SERIAL PRIMARY KEY,
    nombre_prod VARCHAR(30),
    desc_prod VARCHAR(50),
    espec_prod VARCHAR(20),
    id_cat SERIAL,

    FOREIGN KEY (id_cat) REFERENCES categoria (id_cat)
}

CREATE TABLE subasta {
    id_subasta SERIAL PRIMARY KEY,
    activa BOOLEAN,
    fecha_ini DATE,
    fecha_fin DATE,
    precio_base REAL,
    precio_reserva REAL,
    precio_actual REAL,
    bid_subida REAL,
    id_vendedor SERIAL,
    prod_vend SERIAL,

    FOREIGN KEY (id_vendedor) REFERENCES usuario (id_usuario),
    FOREIGN KEY (prod_vend) REFERENCES producto (id_prod)
}

CREATE TABLE bid {
    id_bid SERIAL PRIMARY KEY,
    id_usuario SERIAL,
    id_subasta SERIAL,
    fecha DATE,
    monto REAL,

    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
    FOREIGN KEY (id_subasta) REFERENCES subasta (id_subasta)
}

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
        (9, 'kari3020', TRUE, 4),0
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

INSERT INTO producto (id_prod, nombre_prod, desc_prod, espec_prod, id_cat)
VALUES (0, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (1, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (2, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (3, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (4, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (5, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (6, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (7, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (8, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (9, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (10, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (11, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (12, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (13, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (14, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (15, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (16, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (17, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (18, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (19, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (20, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (21, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (22, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (23, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (24, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (25, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (26, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (27, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (28, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1),
        (29, 'Franela AEROPOSTALE', 'Franela azul muy comoda de usar', 'Talla M', 1);

INSERT INTO subasta (id_subasta, activa, fecha_ini, fecha_fin, precio_base, precio_reserva, precio_actual, bid_subida, id_vendedor, prod_vend)
VALUES (0, TRUE, '16/08/2012', '26/08/2019', 5.0, 5.0, 5.0, 1.0, 0, 3),
        (0, TRUE, '16/08/2012', '26/08/2019', 5.0, 5.0, 5.0, 1.0, 0, 3),
        (0, TRUE, '16/08/2012', '26/08/2019', 5.0, 5.0, 5.0, 1.0, 0, 3),
        (0, TRUE, '16/08/2012', '26/08/2019', 5.0, 5.0, 5.0, 1.0, 0, 3),
        (0, TRUE, '16/08/2012', '26/08/2019', 5.0, 5.0, 5.0, 1.0, 0, 3);
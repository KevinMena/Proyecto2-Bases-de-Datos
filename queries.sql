/*FUNCIONES*/

/*Funcion que busca cual es el bid maximo registrado para una subasta en especifico*/
CREATE FUNCTION maxBid(id_sub INT) 
RETURNS INT AS $$
DECLARE maxbid INT;
BEGIN
    BEGIN WORK;
    LOCK TABLE bid IN SHARE ROW EXCLUSIVE MODE;
    SELECT INTO maxbid MAX(monto), id_bid
    FROM bid
    WHERE id_sub = id_subasta
    GROUP BY id_bid;
    COMMIT WORK;

    RETURN maxbid;
END; $$ 
LANGUAGE plpgsql;

/*Funcion para cuando se vaya a hacer un bid verificar si cumple con los requisitos
para luego decir si es exitoso o no*/
CREATE FUNCTION p_bid() RETURNS TRIGGER AS $$
DECLARE
    monto INT := NEW.monto;
    id INT := NEW.id_subasta;
    precio INT;
    maxbid INT;
BEGIN
    SELECT INTO precio precio_base
    FROM subasta
    WHERE id = id_subasta;

    IF ((precio > 0) AND (precio < 10)) AND (monto >= precio * 1.2) THEN
        maxbid = maxBid(id);

        IF monto > maxbid THEN
            RETURN NEW;
        END IF;
    ELSIF ((precio >= 10) AND (precio < 100)) AND (monto >= precio * 1.1) THEN
        maxbid = maxBid(id);

        IF monto > maxbid THEN
            RETURN NEW;
        END IF;
    ELSIF ((precio >= 10) AND (precio < 100)) AND (monto >= precio * 1.05) THEN
        maxbid = maxBid(id);

        IF monto > maxbid THEN
            RETURN NEW;
        END IF;
    END IF;
    
    RETURN NULL;
END; $$
LANGUAGE plpgsql;

/*Funcion para verificar que el usuario que esta haciendo la subasta
esta registrado y tiene metodo de pago asociado*/
CREATE FUNCTION p_subasta() RETURNS TRIGGER AS $$
DECLARE
    user_id INT := NEW.id_usuario;
    registro BOOLEAN;
    pago INT;
BEGIN
    SELECT INTO registro, pago
                registrado, id_pago 
    FROM usuario 
    WHERE user_id = id_usuario;

    IF (registro = TRUE) AND (pago IS NOT NULL) THEN
        RETURN NEW;
    END IF;

    RETURN NULL;
END; $$
LANGUAGE plpgsql;

/*TRIGGERS ADICIONALES*/
CREATE TRIGGER t_subasta BEFORE INSERT ON bid
FOR EACH ROW
EXECUTE PROCEDURE p_subasta();

/*QUERY 1*/
CREATE TRIGGER t_bidNew BEFORE INSERT ON bid
FOR EACH ROW
EXECUTE PROCEDURE p_bid();


/*QUERY 2*/
CREATE PROCEDURE undolastbid(bid_toRemove INT) 
LANGUAGE plpgsql
AS $$
BEGIN 
    BEGIN WORK;
    LOCK TABLE bid IN SHARE ROW EXCLUSIVE MODE;
    DELETE FROM bid
    WHERE id_bid = bid_toRemove
    COMMIT WORK;
END;
$$;


/*QUERY 3*/
SELECT AVG(s.precio_base) AS promedio_base, p.nombre_prod, AVG(s.precio_actual) AS promedio_venta
FROM subasta s
JOIN producto p ON s.prod_vend = p.id_prod
JOIN subasta ss ON s.prod_vend = ss.prod_vend and s.id_subasta != ss.id_subasta
WHERE s.precio_base < 1.0 AND s.activa = FALSE
GROUP BY s.prod_vend, p.nombre_prod
UNION
SELECT AVG(s.precio_base) AS promedio_base, p.nombre_prod, AVG(s.precio_actual) AS promedio_venta
FROM subasta s
JOIN producto p ON s.prod_vend = p.id_prod
JOIN subasta ss ON s.prod_vend = ss.prod_vend and s.id_subasta != ss.id_subasta
WHERE s.precio_base >= 1.0 AND s.activa = FALSE
GROUP BY s.prod_vend, p.nombre_prod
ORDER BY promedio_venta DESC;


/*QUERY 4*/
SELECT cats.id_cat, cats.nombre_cat, EXTRACT(month from generate_series(
        date_trunc('month', s.fecha_ini), 
        s.fecha_fin, '1 month'
    )::date) AS months, COUNT(*) AS no_subastas
FROM subasta AS s
JOIN (SELECT pc.id, pc.id_prod, c.id_cat, c.nombre_cat
	 FROM prod_cat AS pc
	 JOIN categoria AS c ON pc.id_cat = c.id_cat) AS cats ON s.prod_vend = cats.id_prod
GROUP BY months, cats.id_cat, cats.nombre_cat
ORDER BY cats.id_cat, cats.nombre_cat, months ASC
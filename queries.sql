SELECT cats.id_cat, cats.nombre_cat, EXTRACT(month from s.fecha_ini) AS months, COUNT(*) AS no_subastas
FROM public.subasta AS s
JOIN (SELECT pc.id, pc.id_prod, c.id_cat, c.nombre_cat
	 FROM public.prod_cat AS pc
	 JOIN public.categoria AS c ON pc.id_cat = c.id_cat) AS cats ON s.prod_vend = cats.id_prod
GROUP BY months, cats.id_cat, cats.nombre_cat
ORDER BY cats.id_cat, cats.nombre_cat, months ASC
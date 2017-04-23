
create view CGP_con_mas_de_dos_revisiones as
select cgp.id, count(cgp.id) as cant
from cgp,poi_opinion
where cgp.id = poi_opinion.POI_id
group by cgp.id
having cant > 2


create view POIS_dados_de_baja as
(select b.id , b.descripcion , b.domicilio, b.barrio, b.compania , '' nroComuna , '' nombre , '' rubro_id , '' nroLinea
from banco b where b.habilitado = 0) 
union
(select c.id , c.descripcion , c.domicilio,'' barrio, '' compania , c.nroComuna , '' nombre , '' rubro_id , '' nroLinea
from cgp c where c.habilitado = 0) 
union
(select ct.id , ct.descripcion , ct.domicilio,'' barrio, '' compania , '' nroComuna , '' nombre , '' rubro_id , ct.nroLinea
from colectivo ct where ct.habilitado = 0) 
union
(select l.id , l.descripcion , l.domicilio,'' barrio, '' compania , '' nroComuna , l.nombre , l.rubro_id , '' nroLinea
from local l where l.habilitado = 0) 


create view PROMEDIO_POR_POI AS
select POI_id as idpoi, 
count(POI_id) as CantidadDeOpiniones, 
sum(op.calificacion)/count(POI_id) as Promedio

from poisphm.poi_opinion as poiop inner join poisphm.opinion  as op 
on op.id=poiop.listaOpiniones_id
group by POI_id

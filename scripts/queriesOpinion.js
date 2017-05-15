/* 1) Calificacion promedio de POI con mapReduce*/

var calificacionesHechas = function() {
    emit(this.poi, this.calificacion)
};

var promedioCalificacion = function(poi, calificacion) {
    return { promedio: Array.avg(calificacion) };
};

db.Opinion.mapReduce(calificacionesHechas, promedioCalificacion, { out: "PromedioPOI" })

/* Luego para buscar el de un POI en particular */

db.PromedioPOI.find({ "_id": "Manin Hnos." });

/* 1) Calificacion Promedio de POI con aggregate */

db.Opinion.aggregate
(
	{ $group: { _id: "$poi", promedio: { $avg: "$calificacion" } } }
);

/* 2) Comentarios de POIs con califcacion 5 con mapReduce */

var calificacionMayorCinco = function() {
    if (this.calificacion == 5) {
        emit(this.poi, this.comentario)
    }
};

var comentarios = function(poi, comentario) {
    return { comentarios: Array.join(comentario) };
};

db.Opinion.mapReduce(calificacionMayorCinco, comentarios, { out: "ComentariosDePOICon5" });

/* 2) Comentarios de POIs con califcacion 5 con aggregate */

db.Opinion.aggregate
(
	{ $match: { calificacion: 5 } },
    { $group: { _id: "$poi", comentarios: { $push: "$comentario" } } }
);


/* 3) Calificacion Promedio de Usuario con mapReduce */

var calificacionesHechas = function() {
    emit(this.usuario, this.calificacion)
};

var promedioCalificacion = function(usuario, calificacion) {
    return { promedio: Array.avg(calificacion) };
};

db.Opinion.mapReduce(calificacionesHechas, promedioCalificacion, { out: "PromedioUsuario" })

/* Luego para buscar el de un Usuario en particular */

db.PromedioUsuario.find({ "_id": "Mauro" });

/* 3) Calificacion Promedio de Usuario con aggregate */

db.Opinion.aggregate
(
	{ $group: { _id: "$usuario", promedio: { $avg: "$calificacion" } } }
);

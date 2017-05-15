/*
 fallidos de la ultima semana del usuario
 */
var usuario = "Fede" /* usuario de ejemplo */

var hoy = new Date(),
    anio = hoy.getYear(),
    mes = hoy.getMonth(),
    dia = hoy.getDate() - 15,

hace7Dias = new Date(anio, mes, dia);

db.getCollection('Log').find({
    "fechaHora": {
        $gte: hace7Dias,
        $lt: hoy
    },
    "exitoso": { $eq: false },
    "usuario": { $eq: usuario }
}).pretty();

/*
 fallidos por usuario
 */

db.Log.aggregate
(
	{ $match: { exitoso: false } },
	{ $group: { _id: "$usuario", total: { $sum: 1 } } },
	{ $sort: { total: -1 } }
);

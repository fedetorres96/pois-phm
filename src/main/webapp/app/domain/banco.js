function Banco(){}

Banco.prototype = new POI();

Banco.fromJSON = function(jsonBanco) {
    var banco = angular.extend(new Banco(), jsonBanco);
    banco.ubicacion = Point.asPoint(jsonBanco.ubicacion);
    banco.horario = Horario.asHorario(jsonBanco.horario);
    return banco;
};
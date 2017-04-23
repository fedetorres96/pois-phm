function CGP() {}

CGP.prototype = new POI();

CGP.prototype.estaDisponible = function() {
    return _.some(this.listaServicios, function(horario) {
        return horario.estaDisponible();
    });
};

CGP.prototype.estaCerca = function(unPoint) {
    return this.limites.isInside(unPoint);
};

CGP.fromJSON = function(jsonCGP) {
    var cgp = angular.extend(new CGP(), jsonCGP);
    cgp.ubicacion = Point.asPoint(jsonCGP.ubicacion);
    cgp.limites = Polygon.asPolygon(jsonCGP.limites);
    cgp.listaServicios = _.map(jsonCGP.servicios, Servicio.asServicio);
    return cgp;
};

// ----- Servicios -----

function Servicio() {}

Servicio.prototype.estaDisponible = function() {
    return this.horario.estaDisponible();
};

Servicio.asServicio = function(jsonServicio) {
    var servicio = angular.extend(new Servicio(), jsonServicio);
    servicio.horario = Horario.asHorario(jsonServicio.horario);
    return servicio;
};

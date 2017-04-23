function POI() {
    this.nombre = "";
    this.nroCuadras = 5;
}

POI.prototype = {
    distancia: function(unPoint) {
        return Math.round(this.ubicacion.distance(unPoint) * 10);
    },

    estaCerca: function(unPoint) {
        return this.distancia(unPoint) <= this.nroCuadras;
    },

    estaDisponible: function() {
        return this.horario.estaDisponible();
    },
    yaOpino: function(unUsuario) {
        var usuarios = _.map( this.listaOpiniones, function(opinion) {
            return opinion.usuario;
        });
        return _.contains( usuarios, unUsuario.nombre );
    }
};

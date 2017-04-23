function Horario() {
    this.listaDias = [];

    this.estaDisponible = function() {
        return _.some(this.listaDias, function(horario) {
            return horario.estaDisponible();
        });
    };
}

Horario.asHorario = function(jsonHorario) {
    var horario = new Horario();
    horario.listaDias = _.map(jsonHorario, Rango.asRango);
    return horario;
};

// ----- Rango Horario -----
moment.locale('es');

function Rango() {
    this.estaDisponible = function() {
        return moment().isBetween(this.momentoAbre, this.momentoCierra);
    };

    this.toString = function() {
        return this.momentoAbre.format('dddd : HH:mm') + this.momentoCierra.format(' - HH:mm');
    };
}

Rango.asRango = function(jsonRango) {
    var rango = new Rango();
    rango.momentoAbre = moment(jsonRango.abre);
    rango.momentoCierra = moment(jsonRango.cierra);
    return rango;
};

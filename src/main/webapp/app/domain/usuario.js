function Usuario(){

}

Usuario.prototype.esFavorito = function(unPoi) {
    return _.contains(this.listaFavoritos, unPoi.id);
};

Usuario.asUsuario = function(jsonUsuario) {
    var usuario = angular.extend(new Usuario(), jsonUsuario);
    usuario.ubicacion = Point.asPoint(jsonUsuario.ubicacion);
    return usuario;
};

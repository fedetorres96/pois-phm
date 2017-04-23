app.service("usuarioService", function($http, $sessionStorage) {
    var self = this;
    this.usuario = ($sessionStorage.usuario) ? Usuario.asUsuario($sessionStorage.usuario) : null;

    this.getUsuarios = function() {
        $http.get("/usuarios").then(function(response) {
            self.usuarios = _.map(response.data, Usuario.asUsuario);
        });
    };

    this.logIn = function(nombre, contrasenia) {
        var usuario = _.find(self.usuarios, function(usuario) {
            return usuario.nombre == nombre && usuario.contrasenia == contrasenia;
        });

        if (!usuario)
            throw "Datos de ingreso incorrectos";
        else {
            self.updateUsuario(usuario);
        }
    };

    this.logOut = function() {
        $sessionStorage.usuario = null;
    };

    this.updateUsuario = function(usuario) {
        this.usuario = Usuario.asUsuario(usuario);
        $sessionStorage.usuario = this.usuario;
    };

    this.getUsuarios();
});

app.service("poiService", function($http) {
    var self = this;

    this.getPois = function(query, callback) {
        $http.get('/pois', { params: { "query": query } })
            .then(callback);
    };

    this.getPoi = function(id, callback) {
        $http.get('/poi', { params: { "id": id } })
            .then(callback);
    };

    /*this.addOpinion = function(poi, opinion, callback) {
        $http.put('/opinion/' + poi.id, opinion)
            .then(callback);
    };*/

    this.addOpinion = function(poi, opinion) {
        return $http.put('/opinion/' + poi.id, opinion);
    };

    this.changeFavorito = function(poi, usuario, callback) {
        $http.post('/favorito/' + poi.id + "/" + usuario.id)
            .then(callback);
    };

    this.putDescripcion = function(poi, callback) {
        $http.get('/poi/descripcion/' + poi.id, { params: { "descripcion": poi.descripcion } })
            .then(callback);
    };

    this.inhabilitar = function(poi, callback) {
        $http.get('/poi/inhabilitar/' + poi.id)
            .then(callback);
    };
});

app.controller('userController', function ($state, usuarioService) {
    var self = this;
    this.usuario = usuarioService.usuario || null;

    this.resetCampos = function () {
        this.textoNombre = "";
        this.textoContrasenia = "";
    };

    this.validarCampos = function () {
        if (this.textoNombre === "")
            throw "Ingrese un nombre";

        if (this.textoContrasenia === "")
            throw "Ingrese una contraseña";
    };

    this.logIn = function () {
        this.errorMessage = "";
        try {
            this.validarCampos();

            usuarioService.logIn(this.textoNombre, this.textoContrasenia, function (response) {
                if (response.data == "null")
                    self.errorMessage =  "Datos de ingreso incorrectos";
                else {
                    usuarioService.updateUsuario(response.data);
                    self.usuario = usuarioService.usuario;
                    self.resetCampos();
                    $state.go('main.busqueda');
                }
            });

        } catch (exception) {
            this.errorMessage = exception;
        }
    };

    this.logOut = function () {
        usuarioService.logOut();
        this.usuario = null;
        $state.go('main.login');
    };
});

app.controller('busquedaController', function (usuarioService, poiService) {
    var self = this;
    this.textoBusqueda = "";
    this.usuario = usuarioService.usuario;

    this.buscar = function () {
        poiService.getPois(this.textoBusqueda, function (response) {
            self.pois = _.map(response.data, asPOI);
        });
    };

    this.buscar();
});

function asPOI(jsonPOI) {
    var tipoPOI = eval(jsonPOI.tipo);
    this.poi = tipoPOI.fromJSON(jsonPOI);
    return this.poi;
}


app.controller('detalleController', function ($stateParams, poiService, usuarioService) {
    var self = this;


    this.getPoi = function () {
        poiService.getPoi($stateParams.id, function (response) {
            self.poi = asPOI(response.data);
            self.usuario = usuarioService.usuario;
        });
    };

    this.validarCampos = function () {
        return this.calificacion && this.textoComentario;
    };

    this.getOpinion = function () {
        return new Opinion(this.calificacion, this.textoComentario);
    };

    this.addOpinion = function () {
        var self = this;
        
        poiService.addOpinion(self.poi, self.usuario, self.getOpinion(), function (response) {
            self.getPoi();
        });
    };

    this.changeFavorito = function () {
        poiService.changeFavorito(self.poi, self.usuario, function (response) {
            self.usuario = Usuario.asUsuario(response.data);
            usuarioService.updateUsuario(self.usuario);
            usuarioService.getUsuarios();
        });
    };

    this.changeEditar = function () {
        this.editar = !this.editar;

        if (!this.editar) {
            poiService.putDescripcion(this.poi, function (response) {
                self.getPoi();
            });
        }
    };

    this.inhabilitar = function () {
        poiService.inhabilitar(this.poi, function (response) {
            self.getPoi();
        });
    };

    this.getPoi();

});

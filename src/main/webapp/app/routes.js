app.config(function($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise("/login");

    $stateProvider
        .state('main', {
            abstract: true,
            views: {
                '': {
                    templateUrl: 'partials/layout.html',
                    controller: "userController as login"
                },
                'container@main': {
                    template: '<ui-view>'
                },
                'topbar@main': {
                    templateUrl: "partials/top.html",
                            
                }
            }
        })

    .state('main.login', {
        url: "/login",
        templateUrl: "partials/login.html",
    })


    .state('main.busqueda', {
        url: "/busqueda",
        controller: "busquedaController as busqueda",
        templateUrl: "partials/busqueda.html",
    })

    .state('main.detalle', {
        url: "/detalle/:id",
        views: {
            "": {
                templateUrl: 'partials/detalle_poi.html',
                controller: "detalleController as detalle"
            },
            "opiniones@main.detalle": {
                templateUrl: 'partials/opinion_tabla.html'
            },
             "opinion@main.detalle": {
                templateUrl: 'partials/opinion_modal.html'
            }

        }
    })

    .state('main.detalle.Banco', {
        views: { 'tipo-poi': { templateUrl: 'partials/detalle_poi_banco.html' } }
    })

    .state('main.detalle.CGP', {
        views: { 'tipo-poi': { templateUrl: 'partials/detalle_poi_cgp.html' } }
    })

    .state('main.detalle.Colectivo', {
        views: { 'tipo-poi': { templateUrl: 'partials/detalle_poi_colectivo.html' } }
    })

    .state('main.detalle.Local', {
        views: { 'tipo-poi': { templateUrl: 'partials/detalle_poi_local.html' } }
    })

});

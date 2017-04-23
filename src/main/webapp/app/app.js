var app = angular.module('poiApp', ['ui.router','ngAnimate','ngStorage']);

app.filter('siNo', function() {
    return function(unBoolean) {
        return unBoolean ? 'Si' : 'No';
    };
});

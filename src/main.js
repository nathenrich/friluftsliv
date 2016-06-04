angular             = require('angular');
lodash              = require('lodash');
angularSimpleLogger = require('angular-simple-logger');
angularRoute        = require('angular-route');
angularResource     = require('angular-resource');
angularGoogleMaps   = require('angular-google-maps');
routes              = require('./routes');
mainController      = require('./controllers/MainController');
authController      = require('./controllers/AuthController');

var app = angular.module('app', ['ngRoute', 'ngResource', 'uiGmapgoogle-maps']).run(function($rootScope) {
  $rootScope.authenticated = false;
  $rootScope.current_user = '';

  $rootScope.signout = function(){
      $http.get('auth/signout');
      $rootScope.authenticated = false;
      $rootScope.current_user = '';
  };
});

app.config(routes);

app.controller('mainController', ['$scope', '$rootScope', 'postService', mainController]);
app.controller('authController', ['$scope', '$http', '$rootScope', '$location', authController]);

app.factory('postService', function($resource){
	return $resource('/api/posts/:id');
});

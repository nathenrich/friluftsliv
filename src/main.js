angular             = require('angular');
lodash              = require('lodash');
angularSimpleLogger = require('angular-simple-logger');
angularRoute        = require('angular-route');
angularResource     = require('angular-resource');
angularGoogleMaps   = require('angular-google-maps');

var app = angular.module('app', ['ngRoute', 'ngResource', 'uiGmapgoogle-maps']).run(function($rootScope) {
  $rootScope.authenticated = false;
  $rootScope.current_user = '';

  $rootScope.signout = function(){
      $http.get('auth/signout');
      $rootScope.authenticated = false;
      $rootScope.current_user = '';
  };
});

app.config(function($routeProvider){
	$routeProvider
		//the timeline display
		.when('/', {
			templateUrl: 'main.html',
			controller: 'mainController'
		})
		//the login display
		.when('/login', {
			templateUrl: 'login.html',
			controller: 'authController'
		})
		//the signup display
		.when('/register', {
			templateUrl: 'register.html',
			controller: 'authController'
		});
});

app.factory('postService', function($resource){
	return $resource('/api/posts/:id');
});

app.controller('mainController', function($scope, $rootScope, postService){
  $scope.posts = postService.query();
  $scope.newPost = {created_by: '', text: '', created_at: ''};
  $scope.map = { center: { latitude: 42, longitude: -73 }, zoom: 8 };

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(){
      $scope.map = { center: { latitude: 45, longitude: -73 }, zoom: 8 };
    });
  } else {
    console.log("Geolocation is not supported by this browser.");
  }

  $scope.post = function() {
    $scope.newPost.created_by = $rootScope.current_user;
    $scope.newPost.created_at = Date.now();
    postService.save($scope.newPost, function(){
      $scope.posts = postService.query();
      $scope.newPost = {created_by: '', text: '', created_at: ''};
    });
  };
});

app.controller('authController', function($scope, $http, $rootScope, $location){
  $scope.user = {username: '', password: ''};
  $scope.error_message = '';

  $scope.login = function(){
    $http.post('/auth/login', $scope.user).success(function(data){
      if(data.state == 'success'){
        $rootScope.authenticated = true;
        $rootScope.current_user = data.user.username;
        $location.path('/');
      }
      else{
        $scope.error_message = data.message;
      }
    });
  };

  $scope.register = function(){
    $http.post('/auth/signup', $scope.user).success(function(data){
      if(data.state == 'success'){
        $rootScope.authenticated = true;
        $rootScope.current_user = data.user.username;
        $location.path('/');
      }
      else{
        $scope.error_message = data.message;
      }
    });
  };
});

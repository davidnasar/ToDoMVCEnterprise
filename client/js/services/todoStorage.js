/*global angular */

/**
 * Services that persists and retrieves TODOs from localStorage
 */



angular.module('todomvc')
	.factory('todoStorage', function ($http ) {

		'use strict';

    var fb = new Firebase("https://todomvc-fusion.firebaseio.com");
    var appHost = window.location.host,
      tokenUrl = 'http://' +appHost + '/firebase/token';
    console.log('window.location.host: ', appHost);
    console.log('tokenUrl:', tokenUrl);

    $http.get(tokenUrl).success(function (authToken) {
//      console.log('data: ', data);
      fb.auth(authToken.token, function (error, authData) {
        if (error) {
          console.log('Login failed!', error);
        } else {
          console.log('Login Succeeded! authData: ', authData);

        }
      });

      fb.set({});
      fb.push({test: true});
    });


		var STORAGE_ID = 'todos-angularjs';

		return {
			get: function () {
				return JSON.parse(localStorage.getItem(STORAGE_ID) || '[]');
			},

			put: function (todos) {
				localStorage.setItem(STORAGE_ID, JSON.stringify(todos));
        console.log('todos:', todos);

        todos.forEach( function (todo) {
          fb.push({ 'todo': todo});
        });
			}
		};
	});

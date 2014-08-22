/*global angular */

/**
 * Services that persists and retrieves TODOs from localStorage
 */



angular.module('todomvc')
	.factory('todoStorage', function () {
		'use strict';

    var fb = new Firebase("https://todomvc-fusion.firebaseio.com/todos");

//    var fb = 'foo';
    console.log('fb: ', fb);


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

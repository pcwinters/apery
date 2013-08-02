var module = angular.module('racer', [], function ($provide) {
	var setImmediate = window && window.setImmediate ? window.setImmediate : function (fn) {
		setTimeout(fn, 0);
	};
	
	debugger;
	var racer = require('racer');
	
	$provide.factory('racer', ['$http', '$q', '$rootScope', function ($http, $q, $rootScope) {
		debugger;
		$http.get('http://localhost:3000/model').success(function (data) {
			debugger
			racer.init(data);
		});
 
		var def = $q.defer();
		racer.on('ready', function (model) {
			debugger;
			var operations = ['set', 'del', 'setNull', 'incr', 'push', 'unshift', 'insert', 'pop', 'shift', 'remove', 'move'];
			for (var i = 0; i < operations.length; ++i) {
				(function (i) {
					// local changes
					var op = model[operations[i]];
					model[operations[i]] = function () {
						var args = Array.prototype.slice.call(arguments);
						var cb;
						if (typeof args[args.length - 1] === 'function') {
							cb = args.pop();
						}
						args[args.length] = function () {
							if (cb) cb.apply(this, arguments);
							setImmediate($rootScope.$apply.bind($rootScope));
						};
 
						op.apply(this, args);
					};
 
					// remote changes
					model.on(operations[i], '*', setImmediate.bind(this, $rootScope.$apply.bind($rootScope)));
				})(i);
			}
 
			def.resolve(model);
		});
 
		return def.promise;
	}]);
});
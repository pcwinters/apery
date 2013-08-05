var module = angular.module('racer', [], function ($provide) {
	var setImmediate = window && window.setImmediate ? window.setImmediate : function (fn) {
		debugger
		setTimeout(fn, 0);
	};
	
	var racer = require('racer');
	
	$provide.factory('racer', ['$http', '$q', '$rootScope', function ($http, $q, $rootScope, $timeout) {
		$http.get('/project/101').success(function (data) {
			racer.init(data);
		});
 
		var def = $q.defer();
		racer.on('ready', function (model) {
			// remote changes
//			model.on('all', '**', function() {
//				debugger
//				$rootScope.$digest()
//				}); 
					
					//setImmediate.bind(this, $rootScope.$apply.bind($rootScope)));
			
//			var operations = ['set', 'del', 'setNull', 'incr', 'push', 'unshift', 'insert', 'pop', 'shift', 'remove', 'move', 'change', 'stringInsert', 'stringRemove'];
//			for (var i = 0; i < operations.length; ++i) {
//				(function (i) {
//					// local changes
//					var op = model[operations[i]];
//					model[operations[i]] = function () {
//						var args = Array.prototype.slice.call(arguments);
//						var cb;
//						if (typeof args[args.length - 1] === 'function') {
//							cb = args.pop();
//						}
//						args[args.length] = function () {
//							if (cb) cb.apply(this, arguments);
//							setImmediate($rootScope.$apply.bind($rootScope));
//						};
// 
//						op.apply(this, args);
//					};
//
//					// remote changes
//					
//					
//				})(i);
//			}
			
			model.on('all', '**', setImmediate.bind(this, $rootScope.$apply.bind($rootScope)));
			def.resolve(model);
		});
 
		return def.promise;
	}]);
		
});

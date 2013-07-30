'use strict';

angular.module('aperyApp', ['ui', 'ui.bootstrap','angular-underscore', 'ui.state', 'restangular'])
  .config(function ($routeProvider, $stateProvider, RestangularProvider) {
    
	RestangularProvider.setBaseUrl("/api/v1");
	  
    $stateProvider.state('page',{
    	url: '/p/:pageId',
    	templateUrl: function(params) {
    		return "/views/pages/"+params.pageId+".html"
    	},
    	controller: function($scope, $state) {
    		$scope.$emit('pageId', $state.params.pageId);
    	}
    })
    
  });

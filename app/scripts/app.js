'use strict';

angular.module('aperyApp', ['ui.bootstrap','angular-underscore', 'ui.state'])
  .config(function ($routeProvider, $stateProvider) {
    
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

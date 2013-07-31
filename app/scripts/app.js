'use strict';

var app = angular.module('aperyApp', ['ui', 'ui.bootstrap','angular-underscore', 'ui.state', 'restangular', 'placeholders', 'uuid']);

app.factory('randomStory', function(uuid4, TextGeneratorService) {

	  // service is just a constructor function
	  // that will be called with 'new'
	return {
	  generate: function(type) {
		 if(!type){
			  type = ['US','DE'][_.random(1)];
		 }
	     return {
	    	 type: type,
	    	 id: uuid4.generate().substring(0,4),
	    	 title: TextGeneratorService.createSentence(_.random(10))
	     }
	  }
	}
});

app.config(function ($provide, $routeProvider, $stateProvider, RestangularProvider) {
    
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


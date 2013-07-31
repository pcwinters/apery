app = angular.module('aperyApp', ['ui', 'ui.bootstrap','angular-underscore', 'ui.state', 'restangular', 'placeholders', 'uuid'])

app.factory 'randomStory', (uuid4, TextGeneratorService) ->
	return {
		generate: (type) ->
			if not type?
				type = ['US','DE'][_.random(1)]
			return {
				type: type
				id: uuid4.generate().substring(0,4)
				title: TextGeneratorService.createSentence(_.random 10 )
			}
	}

app.config ($provide, $routeProvider, $stateProvider, RestangularProvider) ->
	RestangularProvider.setBaseUrl "/api/v1"  
	$stateProvider.state 'page', {
		url: '/p/:pageId'
		templateUrl: (params) -> return "/views/pages/#{params.pageId}.html"	
		controller: ($scope, $state) -> $scope.$emit 'pageId', $state.params.pageId
	}


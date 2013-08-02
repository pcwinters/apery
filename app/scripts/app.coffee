app = angular.module('aperyApp', ['ui', 'ui.bootstrap','angular-underscore', 'ui.state', 'restangular', 'placeholders', 'uuid', 'rally', 'racer'])

app.factory 'StoryService', (uuid4, TextGeneratorService) ->
	class StoryService
		
		constructor: () ->
			@_stories = @_generateList()
		
		findAll: () ->
			return @_stories
		
		_generateList: (range=15) =>
			stories  = _.map _.range(range), (index) =>
				story = @_generate() 
				return story
			return stories
		
		_generate: (type) ->
			if not type?
				type = ['US','DE'][_.random 1 ]
			#id = uuid4.generate().substring 0, 4
			id = _.random 99 
			return {
				type: type
				id: "#{type}#{id}"
				title: TextGeneratorService.createSentence(_.random 5 )
			}
			
	return new StoryService

app.config ($provide, $routeProvider, $stateProvider, RestangularProvider) ->
	RestangularProvider.setBaseUrl "/api/v1"  
	$stateProvider.state 'page', {
		url: '/p/:pageId'
		templateUrl: (params) -> return "/views/pages/#{params.pageId}.html"	
		controller: ($scope, $state) -> $scope.$emit 'pageId', $state.params.pageId
	}


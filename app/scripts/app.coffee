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
			number = _.random 99 
			return {
				type: type
				number: "#{type}#{number}"
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

app.filter 'reverse', () ->
	return (items) ->
		if items?
			return items.slice().reverse();
		else
			return items

app.filter 'model', () ->
	debugger
	previous = null
	return (items, model) ->
		mapped = _.map items, (item, index) ->
			mappedItem = if model? then model.at "#{index}" else null
			if mappedItem?
				mappedItem.$$hashKey = mappedItem._at
			return mappedItem
		debugger
		previous = mapped[0]
		return mapped

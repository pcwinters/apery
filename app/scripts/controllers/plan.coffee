app = angular.module 'aperyApp'

app.controller 'PlanCtrl', ($scope, StoryService, racer) ->
	$scope.stories = StoryService.findAll()
	 

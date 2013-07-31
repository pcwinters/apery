app = angular.module 'aperyApp'

app.controller 'PlanCtrl', ($scope, randomStory) ->
	$scope.stories = _.map _.range(15), (index) ->
		story = randomStory.generate() 
		return story
	 

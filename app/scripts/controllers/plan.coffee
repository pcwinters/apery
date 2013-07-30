app = angular.module 'aperyApp'

app.controller 'PlanCtrl', ($scope, Restangular) ->
	$scope.stories = [#Restangular.all('stories').getList()
		{
			id: 'abc'
			title: 'As a user I would like to do x'
		},
		{
			id: 'bcd'
			title: 'As a developer I would like to do x'
		},
		{
			id: 'cde'
			title: 'As a manager I would like to do x'
		},
		{
			id: 'def'
			title: 'As a magician I would like to do make x appear'
		}
	
	]
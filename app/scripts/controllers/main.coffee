app = angular.module 'aperyApp'

app.controller 'MainCtrl', ($scope, $location) ->

    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ]
    
app.controller 'MainTabsCtrl', ($scope, $routeParams, $location) ->
	$scope.tabs = [
		{ title:"Plan", id:"plan" },
		{ title:"Backlog", id:"backlog", disabled: true}
	]
	$scope.location = $location
	
#	#Each time controller is recreated, check tab in url
#	$scope.currentTab = $routeParams.tabId #+ to parse to int
#
#	$scope.$watch 'currentTab', (id, oldId) ->
#		if id is not oldId
#			$location.path '/p/'+id
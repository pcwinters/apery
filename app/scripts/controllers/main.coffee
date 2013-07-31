app = angular.module 'aperyApp'

app.controller 'MainCtrl', ($scope, $location) ->
	$scope.tabs = [
		{ title:"Plan", id:"plan" },
		{ title:"Backlog", id:"backlog", disabled: true}
	]
	$scope.location = $location
	#Each time controller is recreated, check tab in url
	$scope.selectedTab = () ->
		tab = _.find $scope.tabs, (tab) -> return tab.active
		return tab
	$scope.$on 'pageId', (event, pageId) ->
		_.each $scope.tabs, (tab) -> tab.active = false
		tab = _.find $scope.tabs, (tab) -> return tab.id is pageId
		if tab? then tab.active = true
			
		
	#$scope.currentTab = $routeParams.tabId #+ to parse to int
	$scope.$watch 'selectedTab()', (currentTab, oldTab) ->
		if currentTab? and currentTab isnt oldTab
			$location.path '/p/'+currentTab.id

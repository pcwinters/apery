app = angular.module 'aperyApp'

app.controller 'PlanCtrl', ($scope, StoryService, racer, $timeout) ->
	racer.then (model) ->
		project = model.at('projects.101')
		$scope.project = project
#		$scope.stories = () -> 
#			debugger
#			theMap = _.memoize () -> _.map project.at('stories').get(), (s, i) -> project.at("stories.#{i}")
#			return theMap()
#		
		$scope.hash = (story) ->
			debugger
			return story._at
		
		
		
		mapModel = (arrayModel) ->
			
			mapItems = () -> 
				return if arrayModel?.get()? then _.map arrayModel.get(), (s, i) -> arrayModel.at("#{i}") else []
			items = mapItems()
			
			arrayModel.on 'all', () ->
				$timeout () ->
					$scope.$apply () ->
						items = mapItems()
				
			return () ->
				return items
			
		
		$scope.stories = mapModel project.at('stories')		
		
#		
#		$scope.stories = () -> 
#			debugger
#			them = if project? then _.map project.at('stories').get(), (s, i) -> project.at("stories.#{i}") else []
#			return them
#		
			
		$scope.add = () ->
			debugger
			array = project.at('stories').get()
			story = StoryService._generate()
			project.push 'stories', story
			
		$scope.refresh = () ->
			#$scope.stories = _.map project.at('stories').get(), (s, i) -> project.at("stories.#{i}")
			console.log 'nothing'
			

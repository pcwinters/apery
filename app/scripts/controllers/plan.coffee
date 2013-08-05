app = angular.module 'aperyApp'

app.controller 'PlanCtrl', ($scope, StoryService, racer, $timeout) ->
	
	$scope.options = 
		update:	(e, ui) ->
			
			getStory = (element) ->
				return if element.length>0 then angular.element(element.get(0)).scope().story else null
			
			
			getIndex = (story) ->
				return if story? then story.leaf() else null
			
			
			theItem = ui.item
			story = getStory theItem
			next = getIndex getStory theItem.next()
			prev = getIndex getStory theItem.prev()
			debugger
			
			max = _.max [next,prev]
			min = _.min [next,prev]
			from = getIndex story
			story.parent().move(from, next)
			
#		
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
			theArray = []
			
			mapItems = () -> 
				theArray.pop() while theArray.length > 0 # Empty the existing array
				mapped = if arrayModel?.get()? then _.map arrayModel.get(), (s, i) -> arrayModel.at(i) else []
				_.each mapped, (item) -> theArray.push item
				return theArray
   			
			mapItems()
			
			arrayModel.on 'all', () ->
				$timeout () ->
					$scope.$apply () ->
						mapItems()
				
			return theArray
			
		
		$scope.stories = mapModel project.at('stories')		

#		$scope.stories = () -> 
#			debugger
#			them = if project? then _.map project.at('stories').get(), (s, i) -> project.at("stories.#{i}") else []
#			return them
#		
			
		$scope.add = () ->
			array = project.at('stories').get()
			story = StoryService._generate()
			project.push 'stories', story
			
		$scope.refresh = () ->
			#$scope.stories = _.map project.at('stories').get(), (s, i) -> project.at("stories.#{i}")
			console.log 'nothing'
			

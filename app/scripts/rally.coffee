angular.module('rally.config', []).value('rally.config', {})
angular.module('rally.ui', ['rally.config'])
angular.module('rally.editors', ['rally.ui', 'rally.config'])
angular.module('rally', ['rally.ui', 'rally.editors', 'rally.config'])

ui = angular.module('rally.ui')
ui.directive 'focus', ['$parse', 
	($parse) ->
		return (scope, element, attr) ->
			fn = $parse(attr['focus']);
			element.bind 'focus', (event) ->
				scope.$apply () ->
					fn(scope, {$event:event})
  	]
 
ui.directive 'blur', ['$parse', 
	($parse) ->
		return (scope, element, attr) ->
			fn = $parse(attr['blur']);
			element.bind 'blur', (event) ->
				scope.$apply () ->
					fn(scope, {$event:event})
  	]

editors = angular.module('rally.editors')
editors.directive 'inlineEdit', ($timeout) ->
	return {
	    scope: {
	      model: '=inlineEdit',
	      handleSave: '&onSave',
	      handleCancel: '&onCancel'
	    }
	    link: (scope, elm, attr) ->
	      previousValue = null
	      
	      scope.edit = () ->
	        scope.editMode = true;
	        previousValue = scope.model;
	        
	        find = () ->
	        	elm.find('input')[0].focus();
	        $timeout(find, 0, false)
	      
	      scope.save = () ->
	        scope.editMode = false;
	        scope.handleSave({value: scope.model});
	     
	      scope.cancel = () ->
	        scope.editMode = false;
	        scope.model = previousValue;
	        scope.handleCancel({value: scope.model});
	      
	    templateUrl: '/views/editors/inline.html'
	}

editors.directive 'onEsc', () ->
	return (scope, elm, attr) ->
    	elm.bind 'keydown', (e) ->
      		if e.keyCode is 27
        		scope.$apply(attr.onEsc)
        	
editors.directive 'onEnter', () ->
	return (scope, elm, attr) ->
    	elm.bind 'keypress', (e) ->
      		if e.keyCode is 13
        		scope.$apply(attr.onEnter)

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
				#scope.$apply () ->
				#	fn(scope, {$event:event})
  	]
 
ui.directive 'blur', ['$parse', 
	($parse) ->
		return (scope, element, attr) ->
			fn = $parse(attr['blur']);
			element.bind 'blur', (event) ->
				#scope.$apply () ->
				#	fn(scope, {$event:event})
  	]

editors = angular.module('rally.editors')
editors.directive 'inlineEdit', ($timeout, uuid4) ->
	return {
	    scope: {
	      model: '&inlineEdit'
	      handleSave: '&onSave'
	      handleCancel: '&onCancel'
	    }
		link: (scope, elm, attr) ->
			uuid = uuid4.generate()
			scope.model = scope.model() # it should be an expression like something.at('path')
			scope.value = scope.model.get()
			
			input = elm.find('input')[0]
			previous = scope.value
			pause = false
			scope.$watch 'value', (newValue, oldValue) ->
				if newValue isnt oldValue
					if not pause 
						applyChange scope.model, oldValue, newValue
					pause = false					
#					op = () ->
#						debugger
#					setTimeout(op, 0);
					
			
			scope.model.on 'change', () ->
				debugger
				passed = arguments[arguments.length-1]
				if passed.source is uuid
					debugger
					return
				if scope.value isnt scope.model.get()
					pause = true
					scope.value = scope.model.get()
#				op = () ->
#					debugger
#				setTimeout(op, 0);
					
			
			applyChange = (model, previous, value) ->
				if previous is value then return;
				start = 0;
				while (previous.charAt(start) == value.charAt(start))
					start++;

				end = 0;
				end++ while previous.charAt(previous.length - 1 - end) is value.charAt(value.length - 1 - end) && end + start < previous.length && end + start < value.length

				if previous.length isnt start + end 
					howMany = previous.length - start - end;
					model.pass({source: uuid}).stringRemove(start, howMany);

				if value.length isnt start + end 
					inserted = value.slice(start, value.length - end);
					model.pass({source: uuid}).stringInsert(start, inserted);
			
			scope.edit = () ->
				scope.editMode = true;
				previousValue = scope.model;
				find = () ->
					input.focus();
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

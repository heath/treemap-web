if document.readyState isnt 'complete'
  angular.element(document).ready ->
    angular.bootstrap document, [ 'app' ]
else
  angular.bootstrap document, [ 'app' ]

app = angular.module "app"

app.config [
  "$stateProvider", "$urlRouterProvider",
  ($stateProvider, $urlRouterProvider) ->

    $stateProvider
      .state "map",
        url: "/"
        controller: "MapCtrl"
        templateUrl: "/components/map/index.html"

      $urlRouterProvider.otherwise "/"
]
.run [ '$rootScope', '$state', '$stateParams', ($rootScope, $state, $stateParams) ->
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams
]

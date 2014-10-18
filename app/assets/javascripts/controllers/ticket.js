ngApp.controller('ticket', ['$scope', 'api', '$routeParams', function ($scope, api, $routeParams) {
  api.tickets.show($routeParams.uid).success(function (data) {
    $scope.ticket = data;
  });
}]);

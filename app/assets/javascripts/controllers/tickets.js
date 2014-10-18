ngApp.controller('tickets', ['$scope', 'api', function ($scope, api) {
  api.tickets.index().success(function (data) {
    $scope.tickets = data;
  });
}]);

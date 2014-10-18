ngApp.controller('newTicket', ['$scope', 'api', '$location', function ($scope, api, $location) {
  $scope.submit = function () {
    api.tickets.create({
      ticket: $scope.ticket,
      customer: $scope.customer
    }).success(function (data) {
      $location.path('/tickets/' + data.uid);
    });
  };
}]);

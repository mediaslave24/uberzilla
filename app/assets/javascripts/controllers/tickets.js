ngApp.controller('tickets', ['$scope', 'api', function ($scope, api) {
  function loadTickets() {
    api.tickets.index().success(function (data) {
      $scope.tickets = data;
    });
  }

  $scope.loadTickets = loadTickets;

  $scope.destroy = function (ticket) {
    return api.tickets.destroy(ticket.uid).success(loadTickets);
  };
}]);

ngApp.controller('tickets', [
    '$scope',
    'api',
    '$routeParams',
    function ($scope, api, $routeParams) {

  function loadTickets() {
    api.tickets.index({
      'filter[status_id]': $routeParams.status,
      'filter[subject]': $routeParams.subject
    }).success(function (data) {
      $scope.tickets = data;
    });
  }

  $scope.loadTickets = loadTickets;

  $scope.destroy = function (ticket) {
    return api.tickets.destroy(ticket.uid).success(loadTickets);
  };
}]);

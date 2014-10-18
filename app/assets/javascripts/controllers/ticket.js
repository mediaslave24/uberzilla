ngApp.controller('ticket', ['$scope', 'api', '$routeParams', function ($scope, api, $routeParams) {
  function loadTicket() {
    return api.tickets.show($routeParams.uid).success(function (data) {
      $scope.ticket = data;
    });
  }

  function updateTicket() {
    return api.tickets.update($scope.ticket.uid, {ticket: {
      staff_id: $scope.ticket.staff_id,
      staff_type: _.find($scope.staffs, {id: $scope.ticket.staff_id}).type,
      status_id: $scope.ticket.status_id
    }});
  }

  $scope.$watch('ticket', function (ticket) {
    return ticket && ticket.uid && updateTicket();
  }, true);

  $scope.loadTicket = loadTicket;
}]);

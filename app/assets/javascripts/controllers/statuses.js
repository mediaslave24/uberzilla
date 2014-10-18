ngApp.controller('statuses', ['$scope', 'api', function ($scope, api) {
  function loadStatuses() {
    return api.ticketStatuses.index().success(function (data) {
      $scope.ticketStatuses = data;
    });
  }

  $scope.destroy = function (status) {
    return api.ticketStatuses.destroy(status.id).success(loadStatuses);
  };

  $scope.makeDefault = function (status) {
    return api.ticketStatuses.update(status.id, {ticket_status: {default: true}}).success(loadStatuses);
  };

  $scope.create = function () {
    return api.ticketStatuses.create($scope.newStatus).success(loadStatuses);
  };

  $scope.loadStatuses = loadStatuses;
}]);

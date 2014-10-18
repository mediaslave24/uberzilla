ngApp.controller('ticket', [
    '$scope',
    'api',
    '$routeParams',
    'currentUser',
    function ($scope, api, $routeParams, currentUser) {

  var nilObject = {name: "Unknown"};

  function loadChangelog() {
    return api.tickets.memberPath($scope.ticket.uid, 'changelog').success(function (data) {
      $scope.changelog = data;
      $scope.formattedChangelog = formatChangelog(data);
    });
  }

  function loadTicket() {
    return api.tickets.show($routeParams.uid).success(function (data) {
      $scope.ticket = data;
    }).success(loadChangelog);
  }

  function updateTicket() {
    var staff = _.find($scope.staffs, {id: $scope.ticket.staff_id});
    return api.tickets.update($scope.ticket.uid, {ticket: {
      staff_id: $scope.ticket.staff_id,
      staff_type: (staff || {}).type,
      status_id: $scope.ticket.status_id
    }});
  }

  function takeOwnerShip() {
    $scope.ticket.staff_id = currentUser.id;
    $scope.ticket.staff_type = currentUser.type;
    updateTicket().success(loadTicket);
  }

  function formatChangelog(changelog) {
    return _.chain($scope.changelog)
      .map(function (log, index) {
        var responses = [];

        if (index === 0) {
          responses.push({
            time: log.updated_at[1], message: 'Created the ticket'
          });
          return responses;
        }

        if (log.staff_id && log.staff_id[0] !== log.staff_id[1]) {
          var staff = _.find($scope.staffs, {id: log.staff_id[1]}) || nilObject;
          if (staff) {
            responses.push({
              time: log.updated_at[1], message: 'Changed assignee to ' + staff.name
            });
          }
        }

        if (log.status_id && log.status_id[0] !== log.status_id[1]) {
          var status1 = _.find($scope.ticketStatuses, {
            id: log.status_id[0]
          }) || nilObject,

            status2 = _.find($scope.ticketStatuses, {
              id: log.status_id[1]
            }) || nilObject;

          responses.push({
            time: log.updated_at[1], message: 'Changed ticket status from ' + status1.name + ' to ' + status2.name
          });
        }

        return responses;
    }).flatten().compact().value();
  }

  $scope.$watch('ticket', function (ticket) {
    return ticket && ticket.uid && updateTicket().success(loadTicket);
  }, true);

  $scope.loadTicket = loadTicket;

  $scope.takeOwnerShip = takeOwnerShip;

  $scope.loadChangelog = loadChangelog;
}]);

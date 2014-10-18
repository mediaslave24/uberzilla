ngApp.controller('app', [
    '$location',
    '$rootScope',
    'currentUser',
    'api',
    '$timeout',
    '$scope',
    function ($location, $rootScope, currentUser, api, $timeout, $scope) {

  var ALPHA = '\\w{3}';
  var HEX = '[0-9a-f]{2}';
  var SEARCH_PATTERN = new RegExp('^' + ALPHA + '-' + HEX + '-' + ALPHA + '-' + HEX + '-' + ALPHA + '$');

  function tab(name, path, activeFn) {
    return {
      name: name,
      active: $location.path() === path,
      select: function () {
        return $location.path(path);
      },
      activate: function () {
        this.active = $location.path() === path;
      }
    };
  }

  $rootScope.tabs = [];

  if (!!currentUser.type) {
    $rootScope.tabs.push(
        tab('New ticket', '/')
    );

    if (currentUser.type === 'Admin') {
      $rootScope.tabs.push(
          tab('All Tickets', '/tickets'),
          tab('Staff', '/staffs'),
          tab('Departments', '/departments'),
          tab('Ticket Statuses', '/ticket_statuses')
      );
    }

    $rootScope.tabs.push(tab('Logout', '/logout'));
  }

  if (!window.jasmine) {
    api.departments.index().success(function (data) {
      $rootScope.departments = data;
    });

    api.ticketStatuses.index().success(function (data) {
      $rootScope.ticketStatuses = data;
      if (currentUser.type === 'Staff') {
        _.each(data, function (status) {
          $rootScope.tabs.unshift(tab(status.name, '/tickets/' + status.id));
        });
      }
    });

    api.staffs.index().success(function (data) {
      $rootScope.staffs = data;
    });
  }

  $timeout(function () {
    $rootScope.hideAlerts = true;
  }, 3000);

  $rootScope.loggedIn = !!currentUser.type;

  $scope.doSearch = function () {
    if (SEARCH_PATTERN.test($scope.search)) {
      $location.path('/ticket/' + $scope.search);
    } else {
      $location.path('/tickets-search/' + $scope.search);
    }
  };
}]);

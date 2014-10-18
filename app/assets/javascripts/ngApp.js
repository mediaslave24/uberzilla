window.ngApp = angular.module('app', ['ngRoute', 'ui.bootstrap']);

ngApp.config(['$routeProvider', function ($routeProvider) {
  function logout() {
    location.replace('/logout');
  }

  $routeProvider
    .when('/', {
      controller: 'newTicket',
      templateUrl: '/t/new_ticket'
    })

    .when('/tickets/:uid', {
      controller: 'ticket',
      templateUrl: '/t/ticket'
    })

    .when('/tickets', {
      controller: 'tickets',
      templateUrl: '/t/tickets'
    })

    .when('/staffs', {
      controller: 'staffs',
      templateUrl: '/t/staffs'
    })

    .when('/departments', {
      controller: 'departments',
      templateUrl: '/t/departments'
    })

    .when('/ticket_statuses', {
      controller: 'statuses',
      templateUrl: '/t/statuses'
    })

    .when('/login', { templateUrl: '/t/login' })

    .when('/logout', { controller: logout, template: '' })

    .otherwise({ redirectTo: '/' });
}]);

ngApp.factory('currentUser', function () { return window.currentUser || {}; });

ngApp.run([
    '$location',
    '$rootScope',
    'currentUser',
    'api',
    '$timeout',
    function ($location, $rootScope, currentUser, api, $timeout) {

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
        tab('New ticket', '/'),
        tab('Tickets', '/tickets')
    );

    if (currentUser.type === 'Admin') {
      $rootScope.tabs.push(
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
    });

    if (!!currentUser.type) {
      api.staffs.index().success(function (data) {
        $rootScope.staffs = data;
      });
    }
  }

  $timeout(function () {
    $rootScope.hideAlerts = true;
  }, 3000);
}]);

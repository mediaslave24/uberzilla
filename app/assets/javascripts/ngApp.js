window.ngApp = angular.module('app', ['ngRoute', 'ui.bootstrap', 'angular-loading-bar', 'ngAnimate', 'doowb.angular-pusher']);

ngApp.value('pusherNames', {
  channels: {
    ticket: function (uid) {
      return 'tickets-' + uid;
    }
  },

  events: {
    ticketUpdate: function () { return 'ticket-update'; },
    ticketReply: function () { return 'ticket-reply'; }
  }
});

ngApp.config(['PusherServiceProvider', '$routeProvider', function (PusherServiceProvider, $routeProvider) {
  PusherServiceProvider.setToken('21d0fb09b2120d8d3d6c');

  function logout() {
    location.replace('/logout');
  }

  $routeProvider
    .when('/', {
      controller: 'newTicket',
      templateUrl: '/t/new_ticket'
    })

    .when('/ticket/:uid', {
      controller: 'ticket',
      templateUrl: '/t/ticket'
    })

    .when('/tickets', {
      controller: 'tickets',
      templateUrl: '/t/tickets'
    })

    .when('/tickets/:status', {
      controller: 'tickets',
      templateUrl: '/t/tickets'
    })

    .when('/tickets-search/:subject', {
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

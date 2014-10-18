ngApp.factory('api', ['$http', function ($http) {
  function join() {
    return Array.prototype.join.call(arguments, '');
  }

  function resource(resourceName) {
    return {
      index: function (query) {
        return $http({
          url: join('/', resourceName, '.json'),
          method: 'GET',
          params: query || {}
        });
      },

      show: function (id) {
        return $http({
          url: join('/', resourceName, '/', id, '.json'),
          method: 'GET'
        });
      },

      create: function (params) {
        return $http({
          url: join('/', resourceName, '.json'),
          method: 'POST',
          data: params
        });
      },

      update: function (id, params) {
        return $http({
          url: join('/', resourceName, '/', id, '.json'),
          method: 'PUT',
          data: params
        });
      },

      destroy: function (id) {
        return $http({
          url: join('/', resourceName, '/', id, '.json'),
          method: 'DELETE'
        });
      }
    };
  }

  return {
    tickets: resource('tickets'),
    departments: resource('departments'),
    ticketStatuses: resource('ticket_statuses'),
    users: resource('users'),

    // For testing purposes
    _resource: resource
  };
}]);

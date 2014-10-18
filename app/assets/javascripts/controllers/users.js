ngApp.controller('users', ['$scope', 'api', '$location', '$anchorScroll',  function ($scope, api, $location, $anchorScroll) {
  function loadUsers() {
    api.users.index().success(function (data) {
      $scope.users = data;
    });
  }

  $scope.destroy = function (id) {
    api.users.destroy(id).success(loadUsers);
  };

  $scope.loadUsers = loadUsers;

  $scope.change = function (user) {
    $scope.changeUser = angular.copy(user);
    $location.hash('change-form');
    $anchorScroll();
  };

  $scope.submitChange = function () {
    api.users.update($scope.changeUser.id, $scope.changeUser).success(loadUsers);
    $scope.changeUser = null;
  };
}]);

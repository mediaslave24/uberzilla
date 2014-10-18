ngApp.controller('departments', ['$scope', 'api', function ($scope, api) {
  function loadDepartments() {
    return api.departments.index().success(function (data) {
      $scope.departments = data;
    });
  }

  $scope.destroy = function (department) {
    return api.departments.destroy(department.id).success(loadDepartments);
  };

  $scope.create = function () {
    var department = $scope.newDepartment;
    $scope.newDepartment = null;
    return api
      .departments
      .create(department)
      .success(loadDepartments);
  };

  $scope.loadDepartments = loadDepartments;
}]);

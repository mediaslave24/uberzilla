ngApp.controller('staffs', ['$scope', 'api', function ($scope, api) {
  function loadStaffs() {
    api.staffs.index().success(function (data) {
      $scope.staffs = data;
    });
  }

  $scope.destroy = function (id) {
    api.staffs.destroy(id).success(loadStaffs);
  };

  $scope.loadStaffs = loadStaffs;

  $scope.create = function () {
    var staff = $scope.newStaff;
    $scope.newStaff = null;
    return api.staffs.create({staff: staff}).success(loadStaffs);
  };
}]);

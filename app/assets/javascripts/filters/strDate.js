ngApp.filter('strDate', function () {
  return function(input, format) {
    return moment(input).format(format);
  };
});

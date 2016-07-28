// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

angular.module('bjond-api',[])

.controller('registrationsController', ['$scope', '$http', function ($scope, $http) {

  $scope.result = null;

  $scope.register = function (id) {
    $http.get('/bjond-app/services/register?id=' + id).then(function () {
      alert('Registration Updated with Bjond!');
    }).catch(function (response) {
      alert('Failed to register. Please check logs.');
      console.log(response.data);
    });
  };

}]);
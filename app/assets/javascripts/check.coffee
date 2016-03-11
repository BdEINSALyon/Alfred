# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('app',[]);
app.controller('Participants',['$scope', ($scope) ->
  $scope.participants = window.Participants || [];
  $scope.search = "";
])
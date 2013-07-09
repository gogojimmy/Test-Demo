app = angular.module("Stream", [])

app.controller "StreamCtrl", ($scope, $http) ->
  url = "https://alpha-api.app.net/stream/0/posts/stream/global"
  $http.get(url).success((data, status, headers, config) ->
    $scope.streams = data.data
    $scope.meta = data.meta
  ).error (data, status, headers, config) ->
    console.error "Error fetching stream:", data

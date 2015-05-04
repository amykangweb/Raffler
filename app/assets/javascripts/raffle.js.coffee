app = angular.module('Raffler', ["ngResource"])

app.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

app.factory "Entry", ["$resource", ($resource) ->
  Entry = $resource("/entries/:id", {id: "@id"}, {update: {method: "PUT"}})
  ]

app.controller "RaffleCtrl", ["$scope", "Entry", ($scope, Entry) ->
  $scope.entries = Entry.query()

  $scope.addEntry = ->
    entry = Entry.save($scope.newEntry)
    $scope.entries.push(entry)
    $scope.newEntry = {}

  $scope.deleteEntry = (index) ->
    entry = $scope.entries[index]
    entry.$delete()
    $scope.entries.splice(index, 1)

  $scope.drawWinner = ->
    pool = []
    angular.forEach $scope.entries, (entry) ->
      pool.push(entry) if !entry.winner
    if pool.length > 0
      entry = pool[Math.floor(Math.random()*pool.length)]
      entry.winner = true
      entry.$update()
      $scope.lastWinner = entry
]

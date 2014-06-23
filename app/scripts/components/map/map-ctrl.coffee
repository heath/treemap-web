app = angular.module "app"

app.controller "MapCtrl", [
  "$scope", "$state"
  ($scope, $state) ->

    map = L.map("map").setView [35.95, -86.805540], 8
    markerLayerGroup = L.layerGroup().addTo map

    L.tileLayer "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
      maxZoom: 18
    .addTo map

    getPins = (e) ->
      bounds = map.getBounds()
      url = "http://localhost:3000/trees/"
      $.get url, setPins, "json"
      return

    setPins = (tree) ->
      # clear current pins
      map.removeLayer markerLayerGroup
      # add new pins
      markerArray = []
      trees.forEach (tree, i) ->
        markerArray[i] = L.marker([tree.pos[1], tree.pos[0]]).bindPopup tree.common
      markerLayerGroup = L.layerGroup(markerArray).addTo map
      return

    map.on "dragend", getPins
    map.on "zoomend", getPins
    map.whenReady getPins
    return
]

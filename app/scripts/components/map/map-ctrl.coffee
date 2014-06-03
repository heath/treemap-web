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
      url = "http://localhost:3000/trees/within?lat1=#{bounds.getNorthEast().lat}\
            &lon1=#{bounds.getNorthEast().lng}\
            &lat2=#{bounds.getSouthWest().lat}\
            &lon2=#{bounds.getSouthWest().lng}"
      $.get url, setPins, "json"
      return

    setPins = (data) ->
      # clear current pins
      map.removeLayer markerLayerGroup
      # add new pins
      markerArray = []
      parks.forEach (park, i) ->
        markerArray[i] = L.marker([park.pos[1], park.pos[0]]).bindPopup park.Name
      markerLayerGroup = L.layerGroup(markerArray).addTo map
      return

    map.on "dragend", getPins
    map.on "zoomend", getPins
    map.whenReady getPins
    return
]

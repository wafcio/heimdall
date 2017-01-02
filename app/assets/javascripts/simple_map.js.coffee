class SimpleMap
  constructor: ->
    @lat = $("#simple-map").data("lat") || ""
    @lng = $("#simple-map").data("lng") || ""

    @map = new google.maps.Map(document.getElementById("simple-map"), {
      center: {lat: parseFloat(@lat), lng: parseFloat(@lng)},
      zoom: 10
    });

    if(@lat != "" && @lng != "")
      marker = new google.maps.Marker({
        position: { lat: parseFloat(@lat), lng: parseFloat(@lng) },
        map: @map,
        draggable: true
      });

window.initSimpleMap = ->
  if $("#simple-map")
    new SimpleMap()

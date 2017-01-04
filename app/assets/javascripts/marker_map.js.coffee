class MarkerMap
  constructor: ->
    @componentForm =
      street_number: "short_name"
      route: "long_name"
      locality: "long_name"
      administrative_area_level_1: "long_name"
      country: "long_name"
      postal_code: "short_name"
    @markers = []
    @geocoder = new google.maps.Geocoder

    # draw map
    $("#map").css({height: 400});
    @map = new google.maps.Map(document.getElementById("map"), {
      center: {lat: 52.05, lng: 19.45},
      zoom: 6
    });

    # init autocomplete
    @autocomplete = new (google.maps.places.Autocomplete)($("#autocomplete")[0], types: ["geocode"])
    @autocomplete.addListener("place_changed", @fillInAddress)

    # add initial marker
    lat = $("[data-address=\"latitude\"]").val()
    lng = $("[data-address=\"longitude\"]").val()

    if(lat != "" && lng != "")
      @addMarker(parseFloat(lat), parseFloat(lng))

  addMarker: (lat, lng) ->
    marker = new google.maps.Marker({
      position: { lat: lat, lng: lng },
      map: @map,
      draggable: true
    });

    google.maps.event.addListener(marker, "dragend", (event) =>
      latlng =
        lat: event.latLng.lat()
        lng: event.latLng.lng()

      @geocoder.geocode { "location": latlng }, (results, status) =>
        if status == "OK"
          if results[0]
            @clearAddressFields()
            @updateAddressFields(results[0], latlng.lat, latlng.lng)
          else
            window.alert "No address found"
        else
          window.alert "Geocoder failed due to: " + status
    )

    @markers.push(marker);

  fillInAddress: =>
    place = @autocomplete.getPlace()

    # clear markers
    i = 0
    while(i < @markers.length)
      @markers[i].setMap(null)
      i++
    @markers.length = 0

    @addMarker(place.geometry.location.lat(), place.geometry.location.lng())
    @clearAddressFields()
    @updateAddressFields(place, place.geometry.location.lat(), place.geometry.location.lng())

  clearAddressFields: ->
    for component of @componentForm
      if $("[data-address=\"" + component + "\"]")
        $("[data-address=\"" + component + "\"]").val("")

  updateAddressFields: (data, lat, lng) ->
    i = 0
    while i < data.address_components.length
      addressType = data.address_components[i].types[0]
      if @componentForm[addressType]
        val = data.address_components[i][@componentForm[addressType]]
        if $("[data-address=\"" + addressType + "\"]")
          $("[data-address=\"" + addressType + "\"]").val(val)
      i++

    $("[data-address=\"latitude\"]").val(lat)
    $("[data-address=\"longitude\"]").val(lng)

window.initMarkerMap = ->
  new MarkerMap()

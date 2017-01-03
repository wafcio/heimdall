// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require_tree .

function initMap() {
  resizeMap();

  var map = new google.maps.Map(document.getElementById("map"), {
    zoom: parseInt($("meta[name=mapZoom]").attr("content")),
    center: {
      lat: parseFloat($("meta[name=mapLatitude]").attr("content")),
      lng: parseFloat($("meta[name=mapLongitude]").attr("content")),
    }
  });

  var markers = [];

  $(".marker").each(function() {
    var node = $(this);

    var marker_data = {
      position: { lat: parseFloat(node.attr("data-lat")), lng: parseFloat(node.attr("data-lng")) },
      map: map,
      title: node.attr("data-name")
    };

    if (node.attr("data-marker") != "default")
      marker_data["icon"] = $("meta[name=baseUrl]").attr("content") + node.attr("data-marker");

    var marker = new google.maps.Marker(marker_data);

    var infowindow = new google.maps.InfoWindow({
      content: "<strong style=\"border-bottom: 1px solid #eeeeee;\">" + node.attr("data-name") + "</strong>"
    });

    marker.addListener("click", function() {
      infowindow.open(map, marker);
    });

    markers.push(marker);
  });
}

function resizeMap() {
  $("#map").css({height: window.innerHeight - 51});
}

$(window).resize(function(){
  resizeMap()
});

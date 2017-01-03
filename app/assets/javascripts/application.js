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
//= require slimbox2.min
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

    var markerData = {
      position: { lat: parseFloat(node.attr("data-lat")), lng: parseFloat(node.attr("data-lng")) },
      map: map,
      title: node.attr("data-name")
    };

    if (node.attr("data-marker") != "default")
      if (node.attr("data-marker").startsWith("http")) {
        markerData["icon"] = node.attr("data-marker");
      } else {
        markerData["icon"] = $("meta[name=baseUrl]").attr("content") + node.attr("data-marker");
      }

    var marker = new google.maps.Marker(markerData);

    var content = "<strong style=\"border-bottom: 1px solid #eeeeee;\">" + node.attr("data-name") + "</strong><br>";
    $(".marker-image[data-point-id=" + node.attr("data-id") + "]").each(function(){
      var imageNode = $(this), bigImageUrl, smallImageUrl;
      if (imageNode.attr("data-file").startsWith("http")) {
        bigImageUrl = imageNode.attr("data-file");
      } else {
        bigImageUrl = $("meta[name=baseUrl]").attr("content") + imageNode.attr("data-file");
      }
      if (imageNode.attr("data-file-small").startsWith("http")) {
        smallImageUrl = imageNode.attr("data-file-small");
      } else {
        smallImageUrl = $("meta[name=baseUrl]").attr("content") + imageNode.attr("data-file-small");
      }

      content += "<a href=\"" + bigImageUrl +"\" rel=\"lightbox\"><img src=\"" + smallImageUrl +"\" /></a>"
    });

    var infowindow = new google.maps.InfoWindow({
      content: content
    });

    marker.addListener("click", function() {
      infowindow.open(map, marker);

      // bind lightbox for new DOM
      $("a[rel^='lightbox']").slimbox({/* Put custom options here */}, null, function(el) {
        return (this == el) || ((this.rel.length > 8) && (this.rel == el.rel));
      });
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

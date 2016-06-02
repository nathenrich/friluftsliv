var map

function makeMap(position) {
  getLocation();
  var mapProp = {
    center:new google.maps.LatLng(position.coords.latitude, position.coords.longitude),
    zoom:8,
    mapTypeId:google.maps.MapTypeId.HYBRID,
    disableDefaultUI:true
  };
  map=new google.maps.Map(document.getElementById("googleMap"),mapProp);
  setMarkers(position);
  google.maps.event.addListener(map, 'click', mapClick);
}

function setMarkers(currentpostion){
  createMarker(currentpostion.coords.latitude, currentpostion.coords.longitude)
}

function createMarker(lat, lng){
  var marker=new google.maps.Marker({
    position:new google.maps.LatLng(lat, lng),
    animation:google.maps.Animation.DROP
  });
  marker.setMap(map);
}

function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(makeMap);
  } else {
    console.log("Geolocation is not supported by this browser.");
  }
}

function mapClick(event){
  createMarker(event.latLng.lat(), event.latLng.lng());
  map.panTo(new google.maps.LatLng(event.latLng.lat(), event.latLng.lng()));
}

google.maps.event.addDomListener(window, 'load', getLocation);





var LayerOverlay = function () {
  this.overlays = [];
  this.setMap(map);
}

LayerOverlay.prototype = new google.maps.OverlayView();

LayerOverlay.prototype.addOverlay = function (overlay) {
  this.overlays.push(overlay);
};

LayerOverlay.prototype.updateOverlays = function () {
  for (var i = 0; i < this.overlays.length; i++) {
    this.overlays[i].setMap(this.getMap());
  }
};

LayerOverlay.prototype.draw = function () {};
LayerOverlay.prototype.onAdd = LayerOverlay.prototype.updateOverlays;
LayerOverlay.prototype.onRemove = LayerOverlay.prototype.updateOverlays;

var layer1 = new LayerOverlay();

layer1.addOverlay(createMarker());
layer1.addOverlay(createMarker());
layer1.addOverlay(createMarker());

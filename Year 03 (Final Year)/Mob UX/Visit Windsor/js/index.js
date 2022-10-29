let map;
let map2;
let siteLocation = {lat: 51.484215, lng: -0.603216}

function initMap() {

  const mapOptions = {
    zoom: 15,
    center: siteLocation,
    mapTypeId: 'roadmap'
  };

  map = new google.maps.Map(document.getElementById("map"), mapOptions);

  const marker = new google.maps.Marker({
    position: siteLocation,
    map: map,
  });

  const infowindow = new google.maps.InfoWindow({
    content: "<p>Marker Location:" + marker.getPosition() + "</p>",
  });

  google.maps.event.addListener(marker, "click", () => {
    infowindow.open(map, marker);
  });
  

  // --------------------------- orientation 2 -----------------

  map2 = new google.maps.Map(document.getElementById("map2"), mapOptions);

  const marker2 = new google.maps.Marker({
    position: siteLocation,
    map: map2,
  });

  const infowindow2 = new google.maps.InfoWindow({
    content: "<p>Marker Location:" + marker.getPosition() + "</p>",
  });

  google.maps.event.addListener(marker2, "click", () => {
    infowindow2.open(map2, marker2);
  });
}
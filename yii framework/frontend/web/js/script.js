var map, infoWindow;

function createMap() {
  var options = {
    center: { lat: 46.558853, lng: 15.637981 },
    zoom: 10
  };

  map = new google.maps.Map(document.getElementById("map"), options);

  // ---------------- SEARCH BAR -----------------------
  var input = document.getElementById("search");
  var searchBox = new google.maps.places.SearchBox(input);

  map.addListener("bounds_changed", function() {
    searchBox.setBounds(map.getBounds());
  });

  var markers = [];
  var markersStadiums = [];
  var longitude;

  // For search suggestions
  searchBox.addListener("places_changed", function() {
    // take searched place
    var places = searchBox.getPlaces();

    // if choosen place is not on the list
    if (places.length == 0) return;

    // erase all markers, foreach marker set null
    markers.forEach(function(m) {
      m.setMap(null);
    });
    // delete all markers from array
    markers = [];

    var bounds = new google.maps.LatLngBounds();
    places.forEach(function(p) {
      // if we do not have data for place(lan,lon)
      if (!p.geometry) return;

      // push new marker for our markers array
      markers.push(
        new google.maps.Marker({
          map: map,
          title: p.name,
          position: p.geometry.location,
          draggable: true,
          animation: google.maps.Animation.DROP
        })
      );

      toggleBounce();

      if (p.geometry.viewport) bounds.union(p.geometry.viewport);
      else bounds.extend(p.geometry.location);
    });

    toggleBounce();
    function toggleBounce() {
      if (markers[0].getAnimation() !== null) {
        markers[0].setAnimation(null);
      } else {
        markers[0].setAnimation(google.maps.Animation.BOUNCE);
      }
    }

    map.fitBounds(bounds);

    toggleBounce();

    $.get(
      "index.php?r=game/get-game-json&userlatitude=" +
        markers[0].position.lat() +
        "&userlongitude=" +
        markers[0].position.lng(),
      function(data) {
        bestGame = JSON.parse(data);
        document.getElementById("homeTeam").textContent = bestGame.hometeam;
        document.getElementById("awayTeam").textContent = bestGame.awayteam;
      }
    );
  });

  function displayStadiumsOnMap(country) {
    // erase all markers, foreach marker set null
    markersStadiums.forEach(function(m) {
      m.setMap(null);
    });
    // delete all markers from array
    markersStadiums = [];

    $.get(
      "index.php?r=stadium/stadium-array-json&countryName=" +
        country +
        "&json=true)",
      function(data) {
        stadiumArray = JSON.parse(data);

        var i;
        for (i = 0; i < stadiumArray.length; i++) {
          markersStadiums.push(
            new google.maps.Marker({
              map: map,
              title: stadiumArray[i].street,
              position: {
                lat: parseFloat(stadiumArray[i].latitude),
                lng: parseFloat(stadiumArray[i].longitude)
              }
            })
          );
        }

        // Opening google maps with navigate to stadium
        for (i = 0; i < markersStadiums.length; i++) {
          let stadiumChosen = markersStadiums[i];
          markersStadiums[i].addListener("click", function() {
            $lonUser = markers[0].getPosition().lat();
            $lngUser = markers[0].getPosition().lng();
            $lonStadium = stadiumChosen.getPosition().lat();
            $lngStadium = stadiumChosen.getPosition().lng();
            window.open(
              " https://www.google.pl/maps/dir/'" +
                $lonUser +
                "," +
                $lngUser +
                "'/'" +
                $lonStadium +
                "," +
                $lngStadium +
                "'",
              "_blank"
            );
          });
        }

        // for (i = 0; i < markersStadiums.length; i++){ (function() {
        //   markersStadiums[i].addListener('click', function(){
        //     window.alert(i);
        //    // window.open("index.php?r=stadium%2Findex","_self")
        //   // window.alert(document.getElementById('latlngform-latitude').value);
        //    window.alert( markers[i].getPosition().lat());
        //     //window.alert("hello");
        //     //$lonUser = 46;
        //    // $lngUser = 15;
        //    $lonUser = markers[0].getPosition().lat();
        //    $lngUser = markers[0].getPosition().lng();
        //    //$lonStadium = markersStadiums[i].getPosition().lat();
        //   // $lngStadium = markersStadiums[i].getPosition().lng();
        //    //window.open(" https://www.google.pl/maps/dir/'"+$lonUser+","+$lngUser+"'/'"+$lonStadium+","+$lngStadium+"'","_blank");
        //  });
        // }());

        // setting right bounds
        var bounds = new google.maps.LatLngBounds();

        bounds.extend({
          lat: parseFloat(stadiumArray[1].latitude),
          lng: parseFloat(stadiumArray[1].longitude)
        });

        map.setCenter(bounds.getCenter());

        zoomChangeBoundsListener = google.maps.event.addListenerOnce(
          map,
          "bounds_changed",
          function(event) {
            if (this.getZoom()) {
              // or set a minimum
              this.setZoom(6); // set zoom here
            }
          }
        );

        setTimeout(function() {
          google.maps.event.removeListener(zoomChangeBoundsListener);
        }, 2000);
      }
    );
  }

  // ------------------------- Button Show stadiums --------------------------------
  document
    .getElementById("showAllStadiums")
    .addEventListener("click", function() {
      displayStadiumsOnMap("Austria");
      displayStadiumsOnMap("Slovenia");
    });

  document
    .getElementById("showSloviniaStadiums")
    .addEventListener("click", function() {
      displayStadiumsOnMap("Slovenia");
    });

  document
    .getElementById("showAustrianStadiums")
    .addEventListener("click", function() {
      displayStadiumsOnMap("Austria");
    });
  // ------------------------- Button Show stadiums --------------------------------
}

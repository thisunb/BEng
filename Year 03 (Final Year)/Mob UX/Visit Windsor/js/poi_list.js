var data = [
  { picture: "windor-castle-gardens-landscape", name: "Windsor Castle Gardens", description: "The garden located in Windsor castle.", rating: parseFloat(localStorage.getItem("poi1-rating")).toFixed(1), url: "poi1_windsor_castle_gardens.html" },
  { picture: "albert-memorial-chapel-landscape", name: "Albert Memorial Chapel", description: "Built by Henry VII as a royal mansoleum.", rating: parseFloat(localStorage.getItem("poi2-rating")).toFixed(1), url: "poi2_albert_memorial_chapel.html" },
  { picture: "great-home-parks-landscape", name: "Great & Home Parks", description: "Two beautiful parks located in the Site.", rating: parseFloat(localStorage.getItem("poi3-rating")).toFixed(1), url: "poi3_great_home_parks.html" },
  { picture: "curfew-tower-landscape", name: "The Towers", description: "Two towers namely, Curfew & Round.", rating: parseFloat(localStorage.getItem("poi4-rating")).toFixed(1), url: "poi4_towers.html" },
  { picture: "waterloo-chamber-landscape", name: "Waterloo Chamber", description: "A large room dedicated to Napolean.", rating: parseFloat(localStorage.getItem("poi5-rating")).toFixed(1), url: "poi5_waterloo_chamber.html" },
  { picture: "queens-marys-dolls-house-landscape", name: "Queen Mary's Doll's House", description: "A Dollhouse built in early 1920s.", rating: parseFloat(localStorage.getItem("poi6-rating")).toFixed(1), url: "poi6_queen_mary_doll_house.html" },
  { picture: "change-the-guard-landscape", name: "Change The Guard", description: "Ceremony of soldiers in Buckingham palace.", rating: parseFloat(localStorage.getItem("poi7-rating")).toFixed(1), url: "poi7_change_the_guard.html" },
  { picture: "st.georges-chapel-landscape", name: "St. George's Chapel", description: "A chapel located in Lower ward of the castle.", rating: parseFloat(localStorage.getItem("poi8-rating")).toFixed(1), url: "poi8_st_george_chapel.html" },
  { picture: "semi-state-rooms-landscape", name: "Semi - State Rooms", description: "Private apartments created for George IV.", rating: parseFloat(localStorage.getItem("poi9-rating")).toFixed(1), url: "poi9_semi_state_rooms.html" },
  { picture: "state-apartments-landscape", name: "State Apartments", description: "A large scale version of semi-state rooms. ", rating: parseFloat(localStorage.getItem("poi10-rating")).toFixed(1), url: "poi10_state_apartments.html" }
];

function updateListview(sorting) {
  var direction = ~sorting.indexOf("-asc") ? 1 : -1;
  data.sort(function (a, b) {
    return direction * (Number(a.rating) - Number(b.rating));
  });

  var html = "";
  $.each(data, function (index, item) {
    html += '<li class="list-item" "' + item.category + '">';
    html += '<div style="image-container">'
    html += '<img id="image" src="Materials/landscape/' + item.picture + '.png">';
    html += '</div>'
    html += '<h4 class="item-name">' + item.name + '</h4>';
    html += '<div class="item-description">'
    html += '<p id="item-des">' + item.description + '</p>';
    html += '</div>'
    html += '<div class="rating-section">'
    html += '<p id="rate-text" class="rating">' + item.rating + '</p>';
    html += '<img id="star-icon" src="Materials/icons/stars/star.png">';
    html += '</div>';
    html += '</li>';
  });

  $("#food").data("sort", sorting).empty().html(html).listview("refresh");
}

$(document).on("listviewcreate", "#food", function (event, ui) {
  $("#rating-sort").on("vclick", function (e) {
    var sorting = $("#food").data("sort") == "rating-asc" ? "rating-desc" : "rating-asc";
    updateListview(sorting);
  });
});

$(document).on("pagecreate", "#page", function () {
  updateListview("none");
});

// Reload page when back button clicked

$(document).ready(function () {

  window.addEventListener( "pageshow", function ( event ) {
      var historyTraversal = event.persisted || ( typeof window.performance != "undefined" && window.performance.navigation.type === 2 );
      if ( historyTraversal ) {
        // Handle page restore.
        //alert('refresh');
        window.location.reload();
      }
    });
  });
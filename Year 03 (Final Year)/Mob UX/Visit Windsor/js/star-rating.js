// Input rating

var selection = 0;
var clickStar1 = 0;
$(document).ready(function () {
    $("#rate-star-1").click(function () {

        if (clickStar1 % 2 == 0) {
            $(clickStar1++);

            $("#star1").attr("src", "Materials/icons/stars/star.png");
            $("#star2").attr("src", "Materials/icons/stars/blank star.png");
            $("#star3").attr("src", "Materials/icons/stars/blank star.png");
            $("#star4").attr("src", "Materials/icons/stars/blank star.png");
            $("#star5").attr("src", "Materials/icons/stars/blank star.png");

            selection = 1;

        }
        else {
            $(clickStar1++);

            $("#star1").attr("src", "Materials/icons/stars/blank star.png");
            $("#star2").attr("src", "Materials/icons/stars/blank star.png");
            $("#star3").attr("src", "Materials/icons/stars/blank star.png");
            $("#star4").attr("src", "Materials/icons/stars/blank star.png");
            $("#star5").attr("src", "Materials/icons/stars/blank star.png");

            selection = 0;
        }
    });
});

var clickStar2 = 0;
$(document).ready(function () {
    $("#rate-star-2").click(function () {
        if (clickStar2 % 2 == 0) {
            $(clickStar2++);

            $("#star1").attr("src", "Materials/icons/stars/star.png");
            $("#star2").attr("src", "Materials/icons/stars/star.png");
            $("#star3").attr("src", "Materials/icons/stars/blank star.png");
            $("#star4").attr("src", "Materials/icons/stars/blank star.png");
            $("#star5").attr("src", "Materials/icons/stars/blank star.png");

            selection = 2;
        }
        else {
            $(clickStar2++);

            $("#star1").attr("src", "Materials/icons/stars/blank star.png");
            $("#star2").attr("src", "Materials/icons/stars/blank star.png");
            $("#star3").attr("src", "Materials/icons/stars/blank star.png");
            $("#star4").attr("src", "Materials/icons/stars/blank star.png");
            $("#star5").attr("src", "Materials/icons/stars/blank star.png");

            selection = 0;
        }
    });
});

var clickStar3 = 0;
$(document).ready(function () {
    $("#rate-star-3").click(function () {

        if (clickStar3 % 2 == 0) {
            $(clickStar3++);

            $("#star1").attr("src", "Materials/icons/stars/star.png");
            $("#star2").attr("src", "Materials/icons/stars/star.png");
            $("#star3").attr("src", "Materials/icons/stars/star.png");
            $("#star4").attr("src", "Materials/icons/stars/blank star.png");
            $("#star5").attr("src", "Materials/icons/stars/blank star.png");

            selection = 3;
        }
        else {
            $(clickStar3++);

            $("#star1").attr("src", "Materials/icons/stars/blank star.png");
            $("#star2").attr("src", "Materials/icons/stars/blank star.png");
            $("#star3").attr("src", "Materials/icons/stars/blank star.png");
            $("#star4").attr("src", "Materials/icons/stars/blank star.png");
            $("#star5").attr("src", "Materials/icons/stars/blank star.png");

            selection = 0;
        }
    });
});

var clickStar4 = 0;
$(document).ready(function () {
    $("#rate-star-4").click(function () {

        if (clickStar4 % 2 == 0) {
            $(clickStar4++);

            $("#star1").attr("src", "Materials/icons/stars/star.png");
            $("#star2").attr("src", "Materials/icons/stars/star.png");
            $("#star3").attr("src", "Materials/icons/stars/star.png");
            $("#star4").attr("src", "Materials/icons/stars/star.png");
            $("#star5").attr("src", "Materials/icons/stars/blank star.png");

            selection = 4;
        }
        else {
            $(clickStar4++);

            $("#star1").attr("src", "Materials/icons/stars/blank star.png");
            $("#star2").attr("src", "Materials/icons/stars/blank star.png");
            $("#star3").attr("src", "Materials/icons/stars/blank star.png");
            $("#star4").attr("src", "Materials/icons/stars/blank star.png");
            $("#star5").attr("src", "Materials/icons/stars/blank star.png");

            selection = 0;
        }
    });
});

var clickStar5 = 0;
$(document).ready(function () {
    $("#rate-star-5").click(function () {

        if (clickStar5 % 2 == 0) {
            $(clickStar5++);

            $("#star1").attr("src", "Materials/icons/stars/star.png");
            $("#star2").attr("src", "Materials/icons/stars/star.png");
            $("#star3").attr("src", "Materials/icons/stars/star.png");
            $("#star4").attr("src", "Materials/icons/stars/star.png");
            $("#star5").attr("src", "Materials/icons/stars/star.png");

            selection = 5;
        }
        else {
            $(clickStar5++);

            $("#star1").attr("src", "Materials/icons/stars/blank star.png");
            $("#star2").attr("src", "Materials/icons/stars/blank star.png");
            $("#star3").attr("src", "Materials/icons/stars/blank star.png");
            $("#star4").attr("src", "Materials/icons/stars/blank star.png");
            $("#star5").attr("src", "Materials/icons/stars/blank star.png");

            selection = 0;
        }
    });
});


//  Choose POI 

var path = window.location.pathname;
var poi = (path.split("/").pop()).split("_")[0];
console.log(poi);

var poiRatingVarName = poi + '-rating';
var poiViewsVarName = poi + '-views';


//  Set initial rating


if (!localStorage.getItem(poiRatingVarName)) {
    localStorage.setItem(poiRatingVarName, 5);
}

if (!localStorage.getItem(poiViewsVarName)) {
    localStorage.setItem(poiViewsVarName, 5);
}

var rateText = parseFloat(localStorage.getItem(poiRatingVarName));

console.log(rateText);

$(document).ready(function () {
    $('#rate-text').text(rateText.toFixed(1));
    $('#rate-text2').text(rateText.toFixed(1));

});

ratingPoi = 0;
viewsPoi = 0;

$(document).ready(function () {
    $("#rate").click(function () {

        if (selection != 0) {

            ratingPoi = parseFloat(window.localStorage.getItem(poiRatingVarName));
            viewsPoi = parseFloat(window.localStorage.getItem(poiViewsVarName));

            console.log("old rating - " + ratingPoi);
            console.log("old views - " + viewsPoi);

            var currentTotalRating = ratingPoi * viewsPoi;

            console.log("currentTotalRating - " + currentTotalRating);


            var totalViews = viewsPoi + 1;

            console.log("totalViews - " + totalViews);

            var totalRating = currentTotalRating + selection;

            console.log("totalRating - " + totalRating);

            ratingPoi = (totalRating / totalViews);

            window.localStorage.setItem(poiRatingVarName, parseFloat(ratingPoi));
            window.localStorage.setItem(poiViewsVarName, totalViews);

            console.log("updated rating - " + ratingPoi);

            $('#rate-text').text(ratingPoi.toFixed(1));
            $('#rate-text2').text(ratingPoi.toFixed(1));

            $('#alert-text').text("Thanks for the rating!");
            $('#alert-text')[0].focus()
            $("#alert").css({ "visibility": "visible" });
            $("#page").css({ "opacity": "0.7", "pointer-events": "none" })
        }
        else {
            $('#alert-text').text("Click stars for rating!");
            $('#alert-text')[0].focus()
            $("#alert").css({ "visibility": "visible" });
            $("#page").css({ "opacity": "0.7", "pointer-events": "none" })
        }
    });
});


// Set ratings for poi ratings page 

$(document).ready(function () {

    var poi = poi + '-rating';

    for (var i = 1; i < 11; i++) {
        var poiName = "poi" + i + "-rating"

        var poiSetTextName = "#rate-poi" + i
        var poiSetTextName2 = "#rate-poi" + i + i

        var poiRating = parseFloat(localStorage.getItem(poiName))

        $(poiSetTextName).text(poiRating.toFixed(1));
        $(poiSetTextName2).text(poiRating.toFixed(1));
    }
});


//  Set initial rating for poi

$(document).ready(function () {

    var poiName = "poi" + '-rating';

    for (var i = 1; i < 11; i++) {
        var poiName = poi + i + '-rating';

        if (!localStorage.getItem(poiName)) {
            localStorage.setItem(poiName, 5);
        }
    }
});

// Reload page when back button clicked

$(document).ready(function () {

    window.addEventListener("pageshow", function (event) {
        var historyTraversal = event.persisted || (typeof window.performance != "undefined" && window.performance.navigation.type === 2);
        if (historyTraversal) {
            // Handle page restore.
            //alert('refresh');
            window.location.reload();
        }
    });
});
//  Get POI Name

var path = window.location.pathname;
var poi = (path.split("/").pop()).split("_")[0];
console.log(poi);


// Create local storage & transfer existing stored data to list

var list = [];

$(document).ready(function () {
    // localStorage.clear();
    if (JSON.parse(window.localStorage.getItem("fav"))) {

        for (var i of JSON.parse(window.localStorage.getItem("fav"))) {
            list.push(i);
        }
    }
    else {
        window.localStorage.setItem("fav", JSON.stringify(list))
    }
});


// Add to favourites

$(document).ready(function () {
    $("#favourites-btn").click(function () {

        var top = (window.scrollY + document.querySelector('#favourites-btn').getBoundingClientRect().top).toFixed(0)

        console.log(top)

        if ($.inArray(poi, list) == -1) {
            list.push(poi)
            window.localStorage.setItem("fav", JSON.stringify(list))

            $('#alert-text').text("Added to favourites!");
            $('#alert-text')[0].focus()
            $("#alert").css({ "visibility": "visible" });
            $("#page").css({ "opacity": "0.7", "pointer-events": "none" })
        }
        else {
            $('#alert-text').text("Already added to favourites!");
            $("#alert").css({ "visibility": "visible" });
            $("#page").css({ "opacity": "0.7", "pointer-events": "none" })
        }
        console.log("Favourites list - " + list)
    });
});


// Retrieve favourites

var scroll = ""
var scroll2 = ""

$(document).ready(function () {

    if (list.length > 0) {
        $('#message-text').text("Your Favourite POIs are highlighted here!");
    }

    console.log(list)

    var poiNumberList = []

    for (var i = 0; i < list.length; i++) {
        // var poiId = "#" + list[i]
        var imgId = "#img" + list[i].split("poi").pop()
        var remPoiName = "#poi" + list[i].split("poi").pop() + "-rem"
        $(imgId).css({ "filter": "none", "opacity": "1" });
        $(remPoiName).css({ "opacity": "1" });

        // var poiId2 = "#" + list[i] + list[i].split("poi").pop()
        var imgId2 = "#img" + list[i].split("poi").pop() + list[i].split("poi").pop()
        var remPoiName2 = "#poi" + list[i].split("poi").pop() + list[i].split("poi").pop() + "-rem"
        $(imgId2).css({ "filter": "none", "opacity": "1" });
        $(remPoiName2).css({ "opacity": "1" });

        console.log("remPoiName2 - " + remPoiName2)

        poiNumberList.push(list[i].split("poi").pop())
    }

    scroll = "#poi" + Math.min.apply(Math, poiNumberList)
    scroll2 = "#poi" + Math.min.apply(Math, poiNumberList) + Math.min.apply(Math, poiNumberList)
});


//  Scroll to favourite pois in page

$(document).ready(function () {

    var pageName = (window.location.pathname.split("/").pop())

    if (pageName == "favourites.html") {

        console.log("page name - " + pageName)
        console.log("scroll - " + scroll)
        console.log("scroll 2 - " + scroll2)
    }
});


// Identify iphone landscape poi names (ids)

function identify(poiname2) {

    len = poiname2.length

    if (len == 5 && poiname2 != "poi10") {
        var newPoiName2 = poiname2.slice(0, -1)
        console.log("New poi name - " + newPoiName2)
        return newPoiName2
    }

    if (len == 7) {
        var newPoiName2 = poiname2.slice(0, poiname2.lastIndexOf("10"));
        console.log("New POI Name 2 - " + newPoiName2)
        return newPoiName2
    }
}

// Remove favourites

$(document).ready(function () {

    $(".top_remove_square").click(function () {
        clickedPoi = this.id;
        var selectedPoi = clickedPoi.split("-rem")[0]

        console.log("selected poi - " + selectedPoi)

        if (jQuery.inArray(selectedPoi, list) != -1) {

            list = $.grep(list, function (value) {
                return value != selectedPoi;
            });
        }

        if (jQuery.inArray(identify(selectedPoi), list) != -1) {

            list = $.grep(list, function (value) {
                return value != identify(selectedPoi);
            });
        }
        console.log("list - " + list)
        window.localStorage.setItem("fav", JSON.stringify(list))
        location.reload();
    });
});


// Email favourites

$(document).ready(function () {

    $("#email-favourites-btn").click(function () {

        var favList = []
        var bodyText = []

        for (var i of JSON.parse(window.localStorage.getItem("fav"))) {
            favList.push(getPoiName(i));
        }

        if (favList.length == 0) {
            displayAlert("You have not added any POIs as favourites!")
        }
        else {
            var favEmail = localStorage.getItem("email")

            if (favEmail == null) {
                displayAlert("Please login to send favourites!")
            }
            else {
                bodyText.push(
                    "<html>",
                    "<body>",
                    "<p><strong>Your favourite POIs are listed Below. Hope to see you at Windsor!</strong></p>",
                    "<br>"
                )

                for (var i of favList) {
                    bodyText.push(
                        "<div style='text-align:center'>",
                        "<p style='background-color:black; padding:10px; color:white'> <strong>" + i["name"] + "</strong></p>",
                        "<img style='object-fit:cover;' width='50%' height='50%' src=" + i["imgLink"] + "/>",
                        "</div>"
                    )
                }

                bodyText.push(
                    "</body>",
                    "</html>"
                )

                var finalBodyText = bodyText.join("")

                Email.send({
                    Host: "smtp.elasticemail.com",
                    Username: "visitwindsornow@gmail.com",
                    Password: "0F10D1733098A4AC64CAD14B6A942DADC859",
                    To: favEmail,
                    From: "visitwindsornow@gmail.com",
                    Subject: "Favourite POIs @ Windsor Castle",
                    Body: finalBodyText
                }).then(
                    message => {
                        if (message == "OK") {
                            displayAlert("Favourites have been emailed successfully!")
                        }
                        else {
                            displayAlert("Unknown error occured!")
                            console.log("Mail server - " + message)
                        }
                    }
                );
            }
        }
    });
});

function getPoiName(index) {
    if (index == "poi1") {
        return {
            "name": "Windsor Castle Gardens",
            "imgLink": "https://i.ibb.co/r271QsL/windsor-castle-gardens.png"
        }
    }
    else if (index == "poi2") {
        return {
            "name": "Albert Memorial Chapel",
            "imgLink": "https://i.ibb.co/LtX4x8Y/albert-memorial-chapel.png"
        }
    }
    else if (index == "poi3") {
        return {
            "name": "Great & Home Parks",
            "imgLink": "https://i.ibb.co/m5X20VG/great-home-parks.png"
        }
    }
    else if (index == "poi4") {
        return {
            "name": "The Towers",
            "imgLink": "https://i.ibb.co/S5ZjSL1/curfew-tower.png"
        }
    }
    else if (index == "poi5") {
        return {
            "name": "Waterloo Chamber",
            "imgLink": "https://i.ibb.co/7j1h91V/waterloo-chamber.png"
        }
    }
    else if (index == "poi6") {
        return {
            "name": "Queen Mary's Doll's House",
            "imgLink": "https://i.ibb.co/fSsQn8H/queen-marys-dolls-house.png"
        }
    }
    else if (index == "poi7") {
        return {
            "name": "Change The Guard",
            "imgLink": "https://i.ibb.co/8rBTDpg/change-the-guard.png"
        }
    }
    else if (index == "poi8") {
        return {
            "name": "St. George's Chapel",
            "imgLink": "https://i.ibb.co/dj4LRwX/st-georges-chapel.png"
        }
    }
    else if (index == "poi9") {
        return {
            "name": "Semi - State Rooms",
            "imgLink": "https://i.ibb.co/74Kc9zS/semi-state-rooms.png"
        }
    }
    else {
        return {
            "name": "State Apartments",
            "imgLink": "https://i.ibb.co/0Bmc99d/state-apartments.png"
        }
    }
}


// Display alert

function displayAlert(message) {
    $('#alert-text').text(message);
    $("#alert").css({ "visibility": "visible" });
    $("#page").css({ "opacity": "0.7", "pointer-events": "none" })
}

// Validate email

function validateEmail($email) {
    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
    return emailReg.test($email);
}

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
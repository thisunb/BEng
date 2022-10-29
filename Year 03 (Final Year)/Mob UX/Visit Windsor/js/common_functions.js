// Hamburger function

$(document).ready(function () {
    var clickCount = 0;
    $("#hamburger-icon").click(function () {
        if (clickCount % 2 == 0) {
            $(document.getElementById("link-list").style.display = "block");
            $(clickCount++);
        }
        else {
            $(document.getElementById("link-list").style.display = "none");
            $(clickCount++);
        }
    });
});


// Remove alert

removeAlert = function () {
    $("#alert").css({ "visibility": "hidden", });
    $("#page").css({ "opacity": "1", "pointer-events": "visible" });
}

// Remove confimation

removeConfirmation = function () {
    $("#confirm").css({ "visibility": "hidden", });
    $("#page").css({ "opacity": "1", "pointer-events": "visible" });
}

// Remove fav email text box

removeConfirmation = function () {
    $("#fav-email").css({ "visibility": "hidden", });
    $("#page").css({ "opacity": "1", "pointer-events": "visible" });
}

// Add multiple items to nav bar (more than 5)

$(document).ready(function () {
    $("#inner-navbar > ul").removeClass("ui-grid-a");
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
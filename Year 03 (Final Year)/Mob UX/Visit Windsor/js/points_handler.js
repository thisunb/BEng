function createItem() {
    localStorage.mytime = 10;
}

function myFunction() {
    var x = localStorage.getItem("mytime");
    document.getElementById("demo").innerHTML = x;
}

var value = localStorage.getItem('user_points');

var progressvalue = 18;
$(window).load(function (e) {
    // code here
    checkprogress()
});
function checkprogress() {

    if (value >= 1) {
        progressvalue = 16.6;
        max = 100;
        $("#bar").attr("max", max).attr("value", progressvalue);
        console.log(value);
        document.getElementById("entree").style.backgroundColor = 'green';
        document.getElementById("entree").style.transition = '2s';


    } if (value >= 2) {
        progressvalue = 33.2;
        max = 100;
        $("#bar").attr("max", max).attr("value", progressvalue);

        document.getElementById("samurai").style.backgroundColor = 'green';
        document.getElementById("samurai").style.transition = '2s';

    } if (value >= 3) {
        progressvalue = 49.8;
        max = 100;
        $("#bar").attr("max", max).attr("value", progressvalue);

        document.getElementById("warrior").style.backgroundColor = 'green';
        document.getElementById("warrior").style.transition = '2s';

    } if (value > 4) {
        progressvalue = 66.4;
        max = 100;
        $("#bar").attr("max", max).attr("value", progressvalue);

        document.getElementById("ninja").style.backgroundColor = 'green';
        document.getElementById("ninja").style.transition = '2s';

    } if (value > 5) {
        progressvalue = 83;
        max = 100;
        $("#bar").attr("max", max).attr("value", progressvalue);

        document.getElementById("champ").style.backgroundColor = 'green';
        document.getElementById("champ").style.transition = '2s';

    } if (value > 6) {
        progressvalue = 100;
        max = 100;
        $("#bar").attr("max", max).attr("value", progressvalue);

        document.getElementById("king").style.backgroundColor = 'green';
        document.getElementById("king").style.transition = '2s';

    }
}

function entree() {
    progressvalue = 16.6;
    max = 100;
    $("#bar").attr("max", max).attr("value", progressvalue);
    console.log(progressvalue);

}
function samurai() {
    progressvalue = 33.2;
    max = 100;
    $("#bar").attr("max", max).attr("value", progressvalue);
    console.log(progressvalue);
}

function warrior() {
    progressvalue = 49.8;
    max = 100;
    $("#bar").attr("max", max).attr("value", progressvalue);
    console.log(progressvalue);
}

function ninja() {
    progressvalue = 66.4;
    max = 100;
    $("#bar").attr("max", max).attr("value", progressvalue);
    console.log(progressvalue);
}

function champ() {
    progressvalue = 83;
    max = 100;
    $("#bar").attr("max", max).attr("value", progressvalue);
    console.log(progressvalue);
}

function king() {
    progressvalue = 100;
    max = 100;
    $("#bar").attr("max", max).attr("value", progressvalue);
    console.log(progressvalue);
}

// Set points in page

$(document).ready(function () {

    setPoints = 0;

    if (localStorage.getItem("user_points")) {
        setPoints = localStorage.getItem("user_points");
    }
    else {
        setPoints = 0;
    }

    $("#points-text").text(setPoints + " points")

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
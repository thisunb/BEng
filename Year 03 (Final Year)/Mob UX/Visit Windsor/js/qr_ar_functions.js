$(document).ready(function () {

    $("#view-ar-btn").click(function () {

        $("#ar-overlay").css({ "visibility": "hidden" });
        $("#qr-overlay").css({ "visibility": "visible" });
        $("#ar-scanner").css({ "opacity": "1" });
        $("#qr-scanner").css({ "opacity": "0" });
    });

    $("#view-qr-btn").click(function () {

        $("#qr-overlay").css({ "visibility": "hidden" });
        $("#ar-overlay").css({ "visibility": "visible" });
        $("#ar-scanner").css({ "opacity": "0" });
        $("#qr-scanner").css({ "opacity": "1" });
    });
});


// Output QR code value

$(document).ready(function () {

    setInterval(function () {
        var qrVal = localStorage.getItem("qr-value")
        $('#link').attr("href", qrVal);
        $('#qr-result-text').text(qrVal);
    }, 100);
});


// Reload page & reset QR value 

$(document).ready(function () {
    $(".refresh-icon").click(function () {
        localStorage.setItem("qr-value", "")
        location.reload()
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
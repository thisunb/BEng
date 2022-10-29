$(document).ready(function () {

    var first_name = localStorage.getItem('first_name')
    var last_name = localStorage.getItem('last_name')
    var email = localStorage.getItem('email')
    var date_of_visit = localStorage.getItem('date_of_visit')
    var tel_no = localStorage.getItem('tel_no')
    var No_of_attendands = localStorage.getItem('No_of_attendands')

    $("#display_first_name").text(first_name);
    $("#display_last_name").text(last_name);
    $("#display_email").text(email);
    $("#display_date_of_visit").text(date_of_visit);
    $("#display_tel_no").text(tel_no);
    $("#display_no_of_attendants").text(No_of_attendands);

    $("#display_first_name2").text(first_name);
    $("#display_last_name2").text(last_name);
    $("#display_email2").text(email);
    $("#display_date_of_visit2").text(date_of_visit);
    $("#display_tel_no2").text(tel_no);
    $("#display_no_of_attendants2").text(No_of_attendands);

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
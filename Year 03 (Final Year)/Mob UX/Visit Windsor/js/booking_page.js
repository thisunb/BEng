$(document).ready(function() {
    $("#book_btn").click(function () {
        console.log($("#first_name").val());
        console.log($("#Last_name").val());
        console.log($("#Email").val());
        console.log($("#Date_of_visit").val());
        console.log($("#Telephone_number").val());
        console.log($("#Number_of_attendants").val());

        localStorage.setItem("first_name", $("#first_name").val());
        localStorage.setItem("last_name", $("#Last_name").val());
        localStorage.setItem("email", $("#Email").val());
        localStorage.setItem("date_of_visit", $("#Date_of_visit").val());
        localStorage.setItem("tel_no", $("#Telephone_number").val());
        localStorage.setItem("No_of_attendands", $("#Number_of_attendants").val());

        
    });
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
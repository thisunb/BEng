function myFunction() {
    console.log("mmmm");
    var x = localStorage.getItem("fpoints");
    document.getElementById("demo").innerHTML = x;
}

var points = 0;

if (parseInt(window.localStorage.getItem("user_points"))) {
    points = parseInt(localStorage.getItem('user_points'));
}
else {
    localStorage.setItem('user_points', 0)
    points = 0;
}

$(document).ready(function () {
    $('#send-comment').click(function () {
        points = points + 1;

        localStorage.setItem('user_points', points);
        // alert(points);
        console.log(comments, points);
        var comment = $('.commentBox').val();

        var username = localStorage.getItem("first-name")

        console.log("username - " + username)

        if (username == null) {
            displayAlert("Login to add comments!")
        }
        else {

            $('<div >\n' +
                '\t\t\t\t<img src = "Materials/icons/avatar.jpg" class="commenter-icon">\n' +
                '\t\t\t\t<p  style="color: white">' + username + '</p>\n' +
                '\t\t\t\t</div>').prependTo('#pro-pics');
            $('<p>').text(comment).prependTo('#single-comment');
            $('#send-comment').css('pointer-events', 'none');
            $('.counter').text('140');
            $('.commentBox').val('');
        }
    });

    $('.commentBox').keyup(function () {
        var commentLength = $(this).val().length;
        var charLeft = 140 - commentLength;
        $('.counter').text(charLeft);

        if (commentLength == 0) {
            $('#send-comment').css('pointer-events', 'none');
        }
        else if (commentLength > 140) {
            $('#send-comment').css('pointer-events', 'none');
        }
        else {
            $('#send-comment').css('pointer-events', 'auto');
        }
    });

    $('#send-comment').css('pointer-events', 'none');

});

// Display alert

function displayAlert(message) {
    $('#alert-text').text(message);
    $("#alert").css({ "visibility": "visible" });
    $("#page").css({ "opacity": "0.7", "pointer-events": "none" })
}


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
//  Alerts

function displayAlert(message) {
    $('#alert-text').text(message);
    $("#alert").css({ "visibility": "visible" });
    $("#page").css({ "opacity": "0.7", "pointer-events": "none" })
}

// Sign up function

$(document).ready(function () {
    $("#sign-up").click(function () {
        var firstName = $("#first-name").val()
        var lastName = $("#last-name").val()
        var email = $("#email", $("#form")).val()
        var password = $("#password", $("#form")).val()
        var confirmPassword = $("#confirm-password", $("#form")).val()

        if (firstName == "" || lastName == "" || email == "" || password == "" || confirmPassword == "") {
            displayAlert("Please fill out all the fields!")
        }
        else {
            if (!validateEmail(email)) {
                displayAlert("Enter a valid email!")
            }
            else if (password != confirmPassword) {
                displayAlert("passwords mismatch!")
            }
            else {
                localStorage.setItem("first-name", firstName)
                localStorage.setItem("last-name", lastName)
                localStorage.setItem("email", email)
                localStorage.setItem("password", password)
                displayAlert("Your account has been created!")
                $(location).attr('href', "signup_login.html#login");
            }
        }
    });
});

// login function

$(document).ready(function () {
    $("#login-button").click(function () {
        var email = $("#login-email").val()
        var password = $("#login-password").val()

        if (email == "" || password == "") {
            displayAlert("Please fill out all the fields!")
        }
        else {
            if (!validateEmail(email)) {
                displayAlert("Enter a valid email!")
            }
            else {
                var savedEmail = localStorage.getItem("email")
                var savedPassword = localStorage.getItem("password")

                if (email == savedEmail && password == savedPassword) {
                    $(location).attr('href', "site_windsor_castle.html");
                }
                else {
                    displayAlert("Invalid user login credentials!")
                }
            }
        }
    });
});

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
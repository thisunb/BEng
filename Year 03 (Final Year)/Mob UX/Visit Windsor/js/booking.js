$(document).ready(function () {
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

jQuery(function ($) {
  var $form = $('#frmBooking');
  var handler = StripeCheckout.configure({
    key: 'pk_test_cp21BcECf4kMMUbSlRlZlsMo',
    token: function (token) {
      // Use the token to create the charge with a server-side script.
      // You can access the token ID with `token.id`

      //This will be printed when the transaction is successful. To charge, server side scripting is required.
      if (token.id) {

        displayAlert("Thank you, your payment was successful!")

        //You can also use the following code to re-submit the form content to another file for further processing.
        //Don't forget to add action to your form
        //$form.get(0).submit();

        //Or save form data locally, using local storage.
      }
    }
  });


  $('#book_btn').click(function (e) {
    // Code Section B  Open Checkout with further options
    handler.open({
      name: 'Windsor Booking',
      currency: 'gbp',
      description: $('#Telephone_number').val(),
      amount: $('#Number_of_attendants').val() * 1000
    });
    e.preventDefault();
  });

  // Code Section C  Close Checkout on page navigation
  $(window).on('popstate', function () {
    handler.close();
  });
});


$(document).ready(function () {
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

jQuery(function ($) {
  var $form = $('#frmBooking');
  var handler = StripeCheckout.configure({
    key: 'pk_test_cp21BcECf4kMMUbSlRlZlsMo',
    token: function (token) {
      // Use the token to create the charge with a server-side script.
      // You can access the token ID with `token.id`

      //This will be printed when the transaction is successful. To charge, server side scripting is required.
      if (token.id) {
        $("#thankyouPayment1").html("Thank you, your payment was successful!");

        //You can also use the following code to re-submit the form content to another file for further processing.
        //Don't forget to add action to your form
        //$form.get(0).submit();

        //Or save form data locally, using local storage.
      }
    }
  });


  $('#book_btn1').click(function (e) {
    // Code Section B  Open Checkout with further options
    handler.open({
      name: 'Windsor Booking',
      currency: 'gbp',
      description: $('#Telephone_number1').val(),
      amount: $('#Number_of_attendants1').val() * 1000
    });
    e.preventDefault();
  });

  // Code Section C  Close Checkout on page navigation
  $(window).on('popstate', function () {
    handler.close();
  });
});

// Display alert

function displayAlert(message) {
  $('#alert-text').text(message);
  $("#alert").css({ "visibility": "visible" });
  $("#page").css({ "opacity": "0.7", "pointer-events": "none" })
}
package com.example.cw2;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import android.database.Cursor;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class RegisterMovie extends AppCompatActivity {

    DBHelper DB = new DBHelper(this);                                                // Initialising the Database and referring to DBHelper Class
    EditText inputTitle, inputYear, inputDirector, inputCast, inputRating, inputReview;     // Defining User Input Texts
    String title, year, director, cast, rating, review;                                    // Defining String variables

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register_movie);

        ActionBar actionBar;                                // Adding a custom color to Action bar
        actionBar = getSupportActionBar();
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#1C032A"));
        if (actionBar != null) actionBar.setBackgroundDrawable(colorDrawable);

        inputTitle = findViewById(R.id.movieTitle);               // Initialising all variables to xml layouts
        inputYear = findViewById(R.id.movieYear);
        inputDirector = findViewById(R.id.movieDirector);
        inputCast = findViewById(R.id.movieActors);
        inputRating = findViewById(R.id.movieRating);
        inputReview = findViewById(R.id.movieReview);
    }


    public void saveData(View view) {                           // Register movie button action
        insertData();
    }


    public void insertData(){               // Inserting data and checking all input fields are filled

        if(inputTitle.getText().toString().isEmpty() || inputYear.getText().toString().isEmpty() || inputDirector.getText().toString().isEmpty() ||
                inputCast.getText().toString().isEmpty() || inputRating.getText().toString().isEmpty() || inputReview.getText().toString().isEmpty()) {

            Toast.makeText(this, "Please fill the required fields!", Toast.LENGTH_SHORT).show();
        }
        else{
            title = inputTitle.getText().toString();
            year = inputYear.getText().toString();
            director = inputDirector.getText().toString();
            cast = inputCast.getText().toString();
            rating = inputRating.getText().toString();
            review = inputReview.getText().toString();

            int tempYear = Integer.parseInt(year);
            int tempRating = Integer.parseInt(rating);

            if (tempYear > 1895) {                                    // Validating year input
                if (tempRating >= 1 && tempRating <= 10) {           // Validating rating

                    Boolean checkInsertData = DB.insertUserData(title, year, director, cast, rating, review);   // Inserting Data to DB

                    if (checkInsertData) {

                        Toast.makeText(this, "Movie " + title + " has been registered successfully.", Toast.LENGTH_SHORT).show();

                        viewData();                                                                 // Displaying All movie details
                    }
                    else {
                        Toast.makeText(this, "Movie " + title +  " is already registered!", Toast.LENGTH_SHORT).show();
                    }
                }
                else {
                    Toast.makeText(this, "Enter a Rating between 1 & 10!", Toast.LENGTH_SHORT).show();
                }
            }
            else {
                Toast.makeText(this, "Enter a year greater than 1895", Toast.LENGTH_SHORT).show();
            }
        }
    }


    public void viewData(){

        Cursor res = DB.getData();

        if(res.getCount() == 0) {

            Toast.makeText(this, "No Entry exists to view!", Toast.LENGTH_SHORT).show();
        }
        else{
            StringBuilder displayText = new StringBuilder();

            int movieNumber = 0;                 // Initialising movie number

            while(res.moveToNext()){               // Creating the StringBuilder with movie details
                movieNumber++;

                displayText.append(movieNumber).append(")").append("\n\n");
                displayText.append("  * Title : ").append(res.getString(0)).append("\n");
                displayText.append("  * Year : ").append(res.getString(1)).append("\n");
                displayText.append("  * Director : ").append(res.getString(2)).append("\n");
                displayText.append("  * Cast : ").append(res.getString(3)).append("\n");
                displayText.append("  * Rating : ").append(res.getString(4)).append("\n");
                displayText.append("  * Review : ").append(res.getString(5)).append("\n\n");
            }
            AlertDialog.Builder displayAlert = new AlertDialog.Builder(RegisterMovie.this);
            displayAlert.setCancelable(true);
            displayAlert.setTitle("All Registered Movie Details");
            displayAlert.setMessage(displayText.toString());
            displayAlert.show();                                    // Displaying the Movie details
        }
    }
}
package com.example.cw2;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import android.database.Cursor;
import android.graphics.Color;
import android.graphics.PorterDuff;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.LayerDrawable;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.RatingBar;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

public class EditMovies2 extends AppCompatActivity implements AdapterView.OnItemSelectedListener {

    RatingBar ratingBar;
    DBHelper DB = new DBHelper(this);

    int clickCount = 0;                  // Defining required String & Int variables
    int year, rating;
    int preYear, preRating;

    String title, director, actors, review, favourite;
    String preDirector, preActors, preReview, preFavourite;
    String userSelection;

    EditText titleText, directorText, actorsText, reviewText, yearText;         // Defining required objects
    Spinner spinner;
    TextView selectedOption;
    String[] options = {"[Select an Option]", "Favourite", "Not Favourite"};    // Defining an array with options for spinner

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_movies2);

        ActionBar actionBar;                                        // Adding a custom color to Action bar
        actionBar = getSupportActionBar();
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#1C032A"));
        if (actionBar != null) actionBar.setBackgroundDrawable(colorDrawable);

        titleText = findViewById(R.id.title);                           // Initialising variables for xml layouts
        titleText.setEnabled(false);
        directorText = findViewById(R.id.director);
        actorsText = findViewById(R.id.actors);
        reviewText = findViewById(R.id.review);
        spinner = findViewById(R.id.spinner);
        yearText = findViewById(R.id.year);
        ratingBar = findViewById(R.id.ratingBar);
        selectedOption = findViewById(R.id.selection);

        getMovieDetails();
        displayMovieDetails();
        spinnerDisplay();
    }


    public void displayMovieDetails(){

        titleText.setText(title);                       // Setting movie details in EditTexts
        directorText.setText(director);
        actorsText.setText(actors);
        reviewText.setText(review);
        yearText.setText(String.valueOf(year));
        ratingBar.setRating((float) rating);
                                                                                                // Setting Color to rating bar stars
        LayerDrawable stars = (LayerDrawable) ratingBar.getProgressDrawable();

        stars.getDrawable(2).setColorFilter(ContextCompat.getColor(this, R.color.yellow), PorterDuff.Mode.SRC_ATOP);    // Color for selected rating stars
        stars.getDrawable(0).setColorFilter(ContextCompat.getColor(this, android.R.color.white), PorterDuff.Mode.SRC_ATOP);   // Color for default rating stars (not selected)
    }


    public void getMovieDetails(){

        Cursor res = DB.getSingleMovieDetails(EditMovies.movieName);        // Retrieving movie details

        while(res.moveToNext()){
            title = res.getString(0);
            year = Integer.parseInt(res.getString(1));
            director = res.getString(2);
            actors = res.getString(3);
            rating = Integer.parseInt(res.getString(4));
            review = res.getString(5);
            favourite = res.getString(6);
        }
        preYear = year;                       // Setting movie data for variables before user input
        preDirector = director;
        preActors = actors;
        preRating = rating;
        preReview = review;
        preFavourite = favourite;
    }


    public void update(View view){                              // Updating movie details

        director = directorText.getText().toString();
        actors = actorsText.getText().toString();
        review = reviewText.getText().toString();
        year = Integer.parseInt(yearText.getText().toString());
        rating = (int) ratingBar.getRating();

        if (year > 1895) {                  // Validating user input year

            if(rating >= 1 && rating <= 10) {       // Validating user input rating & checking all input fields are filled.

                if(!preDirector.equals(director) || !preActors.equals(actors) || !preReview.equals(review) || preYear != year || preRating != rating || !preFavourite.equals(favourite)){

                    DB.updateUserData(title, String.valueOf(year), director, actors, String.valueOf(rating), review, favourite);

                    Toast.makeText(this, "Movie Details updated successfully.", Toast.LENGTH_SHORT).show();
                    viewData();
                    updatePreVariables();           // Updating previously saved data of the TextBoxes
                }
                else{
                    Toast.makeText(this, "Changes required to update!", Toast.LENGTH_SHORT).show();
                }
            }
            else{
                Toast.makeText(this, "Enter a Rating between 1 & 10!", Toast.LENGTH_SHORT).show();
            }
        }
        else{
            Toast.makeText(this, "Enter a year greater than 1895", Toast.LENGTH_SHORT).show();
        }
    }


    public void updatePreVariables(){           // Updating previously saved data variables

        preDirector = directorText.getText().toString();
        preActors = actorsText.getText().toString();
        preReview = reviewText.getText().toString();
        preYear = Integer.parseInt(yearText.getText().toString());
        preRating = (int) ratingBar.getRating();
        preFavourite = favourite;
    }


    public void viewData(){         // Displaying all registered movie details

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
            AlertDialog.Builder displayAlert = new AlertDialog.Builder(EditMovies2.this);
            displayAlert.setCancelable(true);
            displayAlert.setTitle("All Registered Movie Details");
            displayAlert.setMessage(displayText.toString());
            displayAlert.show();                                    // Displaying the Movie details using alert
        }
    }


    public void spinnerDisplay(){

        if (spinner != null) {
            spinner.setOnItemSelectedListener(this);
        }

        ArrayAdapter<String> adapter = new ArrayAdapter<>(this,
                android.R.layout.simple_spinner_item, options);

        adapter.setDropDownViewResource (android.R.layout.select_dialog_singlechoice);

        if (spinner != null) {                                 // Applying the adapter to the spinner
            spinner.setAdapter(adapter);
        }

        if(favourite.equals("fav")) {
            selectedOption.setText(R.string.favourite_text);
        }
        else{
           selectedOption.setText(R.string.not_favourite_text);
        }
    }


    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

        userSelection = parent.getItemAtPosition(position).toString();
        ((TextView)view).setText(null);

        if(clickCount != 0 && !userSelection.equals("[Select an Option]")) {        // Preventing Spinner auto selecting the first element in startup
            selectedOption.setText(userSelection);

            if (userSelection.equals("Favourite")) {            // Setting appropriate value in DB based on user choice
                favourite = "fav";
            }
            else {
                favourite = "nFav";
            }
        }
        clickCount++;
    }


    @Override
    public void onNothingSelected(AdapterView<?> parent) {}

}
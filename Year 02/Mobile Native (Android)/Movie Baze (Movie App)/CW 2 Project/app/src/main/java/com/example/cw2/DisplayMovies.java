package com.example.cw2;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import android.database.Cursor;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

@RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)

public class DisplayMovies extends AppCompatActivity {

    DBHelper DB = new DBHelper(this);                           // Initialising the Database and referring to DBHelper Class

    ArrayList<String> favouriteMoviesList = new ArrayList<>();      // Defining all Lists for checkboxes, textViews, movies & favourite movies
    ArrayList<CheckBox> checkBoxesList = new ArrayList<>();
    ArrayList<TextView> textViewsList = new ArrayList<>();
    ArrayList<String> moviesList = new ArrayList<>();

    LinearLayout linear;                    // Defining the Linear Layout for ListView

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_display_movies);

        ActionBar actionBar;                        // Adding a custom color to Action bar
        actionBar = getSupportActionBar();
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#1C032A"));
        if (actionBar != null) actionBar.setBackgroundDrawable(colorDrawable);

        linear = findViewById(R.id.linear_display_movies);              // Initialising linear layout
        getMovies();                                                   // Getting all the registered movies from DB on startup
        displayMovies();                                              // Display the retrieved movies
    }


    public void getMovies(){

        Cursor res = DB.getMovieDetails();

        while(res.moveToNext()){
            moviesList.add(res.getString(0));
        }

        Collections.sort(moviesList, new Comparator<String>() {         // Sorting movie list in a alphabetical order
            @Override
            public int compare(String movie1, String movie2) {
                return movie1.compareToIgnoreCase(movie2);
            }
        });
    }


    public void displayMovies() {

        for(int i = 0; i < moviesList.size(); i++){

            TextView movie = new TextView(this);            // Creating TextView to display the Movie name
            TextView space1 = new TextView(this);          // Creating an additional textView to set line spacing

            movie.setWidth(700);                                // Setting params to movie textView
            movie.setText(moviesList.get(i));
            movie.setTextSize(15);
            movie.setId((i));
            movie.setGravity(1);
            movie.setTextColor(Color.WHITE);
            movie.setPadding(10,20,10,30);
            movie.setBackground(ContextCompat.getDrawable(getApplicationContext(),R.drawable.input_text));
            space1.setLines(2);

            CheckBox checkBox = new CheckBox(this);         // Creating Checkbox to get the user selection
            checkBox.setId((i));                                   // Setting params to checkbox
            checkBox.setLinkTextColor(Color.YELLOW);
            checkBox.setBackground(ContextCompat.getDrawable(getApplicationContext(),R.drawable.checkboxborder));

            textViewsList.add(movie);
            checkBoxesList.add(checkBox);

            LinearLayout tempLinearLayout = new LinearLayout(this);         // Creating a Dynamic Linear layout to display movie name and checkbox in a line
            tempLinearLayout.addView(movie);
            tempLinearLayout.addView(checkBox);

            LinearLayout.LayoutParams params = (LinearLayout.LayoutParams)checkBox.getLayoutParams();   // Setting params for linear layout
            params.setMargins(40, 0, 0, 0);
            checkBox.setLayoutParams(params);

            LinearLayout linearLayout = findViewById(R.id.linear_display_movies);      // Adding dynamic linear layout to physical/main linear layout
            linearLayout.addView(tempLinearLayout);
            linearLayout.addView(space1);                             // Setting additional space
        }


        for(int i = 0; i < moviesList.size(); i++) {               // Getting all the user's choice of checkboxes

            final int finalI = i;
            checkBoxesList.get(i).setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View view) {
                    if (((CompoundButton) view).isChecked()) {

                        favouriteMoviesList.add(textViewsList.get(finalI).getText().toString());
                    }

                    else {
                        favouriteMoviesList.remove(textViewsList.get(finalI).getText().toString());
                    }
                    System.out.println(textViewsList.get(finalI).getText() + " Checked");
                }
            });
        }
    }


    public void addToFavourites(View view){                             // Adding selected items to favourites

        for(int i = 0; i < favouriteMoviesList.size(); i++){

            DB.insertFavourites(favouriteMoviesList.get(i), "fav");
        }
        System.out.println(favouriteMoviesList);

        if(favouriteMoviesList.size() == 0) {                       // Checking a movie is selected by the user

            Toast.makeText(this, "Please select a movie!", Toast.LENGTH_SHORT).show();
        }
        else if(favouriteMoviesList.size() == 1){
            Toast.makeText(this, "Selected movie added to favourites.", Toast.LENGTH_SHORT).show();
        }
        else{
            Toast.makeText(this, "Selected movies added to favourites.", Toast.LENGTH_SHORT).show();
        }
    }
}
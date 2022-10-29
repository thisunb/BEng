package com.example.cw2;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import android.content.Intent;
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

@RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)

public class Favourites extends AppCompatActivity {

    DBHelper DB = new DBHelper(this);                           // Initialising the Database and referring to DBHelper Class

    ArrayList<String> favouriteMoviesList = new ArrayList<>();        // Defining all Lists for checkboxes, textViews, movies & favourite movies
    ArrayList<String> moviesList = new ArrayList<>();
    ArrayList<CheckBox> checkBoxesList = new ArrayList<>();
    ArrayList<TextView> textViewsList = new ArrayList<>();

    LinearLayout linear1;                // Defining the Linear Layout for ListView
    int previousFavCount;               // Defining variable for previously saved favourite list count

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_favourites);

        ActionBar actionBar;                                // Adding a custom color to Action bar
        actionBar = getSupportActionBar();
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#1C032A"));
        if (actionBar != null) actionBar.setBackgroundDrawable(colorDrawable);

        linear1 = findViewById(R.id.linear_favourites);
        getFavourites();                                    // Getting favourites on startup
    }


    public void getFavourites(){

        Cursor res = DB.getMovieDetails();

        while(res.moveToNext()){
            moviesList.add(res.getString(0));
        }

        String favourites = "fav";

        Cursor res2 = DB.getFavourites(favourites);

        while(res2.moveToNext()){
            favouriteMoviesList.add(res2.getString(0));
        }

        System.out.println(favouriteMoviesList);
        previousFavCount = favouriteMoviesList.size();

        for(int i = 0; i < favouriteMoviesList.size(); i++){

            TextView movie = new TextView(this);                    // Creating TextView to display the Movie name
            TextView space1 = new TextView(this);                  // Creating an additional textView to set line spacing

            movie.setWidth(700);                                         // Setting params to movie textView
            movie.setText(favouriteMoviesList.get(i));
            movie.setTextSize(15);
            movie.setId((i));
            movie.setGravity(1);
            movie.setTextColor(Color.WHITE);
            movie.setPadding(10,20,10,30);
            movie.setBackground(ContextCompat.getDrawable(getApplicationContext(),R.drawable.input_text));
            space1.setLines(2);

            CheckBox checkBox = new CheckBox(this);         // Creating Checkbox to get the user selection
            checkBox.setId((i));                                   // Setting params to checkbox
            checkBox.setChecked(true);
            checkBox.setLinkTextColor(Color.YELLOW);
            checkBox.setBackground(ContextCompat.getDrawable(getApplicationContext(),R.drawable.checkboxborder));

            textViewsList.add(movie);
            checkBoxesList.add(checkBox);

            LinearLayout tempLinearLayout = new LinearLayout(this);             // Creating a Dynamic Linear layout to display movie name and checkbox in a line
            tempLinearLayout.addView(movie);
            tempLinearLayout.addView(checkBox);

            LinearLayout.LayoutParams params = (LinearLayout.LayoutParams)checkBox.getLayoutParams();       // Setting params for linear layout
            params.setMargins(40, 0, 0, 0);
            checkBox.setLayoutParams(params);

            LinearLayout linearLayout = findViewById(R.id.linear_favourites);          // Adding dynamic linear layout to physical/main linear layout
            linearLayout.addView(tempLinearLayout);
            linearLayout.addView(space1);
        }


        for(int i = 0; i < favouriteMoviesList.size(); i++) {             // Getting all the user's choice of checkboxes

            final int finalI = i;
            checkBoxesList.get(i).setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View view) {
                    if (((CompoundButton) view).isChecked()) {

                        favouriteMoviesList.add(textViewsList.get(finalI).getText().toString());
                        System.out.println(textViewsList.get(finalI).getText() + " Checked");
                    }

                    else {
                        favouriteMoviesList.remove(textViewsList.get(finalI).getText().toString());
                        System.out.println(textViewsList.get(finalI).getText() + " unchecked");
                    }
                }
            });
        }
    }


    public void updateFavourites(View view){                                // Updating selected items to favourites

        System.out.println("favourite List - " + favouriteMoviesList);
        System.out.println("movie List - " + moviesList);

        for(int i = 0; i < moviesList.size(); i++){

            if(!favouriteMoviesList.contains(moviesList.get(i))){

                DB.insertFavourites(moviesList.get(i), "");
            }
        }

        if(favouriteMoviesList.size() == previousFavCount){         // Checking an update is done by the ser

            Toast.makeText(this, "Changes required to update favourites!", Toast.LENGTH_SHORT).show();
        }
        else {
            Toast.makeText(this, "Favourites have been updated successfully.", Toast.LENGTH_SHORT).show();
        }

        if(favouriteMoviesList.isEmpty()){

            Intent intent =  new Intent(this, MainActivity.class);                // Moving to main activity if no favourite movies available
            startActivity(intent);
            finishAffinity();
        }
        else {
            Intent intent = new Intent(this, Favourites.class);                // Refreshing intent to take effect
            overridePendingTransition(0, 0);
            startActivity(intent);
            overridePendingTransition(0, 0);
            finish();
        }
    }
}
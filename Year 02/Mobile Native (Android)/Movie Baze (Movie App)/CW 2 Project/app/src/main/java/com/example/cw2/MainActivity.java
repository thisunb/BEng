package com.example.cw2;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    DBHelper DB = new DBHelper(this);                   // Initialising the Database and referring to DBHelper Class

    private ArrayList<String> favouriteMovieList = new ArrayList<>();       // List to store favourite movies

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ActionBar actionBar;                                   // Adding a custom color to Action bar
        actionBar = getSupportActionBar();
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#1C032A"));
        if (actionBar != null) actionBar.setBackgroundDrawable(colorDrawable);
    }


    public void registerMovie(View view){
        Intent intent = new Intent(this, RegisterMovie.class);
        startActivity(intent);
    }


    public void displayMovie(View view){
                                                                // Displaying movies if saved movies are available
        if(DB.databaseExist(this)) {
            Intent intent = new Intent(this, DisplayMovies.class);
            startActivity(intent);
        }
        else {
            Toast.makeText(this, "No records available! Please add records.", Toast.LENGTH_SHORT).show();
        }
    }


    public void favourites(View view){          // Displaying favourites if saved movies are available

        if(DB.databaseExist(this)) {

            Cursor res2 = DB.getFavourites("fav");              // Retrieving favourites

            while(res2.moveToNext()){
                favouriteMovieList.add(res2.getString(0));          // Adding favourites to List
            }

            if(!favouriteMovieList.isEmpty()) {                                         // Checking for favourite movies
                Intent intent = new Intent(this, Favourites.class);
                startActivity(intent);
                favouriteMovieList.clear();
            }
            else {
                Toast.makeText(this, "No Movie Records as favourites!", Toast.LENGTH_SHORT).show();
            }
        }
        else {
            Toast.makeText(this, "No records available! Please add records.", Toast.LENGTH_SHORT).show();
        }
    }


    public void editMovies(View view){              // Moving to edit movies if movies are added in DB previously

        if(DB.databaseExist(this)) {
            Intent intent = new Intent(this, EditMovies.class);
            startActivity(intent);
        }
        else {
            Toast.makeText(this, "No records available! Please add records.", Toast.LENGTH_SHORT).show();
        }
    }


    public void searchMovies(View view){            // Moving to search movies if movies are added in DB previously

        if(DB.databaseExist(this)) {
            Intent intent = new Intent(this, SearchMovies.class);
            startActivity(intent);
        }
        else {
            Toast.makeText(this, "No records available! Please add records.", Toast.LENGTH_SHORT).show();
        }
    }


    public void ratings(View view){         // Moving to ratings intent if movies are added in DB previously

        if(DB.databaseExist(this)) {
            Intent intent = new Intent(this, Ratings.class);
            startActivity(intent);
        }
        else {
            Toast.makeText(this, "No records available! Please add records.", Toast.LENGTH_SHORT).show();
        }
    }
}

                                            // REFERENCES FOR CODE
/*
     * Lecture Notes

     * Tutorials (06, 07, 08 ,09)

     * Lecture Recordings

     *  Add a border to a textView - https://stackoverflow.com/questions/3496269/how-do-i-put-a-border-around-an-android-textview#:~:text=Create%20a%20border%20view%20with,view%20inside%20the%20border%20view.

     * Change the popup box background color - https://stackoverflow.com/questions/16198666/how-to-change-a-spinners-list-background-color-in-android

     * Change the background color of element in drawable xml - https://stackoverflow.com/questions/16198666/how-to-change-a-spinners-list-background-color-in-android

     * Get the drawable in android - https://stackoverflow.com/questions/29041027/android-getresources-getdrawable-deprecated-api-22

     * How to set up the landscape orientation - https://stackoverflow.com/questions/18677421/android-relativelayout-in-scrollview

     * How to kill the activity when the back button is pressed - https://stackoverflow.com/questions/4778754/how-do-i-kill-an-activity-when-the-back-button-is-pressed

     * How to stop restarting the activity when the orientation changes - https://stackoverflow.com/questions/5913130/dont-reload-application-when-orientation-changes#:~:text=Just%20add%20android%3AconfigChanges%3D%22,t%20restart%20when%20orientation%20change.

     * How to add a Custom color to Title Bar - https://www.geeksforgeeks.org/how-to-change-the-color-of-action-bar-in-an-android-app/

     * Some extra Color Codes - https://htmlcolorcodes.com/

     * Add textViews in java code (programmatically) android - https://stackoverflow.com/questions/3204852/how-to-add-a-textview-to-linearlayout-in-android

     * Add checkbox event listeners - https://stackoverflow.com/questions/8386832/android-checkbox-listener

     * Check the Database is available - https://stackoverflow.com/questions/49255502/how-to-check-if-a-db-exists-in-android

     * Using LIKE to retrieve data SQ Lite - https://stackoverflow.com/questions/3498844/sqlite-string-contains-other-string-query

     * create a custom list view - https://stackoverflow.com/questions/8921037/how-to-set-the-text-at-center-in-listview-android-application

     * How to get a substring from a string till a character - https://stackoverflow.com/questions/7683448/in-java-how-to-get-substring-from-a-string-till-a-character-c

     * change the right margin of the checkbox/textView - https://stackoverflow.com/questions/4472429/change-the-right-margin-of-a-view-programmatically

     * Checking the device is connected to a network - https://stackoverflow.com/questions/9570237/android-check-internet-connection

     * RatingBar stars color change - https://stackoverflow.com/questions/44327647/ratingbar-is-getting-semi-transparent

 */



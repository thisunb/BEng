package com.example.cw2;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import java.util.ArrayList;

public class EditMovies extends AppCompatActivity implements AdapterView.OnItemClickListener {

    public static String movieName;                                     // Setting a variable to send the user selected movie name to next intent

    ListView listView;                                         // Defining required variables
    DBHelper DB = new DBHelper(this);                 // Initialising the Database and referring to DBHelper Class
    ArrayList<String> moviesList = new ArrayList<>();        // Defining List to store movies list retrieved from DB

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_movies);

        ActionBar actionBar;                            // Adding a custom color to Action bar
        actionBar = getSupportActionBar();
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#1C032A"));
        if (actionBar != null) actionBar.setBackgroundDrawable(colorDrawable);

        getMovieDetails();                      // Retrieving movie details

        listView = findViewById(R.id.list_item_edit_movies);
        ArrayAdapter<String> friendsAdapter = new ArrayAdapter<>(this, R.layout.cutom_list_view,moviesList);
        listView.setAdapter(friendsAdapter);
        listView.setOnItemClickListener(this);
    }


    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

        movieName= parent.getItemAtPosition(position).toString();           // Getting user input

        Intent intent = new Intent(this, EditMovies2.class);     // Moving to next intent
        startActivity(intent);
        finish();
    }


    public void getMovieDetails(){

        Cursor res = DB.getMovieDetails();

        while(res.moveToNext()){
            moviesList.add(res.getString(0));
        }
    }
}
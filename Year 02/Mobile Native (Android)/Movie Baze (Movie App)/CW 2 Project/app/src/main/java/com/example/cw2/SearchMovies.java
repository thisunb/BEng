package com.example.cw2;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import android.database.Cursor;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import java.util.ArrayList;

public class SearchMovies extends AppCompatActivity {

    ArrayList<String> movieList = new ArrayList<>();
    DBHelper DB = new DBHelper(this);
    String userInputString;
    EditText userInput;
    ListView listView;
    TextView textView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_search_movies);

        ActionBar actionBar;                                // Adding a custom color to Action bar
        actionBar = getSupportActionBar();
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#1C032A"));
        if (actionBar != null) actionBar.setBackgroundDrawable(colorDrawable);

        userInput = findViewById(R.id.enterString);
        textView = findViewById(R.id.message_search_movies);
        listView = findViewById(R.id.list_item_search_movies);
    }
    

    public void getData(View view){

        userInputString = ("%" + userInput.getText().toString() + "%");

        if(!userInput.getText().toString().equals("")) {

            movieList.clear();
            Cursor res = DB.lookUpMovies(userInputString);

            while (res.moveToNext()) {
                movieList.add((res.getString(0)));
            }
            
            if(movieList.size() == 0){

                listView.setVisibility(View.INVISIBLE);
                textView.setVisibility(View.VISIBLE);
                Toast.makeText(this, "No Matches found!", Toast.LENGTH_SHORT).show();
            }
            else {
                displayMovies();
            }
        }
        else{
            listView.setVisibility(View.INVISIBLE);
            textView.setVisibility(View.VISIBLE);
            Toast.makeText(this, "Please enter a keyword for search.", Toast.LENGTH_SHORT).show();
        }
    }


    public void displayMovies(){

        textView.setVisibility(View.INVISIBLE);
        listView.setVisibility(View.VISIBLE);

        ArrayAdapter<String> friendsAdapter = new ArrayAdapter<>(this, R.layout.cutom_list_view,movieList);
        listView.setAdapter(friendsAdapter);
    }
}
package com.example.cw2;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import org.json.JSONArray;
import org.json.JSONObject;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

@SuppressWarnings("ALL")
public class Ratings extends AppCompatActivity{

    public static HashMap<String,String> movieImagesMap = new HashMap<>();       // Stores movie name with image url
    private static HashMap<String,String> movieIdMap = new HashMap<>();         // Stores movie name and id
    private ArrayList<CheckBox> selectedCheckBox = new ArrayList<>();          // Stores the selected checkbox (single checkbox)
    public static ArrayList<String> ratingLIst = new ArrayList<>();           // Stores movie names & rating (used to display in listview)
    private ArrayList<CheckBox> checkBoxesList = new ArrayList<>();          // Stores all the checkboxes in the list
    private ArrayList<TextView> textViewsList = new ArrayList<>();          // Stores all the textViews correspond to checkboxes
    private ArrayList<String> moviesList = new ArrayList<>();              // Stores all retrieved movies from DB

    private DBHelper DB = new DBHelper(this);                    // Initialising the Database and referring to DBHelper Class
    private String apiKey = "k_subcgufa";                               // Unique api key of IMDB
    private String userChoice = "";                                    // Variables to store user inputs
    private String userChoice2 = "";

    private ListView ratingListView;                                // Listviews to display movie rating and movie list
    private ListView movieListView;
    private LinearLayout linear;                                  // Linear layout to display movie list

    private int count = 0;                                      // Defining variable to store the number of retrieved movies from IMDB
    private static int errorCount = 0;                         // Defining variable to check the api limit is reached


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ratings);

        ActionBar actionBar;                                // Adding a custom color to Action bar
        actionBar = getSupportActionBar();
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#1C032A"));
        if (actionBar != null) actionBar.setBackgroundDrawable(colorDrawable);

        if(errorCount > 0) {                // Checking the api limit is reached and display messaage
            displayErrorMessage();
        }

        ratingLIst.clear();

        linear = findViewById(R.id.linear_ratings);
        getMovies();                                    // Retrieving movie details from DB
        displayMovies();                               // Displaying movie details in listview
    }


    public void getMoviesAndRatings(View view){             // Button action for Ratings

        ratingLIst.clear();

        if(!userChoice.equals("")) {            // Validating user checks a checkbox

            if(checkConnection(getApplicationContext())){           // Checking the device has a network connection

                Toast.makeText(this, "Please wait while loading!", Toast.LENGTH_SHORT).show();

                String url = "https://imdb-api.com/en/API/SearchTitle/" + apiKey + "/" + userChoice;
                RetrieveMovieDataTask task1 = new RetrieveMovieDataTask();
                task1.execute(url);
            }
            else {
                Toast.makeText(this, "Network Error Occurred! " +
                        "Make sure the device is connected to a Network.", Toast.LENGTH_SHORT).show();
            }
        }
        else{
            Toast.makeText(this, "Select a Movie to find rating!", Toast.LENGTH_SHORT).show();
        }
    }


    private class RetrieveMovieDataTask extends AsyncTask<String, Void, HashMap<String,String>> {

        @Override
        protected HashMap<String, String> doInBackground(String... urls) {

            HashMap<String,String> tempMovieMap = new HashMap<>();      // Creating a temporary hashmap to store movies & id
            StringBuilder stb = new StringBuilder();

            try {                                       // Retrieving the data from url and adding to a variable
                URL url = new URL(urls[0]);
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                BufferedReader bf = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String line ;
                while ((line = bf.readLine()) != null) {
                    stb.append(line);
                }
            }
            catch (MalformedURLException ex) {
                ex.printStackTrace();
            }
            catch(IOException ex) {
                ex.printStackTrace();
            }
                                                        // Casting the Stringbuilder to a json object
            try {
                JSONObject json = new JSONObject(stb.toString());

                String checkApi = json.getString("results");

                if(!checkApi.equals("null")) {              // Checking the api is working (API Request limit)

                    JSONArray array = json.getJSONArray("results");

                    for (int i = 0; i < array.length(); i++) {
                        String movieId = array.getJSONObject(i).getString("id");
                        String movieTitle = array.getJSONObject(i).getString("title");
                        String movieImageLink = array.getJSONObject(i).getString("image");
                        tempMovieMap.put(movieId, movieTitle);
                        setmovieImages(movieTitle, movieImageLink);
                    }
                }
                else {
                    errorCount++;           // Making UI Updates if API Request limit reached
                    refreshIntent();
                }
            }
            catch (Exception ex) {
                ex.printStackTrace();
            }
            return tempMovieMap;            // Returning retrieved all movies and corresponding ids
        }


        @Override
        protected void onPostExecute(final HashMap<String,String> finalMovieMap){
            super.onPostExecute(finalMovieMap);
                                                                                        // Displays message if no matches
            if(finalMovieMap.isEmpty() && errorCount == 0) {
                Toast.makeText(Ratings.this, "No matches found in IMDB!", Toast.LENGTH_SHORT).show();
            }

            setCount(finalMovieMap.size());             // Setting no. of movies retrieved from url

            final ArrayList<String> movieIdKeySet = new ArrayList<>(finalMovieMap.keySet());

            Thread loadRatingThread = new Thread(new Runnable() {           // Staring the 2nd Asynctask in a new thread
                @Override
                public void run() {

                    for (int i = 0; i < finalMovieMap.size(); i++) {
                        String movieId = movieIdKeySet.get(i);
                        String url2 = "https://imdb-api.com/en/API/UserRatings/" + apiKey + "/" + movieId;
                        RetrieveRatingDataTask task2 = new RetrieveRatingDataTask();
                        task2.execute(url2);
                    }
                }
            });
            loadRatingThread.start();
        }
    }


    private class RetrieveRatingDataTask extends AsyncTask<String, Void, HashMap<String,String>> {

        @Override
        protected HashMap<String, String> doInBackground(String... urls) {

            HashMap<String,String> tempRatingMap = new HashMap<>();             // Creating a temporary hashmap to store movies & id (single item)

            StringBuilder stb = new StringBuilder();
            try {
                URL url = new URL(urls[0]);
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                BufferedReader bf = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String line ;
                while ((line = bf.readLine()) != null) {
                    stb.append(line);
                }
            }
            catch (MalformedURLException ex) {
                ex.printStackTrace();
            }
            catch(IOException ex) {
                ex.printStackTrace();
            }

            try {
                JSONObject json = new JSONObject(stb.toString());
                String rating = json.getString("totalRating");
                String MovieName = json.getString("title");

                if(rating.equals("") || rating.equals("null")){

                    rating = "N/A";
                }
                tempRatingMap.put(MovieName, rating);
            }
            catch (Exception ex) {
                ex.printStackTrace();
            }
            return tempRatingMap;
        }

        @Override
        protected void onPostExecute(HashMap<String,String> finalRatingMap) {
            super.onPostExecute(finalRatingMap);

            display(finalRatingMap);        // Setting up to add retrieved movie name & rating to List
        }
    }


    public void refreshIntent(){
        Intent intent =  new Intent(this, Ratings.class);                // Refreshing intent to display error message
        overridePendingTransition(0, 0);
        startActivity(intent);
        overridePendingTransition(0, 0);
        finish();
    }


    public void displayErrorMessage(){

        Toast.makeText(Ratings.this, "An Error occurred while loading! \n  " +
                "Please contact the Developer.", Toast.LENGTH_SHORT).show();
    }


    public void setCount(int movieCount){       // Setting movie count

        count = movieCount;
    }


    public void displayMovies() {

        for (int i = 0; i < moviesList.size(); i++) {

            TextView movie = new TextView(this);            // Creating TextView to display the Movie name
            TextView space1 = new TextView(this);          // Creating an additional textView to set line spacing

            movie.setWidth(700);                                // Setting params to movie textView
            movie.setText(moviesList.get(i));
            movie.setTextSize(15);
            movie.setId((i));
            movie.setGravity(1);
            movie.setTextColor(Color.WHITE);
            movie.setPadding(10, 20, 10, 30);
            movie.setBackground(ContextCompat.getDrawable(getApplicationContext(), R.drawable.input_text));
            space1.setLines(2);

            CheckBox checkBox = new CheckBox(this);         // Creating Checkbox to get the user selection
            checkBox.setId((i));                                   // Setting params to checkbox
            checkBox.setLinkTextColor(Color.YELLOW);
            checkBox.setBackground(ContextCompat.getDrawable(getApplicationContext(), R.drawable.checkboxborder));

            textViewsList.add(movie);
            checkBoxesList.add(checkBox);

            LinearLayout tempLinearLayout = new LinearLayout(this);       // Creating a Dynamic Linear layout to display movie name and checkbox in a line
            tempLinearLayout.addView(movie);
            tempLinearLayout.addView(checkBox);

            LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) checkBox.getLayoutParams();   // Setting params for linear layout
            params.setMargins(40, 0, 0, 0);
            checkBox.setLayoutParams(params);

            LinearLayout linearLayout = findViewById(R.id.linear_ratings);      // Adding dynamic linear layout to physical/main linear layout
            linearLayout.addView(tempLinearLayout);
            linearLayout.addView(space1);                             // Setting additional space
        }


        for(int i = 0; i < moviesList.size(); i++) {               // Getting all the user's choice of checkboxes

            final int finalI = i;
            checkBoxesList.get(i).setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View view) {                                // Validating the user input for checkboxes

                    CheckBox userCheck = checkBoxesList.get(finalI);

                    if(selectedCheckBox.size() == 0){                           // Checking the user selection for first time
                        userCheck.setChecked(true);
                        System.out.println(textViewsList.get(finalI).getText().toString() + " clicked");
                        selectedCheckBox.add(userCheck);
                    }
                    else if(selectedCheckBox.get(0).equals(userCheck)){                 // uncheck checked checkbox
                        selectedCheckBox.get(0).setChecked(false);
                        selectedCheckBox.remove(0);
                    }
                    else {                                                      // Lets user check only one checkbox
                        selectedCheckBox.get(0).setChecked(false);
                        selectedCheckBox.remove(0);
                        userCheck.setChecked(true);
                        System.out.println(textViewsList.get(finalI).getText().toString() + " clicked");
                        selectedCheckBox.add(userCheck);
                    }

                    if(userCheck.isChecked()){
                        userChoice = textViewsList.get(finalI).getText().toString();        // Getting user input from checkbox
                    }
                    else{
                        userChoice = "";
                    }
                }
            });
        }
    }


    public void getMovies(){                            // Retrieving movie names from DB
        Cursor res = DB.getMovieDetails();

        while(res.moveToNext()){
            moviesList.add(res.getString(0));
        }
    }


    public static boolean checkConnection(Context context) {

        final ConnectivityManager connectivityManager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);

        if (connectivityManager != null) {
            NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();

            if (activeNetworkInfo != null) {                                                // Checks device connected to internet

                if (activeNetworkInfo.getType() == ConnectivityManager.TYPE_WIFI) {             // Checks wifi connectivity

                    return true;
                }
                else{
                    return activeNetworkInfo.getType() == ConnectivityManager.TYPE_MOBILE;    // Checks Mobile network connectivity
                }
            }
        }
        return false;
    }


    public void display(HashMap<String,String> map){            // Setting final Rating List (connects with listview)

        ratingLIst.add(map.keySet().toArray()[0].toString() + " - " + map.values().toArray()[0].toString());

        if(ratingLIst.size() == count){

            Toast.makeText(this, "Ratings have been loaded successfully.", Toast.LENGTH_SHORT).show();
            Intent intent = new Intent(this, displayRatingAndImage.class);
            startActivity(intent);
        }
    }


    public void setRetrievedMovies(HashMap<String,String> map){             // Setting movieIds with names to main hashmap outside asynctask
        movieIdMap.putAll(map);
    }


    public void setmovieImages(String movieName, String movieLink){     // Setting movie name with image url to Static Hashmap
        movieImagesMap.put(movieName, movieLink);
    }


    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event){
        if ((keyCode == KeyEvent.KEYCODE_BACK)){

            finish();
            errorCount = 0;
        }
        return super.onKeyDown(keyCode, event);
    }
}


/*
    List of API Keys:
       * k_subcgufa
       * k_e3rfzvgv
       * k_sev3einr
       * k_1212o9mu
       * k_cvrsub82
*/
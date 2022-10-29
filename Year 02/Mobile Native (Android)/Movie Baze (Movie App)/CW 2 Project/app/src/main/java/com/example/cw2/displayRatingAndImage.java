package com.example.cw2;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.Toast;

import java.io.InputStream;
import java.net.URL;
import static com.example.cw2.Ratings.movieImagesMap;

@SuppressWarnings("ALL")
public class displayRatingAndImage extends AppCompatActivity {

    private ListView listView;                              // Defining all required variables
    private String userChoice2;
    private ImageView movieImage;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_display_rating_and_image);

        ActionBar actionBar;                            // Adding a custom color to Action bar
        actionBar = getSupportActionBar();
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#1C032A"));
        if (actionBar != null) actionBar.setBackgroundDrawable(colorDrawable);
                                                                                    // Initialising list view and setting a list to adapter
        listView = findViewById(R.id.list_item_display_rating);
        ArrayAdapter<String> modulesAdapter = new ArrayAdapter<>(this, R.layout.cutom_list_view, Ratings.ratingLIst);
        listView.setAdapter(modulesAdapter);

        getInput();
    }


    public void getInput(){             // Getting user input from listview

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener(){
            @Override
            public void onItemClick (AdapterView <?> parent, View view, int position, long id){

                userChoice2 = parent.getItemAtPosition(position).toString();
                displayImage();
            }
        });
    }


    public void displayImage(){                 // Display image after retrieving image from url

        System.out.println("Image url list - " + movieImagesMap);

        int index = userChoice2.indexOf(" -");

        String subString = null;
        if (index != -1) {
            subString= userChoice2.substring(0 , index);
        }

        String url = movieImagesMap.get(subString);
        System.out.println(url);
                                                                        // Refreshing intent and loading default image when image is unavailable
        if(url == null){
            Toast.makeText(this, "Error occurred while loading image!", Toast.LENGTH_SHORT).show();
            Intent intent =  new Intent(this, displayRatingAndImage.class);                // Refreshing intent to display error message
            overridePendingTransition(0, 0);
            startActivity(intent);
            overridePendingTransition(0, 0);
            finish();
        }
        RetrieveImage task3 = new RetrieveImage();                  // Executing Asynctask for image retrieval
        task3.execute(url);
    }


    private class RetrieveImage extends AsyncTask<String,Void, Bitmap> {                // Performing Asynctask to retrive the image from url

        @Override
        protected Bitmap doInBackground(String... urls) {
            String urlOfImage = urls[0];
            Bitmap logo = null;

            try {
                InputStream is = new URL(urlOfImage).openStream();
                logo = BitmapFactory.decodeStream(is);
            }
            catch (Exception e) {
                e.printStackTrace();
            }
            return logo;
        }

        @Override
        protected void onPostExecute(Bitmap result) {

            movieImage = findViewById(R.id.imageView_display_rating);           // Setting image to imageview
            movieImage.setImageBitmap(result);
        }
    }
}
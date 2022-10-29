package com.example.cw;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import android.annotation.SuppressLint;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.view.KeyEvent;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import java.util.ArrayList;

public class IdentifyCarImageActivity extends AppCompatActivity {

    private static ArrayList<String> imageList = new ArrayList<>();                     // Defining List to store all images
    private static ArrayList<String> displayedCarList = new ArrayList<>();      // Defining List to store already displayed images

    private String resource1;                                                  // Defining variables for image resources
    private String resource2;
    private String resource3;
    private String vehicleBrandName;                                           // Variable for Vehicle brand

    private ImageView v1;
    private ImageView v2;
    private ImageView v3;

    private int clickCount = 0;                                              // Variable to track the user click count
    private int counter = 20;
    private static int startup = 0;

    private TextView carBrand;                                               // Defining all required TextViews
    private TextView feedback;
    private TextView countdown;
    private TextView instructionText;

    public static CountDownTimer countDownTimer;
    public static boolean isCountdownRunning = false;

    private static ArrayList<String> audiCarList = new ArrayList<>();
    private static ArrayList<String> bmwCarList = new ArrayList<>();
    private  static ArrayList<String> fordCarList = new ArrayList<>();
    private static ArrayList<String> hondaCarList = new ArrayList<>();
    private static ArrayList<String> teslaCarList = new ArrayList<>();
    private  static ArrayList<String> volvoCarList = new ArrayList<>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_identify_car_image);

        ActionBar actionBar;                                              // Adding a custom color to Action bar
        actionBar = getSupportActionBar();
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#120917"));

        if (actionBar != null) {
            actionBar.setBackgroundDrawable(colorDrawable);
        }


        if(displayedCarList.size() != 30) {                             // Checking all the images are displayed

            if(startup == 0) {                                         // Adding the images to lists only for first time

                for (int i = 1; i < 6; i++) {                          // Adding all the images to List
                    imageList.add("a" + i);
                    imageList.add("b" + i);
                    imageList.add("f" + i);
                    imageList.add("h" + i);
                    imageList.add("t" + i);
                    imageList.add("v" + i);

                    audiCarList.add("a" + i);
                    bmwCarList.add("b" + i);
                    fordCarList.add("f" + i);
                    hondaCarList.add("h" + i);
                    teslaCarList.add("t" + i);
                    volvoCarList.add("v" + i);
                }
                startup++;
            }

                            // Getting the resource 1

            int randomNumber1 = (int) (Math.random() * ((imageList.size() - 1) + 1) + 0);           // Defining the random numbers
            resource1 = imageList.get(randomNumber1);

                                                                                                    //Checking the resource 1 is already displayed
            while(displayedCarList.contains(resource1)){
                randomNumber1 = (int) (Math.random() * ((imageList.size()-1) + 1) + 0);
                resource1 = imageList.get(randomNumber1);
            }

                                                                                                    // getting the resource 2

            int randomNumber2 = (int) (Math.random() * ((imageList.size() - 1) + 1) + 0);
            resource2 = imageList.get(randomNumber2);

                                                                    // Checking the resource 1 equals to resource2, same brand & resource 2 is already displayed
            while(resource2.equals(resource1) ||

                    displayedCarList.contains(resource2) ||

                    audiCarList.contains(resource1) && audiCarList.contains(resource2) ||
                    bmwCarList.contains(resource1) && bmwCarList.contains(resource2) ||
                    fordCarList.contains(resource1) && fordCarList.contains(resource2) ||
                    hondaCarList.contains(resource1) && hondaCarList.contains(resource2) ||
                    teslaCarList.contains(resource1) && teslaCarList.contains(resource2) ||
                    volvoCarList.contains(resource1) && volvoCarList.contains(resource2)  ){

                randomNumber2 = (int) (Math.random() * ((imageList.size()-1) + 1) + 0);
                resource2 = imageList.get(randomNumber2);
            }


                                    // getting the resource 3

            int randomNumber3 = (int) (Math.random() * ((imageList.size() - 1) + 1) + 0);
            resource3 = imageList.get(randomNumber3);

                                // Checking the resource 3 equals to resource 1 & resource 2, same brand & resource 3 is already displayed

            while(resource3.equals(resource1) || resource3.equals(resource2) || displayedCarList.contains(resource3) ||

                    audiCarList.contains(resource3) && audiCarList.contains(resource1) ||
                    bmwCarList.contains(resource3) && bmwCarList.contains(resource1) ||
                    fordCarList.contains(resource3) && fordCarList.contains(resource1) ||
                    hondaCarList.contains(resource3) && hondaCarList.contains(resource1) ||
                    teslaCarList.contains(resource3) && teslaCarList.contains(resource1) ||
                    volvoCarList.contains(resource3) && volvoCarList.contains(resource1) ||


                    audiCarList.contains(resource3) && audiCarList.contains(resource2) ||
                    bmwCarList.contains(resource3) && bmwCarList.contains(resource2) ||
                    fordCarList.contains(resource3) && fordCarList.contains(resource2) ||
                    hondaCarList.contains(resource3) && hondaCarList.contains(resource2) ||
                    teslaCarList.contains(resource3) && teslaCarList.contains(resource2) ||
                    volvoCarList.contains(resource3) && volvoCarList.contains(resource2)) {


                randomNumber3 = (int) (Math.random() * ((imageList.size()-1) + 1) + 0);
                resource3 = imageList.get(randomNumber3);
            }

            System.out.println(displayedCarList);

            String saveImageSource1 = resource1;                           // Variables to save image resource
            String saveImageSource2 = resource2;
            String saveImageSource3 = resource3;

            displayedCarList.add(saveImageSource1);                       // Saving the currently displayed images to List
            displayedCarList.add(saveImageSource2);
            displayedCarList.add(saveImageSource3);

            v1 = findViewById(R.id.imageView1);
            v2 = findViewById(R.id.imageView2);
            v3 = findViewById(R.id.imageView3);
                                                                         // Getting resource ids for image resources

            int resource_id1 = getResources().getIdentifier(resource1, "drawable", "com.example.cw");
            v1.setImageResource(resource_id1);

            int resource_id2 = getResources().getIdentifier(resource2, "drawable", "com.example.cw");
            v2.setImageResource(resource_id2);

            int resource_id3 = getResources().getIdentifier(resource3, "drawable", "com.example.cw");
            v3.setImageResource(resource_id3);

            carBrand = findViewById(R.id.displayBrand);                   // Defining TextViews, TextBoxes & Buttons
            feedback = findViewById(R.id.feedback);
            instructionText = findViewById(R.id.instruction);

            displayBrand();

            if (MainActivity.isChecked) {
                startCountdown();
            }
        }
        else {                                                      // Changing activity to final activity after all images are displayed

            Intent intent = new Intent(this, FinalActivity.class);
            displayedCarList.clear();
            startActivity(intent);
            this.finish();
        }
    }


    public void startCountdown() {

        countdown = findViewById(R.id.textView);            // Connecting the local variable with the TextView

        if (counter != 20) {
            counter = 20;
            countDownTimer.cancel();
        }

        countDownTimer = new CountDownTimer(20000, 1000) {
            public void onTick(long millisUntilFinished) {
                isCountdownRunning = true;
                countdown.setText(String.valueOf(counter));
                countdown.setVisibility(View.VISIBLE);
                counter--;
            }

            public void onFinish() {
                countdown.setVisibility(View.INVISIBLE);
                instructionText.setVisibility(View.INVISIBLE);

                feedback.setText(R.string.wrong_text);
                feedback.setTextColor(Color.RED);
                feedback.setVisibility(View.VISIBLE);

                correctImageSelection();

                clickCount++;
                clickCount++;
            }
        }.start();
    }


    public void image1Click(View view) {

        clickCount++;

        if(clickCount==1) {

            correctImageSelection();

            if (chooseBrand(resource1).equals(vehicleBrandName)) {
                feedback.setText(R.string.correct_text);
                feedback.setTextColor(Color.GREEN);
            }
            else {
                feedback.setText(R.string.wrong_text);
                feedback.setTextColor(Color.RED);
            }
            instructionText.setVisibility(View.INVISIBLE);

            if(isCountdownRunning) {
                countDownTimer.cancel();
                countdown.setVisibility(View.INVISIBLE);
            }
            feedback.setVisibility(View.VISIBLE);
        }
    }


    public void image2Click(View view){

        clickCount++;

        if(clickCount==1) {

            correctImageSelection();

            if (chooseBrand(resource2).equals(vehicleBrandName)) {
                feedback.setText(R.string.correct_text);
                feedback.setTextColor(Color.GREEN);

            }
            else {
                feedback.setText(R.string.wrong_text);
                feedback.setTextColor(Color.RED);
            }
            instructionText.setVisibility(View.INVISIBLE);

            if(isCountdownRunning) {
                countDownTimer.cancel();
                countdown.setVisibility(View.INVISIBLE);
            }
            feedback.setVisibility(View.VISIBLE);
        }
    }


    public void image3Click(View view) {

        clickCount++;

        if (clickCount==1) {

            correctImageSelection();

            if (chooseBrand(resource3).equals(vehicleBrandName)) {
                feedback.setText(R.string.correct_text);
                feedback.setTextColor(Color.GREEN);
            }
            else {
                feedback.setText(R.string.wrong_text);
                feedback.setTextColor(Color.RED);
            }
            instructionText.setVisibility(View.INVISIBLE);

            if(isCountdownRunning) {
                countDownTimer.cancel();
                countdown.setVisibility(View.INVISIBLE);
            }
            feedback.setVisibility(View.VISIBLE);
        }
    }


    @SuppressLint("NewApi")
    public void correctImageSelection(){

        if(chooseBrand(resource1).equals(vehicleBrandName)){
            v1.setBackground(ContextCompat.getDrawable(getApplicationContext(),R.drawable.styled_correct_image_selection));

        }
        else if(chooseBrand(resource2).equals(vehicleBrandName)){
            v2.setBackground(ContextCompat.getDrawable(getApplicationContext(),R.drawable.styled_correct_image_selection));

        }
        else{
            v3.setBackground(ContextCompat.getDrawable(getApplicationContext(),R.drawable.styled_correct_image_selection));
        }
    }


    public void toNext(View view){                                          // Changing the activity

        if(isCountdownRunning){
            countDownTimer.cancel();
        }

        Intent refresh = new Intent(this, IdentifyCarImageActivity.class);
        startActivity(refresh);
        overridePendingTransition(0, 0);
        this.finish();
    }


    public void displayBrand(){                                             // Displaying the brand

        int randomDisplay = (int) (Math.random() * (2 + 1) + 0);

        if(randomDisplay == 0) {
            vehicleBrandName = chooseBrand(resource1);
            carBrand.setText(vehicleBrandName);
        }

        else if(randomDisplay == 1) {
            vehicleBrandName = chooseBrand(resource2);
            carBrand.setText(vehicleBrandName);
        }

        else if(randomDisplay == 2) {
            vehicleBrandName = chooseBrand(resource3);
            carBrand.setText(vehicleBrandName);
        }
    }


    public String chooseBrand(String resource){                         // Method for choosing the brand name corresponds to image resource

        switch (resource)  {
            case "a1":
            case "a2":
            case "a3":
            case "a4":
            case "a5":

               return  "AUDI";

            case "b1":
            case "b2":
            case "b3":
            case "b4":
            case "b5":

                return "BMW";

            case "f1":
            case "f2":
            case "f3":
            case "f4":
            case "f5":

                return "FORD";

            case "h1":
            case "h2":
            case "h3":
            case "h4":
            case "h5":

                return "HONDA";

            case "t1":
            case "t2":
            case "t3":
            case "t4":
            case "t5":

                return "TESLA";

            case "v1":
            case "v2":
            case "v3":
            case "v4":
            case "v5":

                return "VOLVO";
        }
       return null;
    }


    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event){
        if ((keyCode == KeyEvent.KEYCODE_BACK)){

            finish();

            if(isCountdownRunning) {
                countDownTimer.cancel();
            }
        }
        return super.onKeyDown(keyCode, event);
    }
}
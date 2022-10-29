package com.example.cw;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;
import java.util.ArrayList;

public class AdvancedLevelActivity extends AppCompatActivity{

    private static ArrayList<String> imageList = new ArrayList<>();                      // Defining List to store all images
    private static ArrayList<String> displayedCarList = new ArrayList<>();       // Defining List to store already displayed images

    private String resource1;                                                  // Resource variables
    private String resource2;
    private String resource3;
    private String vehicleBrandName;                                         // Variable for vehicle Brand

    private int score1;                                                     // Defining Score variables
    private int score2;
    private int score3;
    private int clickCount = 0;
    private int incorrectAttemptCount = 0;
    private int counter = 20;

    private TextView brand1;                                               // Defining TextViews
    private TextView brand2;
    private TextView brand3;
    private TextView feedback;
    private TextView score;
    private TextView countdown;
    private TextView instructionText;

    private EditText vehicle1;                                            // Defining TextBoxes
    private EditText vehicle2;
    private EditText vehicle3;
    private Button option;                                               // Defining required buttons

    public static CountDownTimer countDownTimer;
    public static boolean isCountdownRunning = false;

    private static ArrayList<String> audiCarList = new ArrayList<>();
    private static ArrayList<String> bmwCarList = new ArrayList<>();
    private static ArrayList<String> fordCarList = new ArrayList<>();
    private static ArrayList<String> hondaCarList = new ArrayList<>();
    private static ArrayList<String> teslaCarList = new ArrayList<>();
    private static ArrayList<String> volvoCarList = new ArrayList<>();

    private static int startup = 0;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_advanced_level);

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

            while(resource2.equals(resource1) || displayedCarList.contains(resource2) ||

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

                                        // Defining variables to store already displayed image resource

            String saveImageSource1 = resource1;                             // Saving the current image to check later
            String saveImageSource2 = resource2;
            String saveImageSource3 = resource3;

            displayedCarList.add(saveImageSource1);                         // Saving the currently displayed images to List
            displayedCarList.add(saveImageSource2);
            displayedCarList.add(saveImageSource3);

            ImageView v1 = findViewById(R.id.imageView1);
            ImageView v2 = findViewById(R.id.imageView2);
            ImageView v3 = findViewById(R.id.imageView3);
                                                                            // Getting resource ids for image resources

            int resource_id1 = getResources().getIdentifier(resource1, "drawable", "com.example.cw");
            v1.setImageResource(resource_id1);

            int resource_id2 = getResources().getIdentifier(resource2, "drawable", "com.example.cw");
            v2.setImageResource(resource_id2);

            int resource_id3 = getResources().getIdentifier(resource3, "drawable", "com.example.cw");
            v3.setImageResource(resource_id3);

                                                                       // Initialising variables for TextViews, TextBoxes & Buttons
            feedback = findViewById(R.id.feedback);
            option = findViewById(R.id.submit_button);
            vehicle1 = findViewById(R.id.vehicle1);
            vehicle2 = findViewById(R.id.vehicle2);
            vehicle3 = findViewById(R.id.vehicle3);
            brand1 = findViewById(R.id.car_brand1);
            brand2 = findViewById(R.id.car_brand2);
            brand3 = findViewById(R.id.car_brand3);
            score = findViewById(R.id.score);
            instructionText = findViewById(R.id.instruction);

            if (MainActivity.isChecked) {
                startCountdown();
            }
        }
        else {                                                  // Changing activity to final activity after all images are displayed
            finish();
            Intent intent = new Intent(this, FinalActivity.class);
            displayedCarList.clear();
            overridePendingTransition(0, 0);
            startActivity(intent);
            overridePendingTransition(0, 0);
        }
    }


    public void startCountdown() {

        countdown = findViewById(R.id.textView);                // Connecting the local variable with the TextView

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

               submit(null);
            }
        }.start();
    }


    public void submit(View view){

        if(isCountdownRunning) {

            if (incorrectAttemptCount == 2){
                countDownTimer.cancel();
                countdown.setVisibility(View.INVISIBLE);
                instructionText.setVisibility(View.INVISIBLE);
            }
            else{
                counter = 20;
                countDownTimer.cancel();
                startCountdown();
            }
        }
        verifyAnswer();
    }


    public void verifyAnswer(){

        feedback.setVisibility(View.INVISIBLE);
                                                                                 // Getting the user inputs for images
        String answer1 = String.valueOf(vehicle1.getText()).toUpperCase();
        String answer2 = String.valueOf(vehicle2.getText()).toUpperCase();
        String answer3 = String.valueOf(vehicle3.getText()).toUpperCase();
                                                                                // Checking the user inputs are correct
        if(chooseBrand(resource1).equals(answer1)){
            vehicle1.setEnabled(false);
            vehicle1.setTextColor(Color.GREEN);
            score1 = 1;
            vehicle1.setText(answer1.toUpperCase());
        }

        else if (!chooseBrand(resource1).equals(answer1)){
            vehicle1.setTextColor(Color.RED);
        }


        if(chooseBrand(resource2).equals(answer2)){
            vehicle2.setEnabled(false);
            vehicle2.setTextColor(Color.GREEN);
            score2 = 1;
            vehicle2.setText(answer2.toUpperCase());
        }

        else if (!chooseBrand(resource2).equals(answer2)){
            vehicle2.setTextColor(Color.RED);
        }


        if(chooseBrand(resource3).equals(answer3)){
            vehicle3.setEnabled(false);
            vehicle3.setTextColor(Color.GREEN);
            score3 = 1;
            vehicle3.setText(answer3.toUpperCase());
        }

        else if (!chooseBrand(resource3).equals(answer3)){
            vehicle3.setTextColor(Color.RED);
        }


        if(chooseBrand(resource1).equals(answer1) && chooseBrand(resource2).equals(answer2) && chooseBrand(resource3).equals(answer3)){

            vehicle1.setText(answer1.toUpperCase());
            vehicle2.setText(answer2.toUpperCase());
            vehicle3.setText(answer3.toUpperCase());

            feedback.setText(R.string.correct_text);
            feedback.setTextColor(Color.GREEN);
            feedback.setVisibility(View.VISIBLE);
            option.setText(R.string.next_button);
            clickCount++;

            instructionText.setVisibility(View.INVISIBLE);

            if(isCountdownRunning){
                countDownTimer.cancel();
                countdown.setVisibility(View.INVISIBLE);
            }

            if(clickCount > 1){
                finish();
                Intent intent = new Intent(this, AdvancedLevelActivity.class);
                overridePendingTransition(0, 0);
                startActivity(intent);
                overridePendingTransition(0, 0);
            }
        }
        else {
            if(incorrectAttemptCount == 2){
                feedback.setText(R.string.wrong_text);
                feedback.setTextColor(Color.RED);
                feedback.setVisibility(View.VISIBLE);
                option.setText(R.string.next_button);
                clickCount++;

                instructionText.setVisibility(View.INVISIBLE);

                if(!chooseBrand(resource1).equals(answer1)){
                    brand1.setVisibility(View.VISIBLE);
                    brand1.setText(chooseBrand(resource1));
                    brand1.setTextColor(Color.YELLOW);
                    vehicle1.setEnabled(false);
                }

                if(!chooseBrand(resource2).equals(answer2)){
                    brand2.setVisibility(View.VISIBLE);
                    brand2.setText(chooseBrand(resource2));
                    brand2.setTextColor(Color.YELLOW);
                    vehicle2.setEnabled(false);
                }

                if(!chooseBrand(resource3).equals(answer3)){
                    brand3.setVisibility(View.VISIBLE);
                    brand3.setText(chooseBrand(resource3));
                    brand3.setTextColor(Color.YELLOW);
                    vehicle3.setEnabled(false);
                }

                if(clickCount > 1){
                    Intent intent = new Intent(this, AdvancedLevelActivity.class);
                    finish();
                    overridePendingTransition(0, 0);
                    startActivity(intent);
                    overridePendingTransition(0, 0);
                }
            }
            else {
                incorrectAttemptCount++;
                Toast.makeText(this, "Remaining attempts - " + (3 - incorrectAttemptCount), Toast.LENGTH_SHORT).show();
            }
        }
        int userScore;                                                // Displaying user the Score
        userScore = score1 + score2 + score3;
        String userScoreText = "Score - " + userScore;
        score.setText(userScoreText);

        if(userScore > 0){
            score.setTextColor(Color.GREEN);
        }
        else{
            score.setTextColor(Color.RED);
        }
    }


    public String chooseBrand(String brand){                         // Method for choosing the Correct Brand name

        switch (brand) {
            case "a1":
            case "a2":
            case "a3":
            case "a4":
            case "a5":

                vehicleBrandName = "AUDI";
                break;

            case "b1":
            case "b2":
            case "b3":
            case "b4":
            case "b5":

                vehicleBrandName = "BMW";
                break;

            case "f1":
            case "f2":
            case "f3":
            case "f4":
            case "f5":

                vehicleBrandName = "FORD";
                break;

            case "h1":
            case "h2":
            case "h3":
            case "h4":
            case "h5":

                vehicleBrandName = "HONDA";
                break;

            case "t1":
            case "t2":
            case "t3":
            case "t4":
            case "t5":

                vehicleBrandName = "TESLA";
                break;

            case "v1":
            case "v2":
            case "v3":
            case "v4":
            case "v5":

                vehicleBrandName = "VOLVO";
                break;
        }
        return vehicleBrandName;
    }


    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event){
        if ((keyCode == KeyEvent.KEYCODE_BACK)) {

            finish();

            if(isCountdownRunning) {
                countDownTimer.cancel();
            }
        }
        return super.onKeyDown(keyCode, event);
    }
}
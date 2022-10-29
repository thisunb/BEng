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

public class HintsActivity extends AppCompatActivity{

    private ArrayList<String> imageList = new ArrayList<>();                      // Defining List to store all images
    private static ArrayList<String> displayedCarList = new ArrayList<>();       // Defining List to store already displayed images

    private ArrayList<String> characterList = new ArrayList<>();                // List to store the vehicle brand characters
    private static ArrayList<String> userCharacterList = new ArrayList<>();    // List to store user correctly guessed characters

    private String vehicleBrandName;                                            // Variable for displayed vehicle brand
    String resource;                                                           // Image resource variable
    String input;                                                             // Variable to store user input

    int randomNumber;                                                       // Defining the random number
    int count = 0;
    int incorrectAttemptCount = 0;
    int correctTrackCount = 0;                                            // Variable to store user correct guesses
    private int counter = 20;

    private EditText userInput;                                          // TextBox for user input
    private TextView displayName;                                       // Defining all required TextViews
    private TextView feedback;
    private TextView correctAnswer;
    private TextView countdown;
    private TextView instructionText;

    private Button eventButton;

    public static CountDownTimer countDownTimer;
    public static boolean isCountdownRunning = false;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_hints);

        ActionBar actionBar;                                           // Adding a custom color to Action bar
        actionBar = getSupportActionBar();
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#120917"));

        if (actionBar != null) {
            actionBar.setBackgroundDrawable(colorDrawable);
        }


        if(displayedCarList.size() != 30) {                          // Checking all the images are displayed

            for (int i = 1; i < 6; i++) {                          // Adding all the images to List
                imageList.add("a" + i);
                imageList.add("b" + i);
                imageList.add("f" + i);
                imageList.add("h" + i);
                imageList.add("t" + i);
                imageList.add("v" + i);
            }

            randomNumber = (int) (Math.random() * (29 + 1) + 0);                 // Generating a random number
            resource = imageList.get(randomNumber);                             // Getting the images for selected random number
                                                                               // Checking the same image displayed again
            while (displayedCarList.contains(resource)) {

                randomNumber = (int) (Math.random() * (29 + 1) + 0);
                resource = imageList.get(randomNumber);
            }

            displayedCarList.add(resource);                               // Saving the currently displayed images to List

            ImageView v1 = findViewById(R.id.imageView);
                                                                        // Getting resource ids for image resources

            int resource_id = getResources().getIdentifier(resource, "drawable", "com.example.cw");
            v1.setImageResource(resource_id);

            userInput = findViewById(R.id.userAnswer);               // Defining TextViews, TextBoxes & Buttons
            displayName = findViewById(R.id.displayName);
            eventButton = findViewById(R.id.button_submit);
            feedback = findViewById(R.id.feedback);
            correctAnswer = findViewById(R.id.correctAnswer);
            instructionText = findViewById(R.id.instruction);

            chooseBrand(resource);
            setInitialText();
            userCharacterList.clear();

            if (MainActivity.isChecked) {
                startCountdown();
            }
        }
        else {                                                    // Changing activity to final activity after all images are displayed
            finish();
            Intent intent = new Intent(this, FinalActivity.class);
            displayedCarList.clear();
            overridePendingTransition(0, 0);
            startActivity(intent);
            overridePendingTransition(0, 0);
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

                if(isCountdownRunning){

                    if(incorrectAttemptCount < 2){
                        incorrectAttemptCount++;
                        counter = 20;
                        Toast.makeText(HintsActivity.this, "Remaining attempts - " + (3 - incorrectAttemptCount), Toast.LENGTH_SHORT).show();
                        start();
                    }
                    else {
                        eventButton.setText(R.string.next_button);
                        countdown.setVisibility(View.INVISIBLE);

                        feedback.setText(R.string.wrong_text);
                        feedback.setVisibility(View.VISIBLE);
                        feedback.setTextColor(Color.RED);

                        instructionText.setVisibility(View.INVISIBLE);

                        correctAnswer.setText(vehicleBrandName);
                        correctAnswer.setTextColor(Color.YELLOW);
                        correctAnswer.setVisibility(View.VISIBLE);
                    }
                }
            }
        }.start();
    }


    public void submit(View view) {

        input = String.valueOf((userInput.getText())).toUpperCase();

        if(isCountdownRunning && incorrectAttemptCount < 3 && !input.equals("")){

           countDownTimer.cancel();
           startCountdown();
        }

        if(eventButton.getText().equals("Next")){
            Intent intent = new Intent(this, HintsActivity.class);
            finish();
            overridePendingTransition(0, 0);
            startActivity(intent);
            overridePendingTransition(0, 0);

            if(isCountdownRunning) {
                countDownTimer.cancel();
            }
        }
        else {
            checkUserInput();

            if(incorrectAttemptCount == 3){
                eventButton.setText(R.string.next_button);
                feedback.setText(R.string.wrong_text);
                feedback.setVisibility(View.VISIBLE);
                feedback.setTextColor(Color.RED);

                instructionText.setVisibility(View.INVISIBLE);

                correctAnswer.setText(vehicleBrandName);
                correctAnswer.setTextColor(Color.YELLOW);
                correctAnswer.setVisibility(View.VISIBLE);

                if(isCountdownRunning) {
                    countDownTimer.cancel();
                    countdown.setVisibility(View.INVISIBLE);
                }
            }
        }
    }


    public void checkUserInput(){
        count++;

        if(count == 1) {
            userCharacterList.addAll(characterList);
        }

        if(vehicleBrandName.contains(input)) {

            for(int i = 0; i < vehicleBrandName.length(); i++){

                String tempCharacter = String.valueOf(vehicleBrandName.charAt(i));

                if(userCharacterList.get(i).equals("_")) {

                    if (input.equals(tempCharacter)) {
                        userCharacterList.remove(i);
                        userCharacterList.add(i, input);
                        correctTrackCount++;
                    }
                }
            }
            StringBuilder formattedString = new StringBuilder();

            for (String character : userCharacterList) {
                formattedString.append(character).append(" ");
            }
            displayName.setText(formattedString.toString());

            if(correctTrackCount == userCharacterList.size()) {          // Check the guess is correct and display correct
                feedback.setText(R.string.correct_text);
                feedback.setTextColor(Color.GREEN);
                feedback.setVisibility(View.VISIBLE);
                eventButton.setText(R.string.next_button);

                instructionText.setVisibility(View.INVISIBLE);

                if(correctTrackCount == userCharacterList.size() && isCountdownRunning) {
                    countDownTimer.cancel();
                    countdown.setVisibility(View.INVISIBLE);
                }
            }
        }
        else {
            incorrectAttemptCount++;
            Toast.makeText(this, "Incorrect Guess! \n\n" + "Remaining attempts - " + (3 - incorrectAttemptCount), Toast.LENGTH_SHORT).show();
        }
    }


    public void setInitialText(){

        for(int i = 0; i < vehicleBrandName.length(); i++){
            characterList.add("_");
        }
         StringBuilder formattedString = new StringBuilder();
        for (String character : characterList) {
            formattedString.append(character).append(" ");
        }
        displayName.setText(formattedString.toString());
    }


    public void chooseBrand(String brand) {

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
    }


    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event){
        if ((keyCode == KeyEvent.KEYCODE_BACK)){

            finish();

            if(isCountdownRunning){
                countDownTimer.cancel();
            }
        }
        return super.onKeyDown(keyCode, event);
    }
}
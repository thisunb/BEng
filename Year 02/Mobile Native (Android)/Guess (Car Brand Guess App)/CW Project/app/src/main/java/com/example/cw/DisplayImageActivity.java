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
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;
import java.util.ArrayList;

public class DisplayImageActivity extends AppCompatActivity implements AdapterView.OnItemSelectedListener {

    private ArrayList<String> imageList = new ArrayList<>();                      // Defining List to store all images
    private static ArrayList<String> displayedCarList = new ArrayList<>();       // Defining List to store already displayed images

    private String response;
    private String vehicleBrandName;                                   // Variable for vehicle Brand

    private int clickCount = 0;                                               // Defining a variable for user click count
    private int counter = 20;

    private TextView answer;                                                // Defining all the TextViews
    private TextView displayResponse;
    private TextView countdown;
    private TextView instructionText;
    private TextView selectedItem;

    private Button option;                                                // Defining buttons
    public static CountDownTimer countDownTimer;
    public static boolean isCountdownRunning = false;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_display_image);

        ActionBar actionBar;                                         // Adding a custom color to Action bar
        actionBar = getSupportActionBar();
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#120917"));

        if (actionBar != null) {
            actionBar.setBackgroundDrawable(colorDrawable);
        }


        if (displayedCarList.size() != 30) {                         // Checking all the images are displayed

            for (int i = 1; i < 6; i++) {                          // Adding all the images to List
                imageList.add("a" + i);
                imageList.add("b" + i);
                imageList.add("f" + i);
                imageList.add("h" + i);
                imageList.add("t" + i);
                imageList.add("v" + i);
            }
                                                                                 // Defining the random number variable

            int randomNumber = (int) (Math.random() * (29 + 1) + 0);           // Generating a random number
                                                                              // Resource variable for image

            String resource = imageList.get(randomNumber);                   // Getting the images for selected random number
                                                                            // Checking the same image displayed again
            while (displayedCarList.contains(resource)) {

                randomNumber = (int) (Math.random() * (29 + 1) + 0);
                resource = imageList.get(randomNumber);
            }

            displayedCarList.add(resource);                        // Saving the currently displayed images to List

            ImageView v1 = findViewById(R.id.imageView);
                                                                  // Getting resource ids for image resources

            int resource_id = getResources().getIdentifier(resource, "drawable", "com.example.cw");
            v1.setImageResource(resource_id);

            chooseBrand(resource);                               // Sending resource to get the vehicle name

            Spinner spinner = findViewById(R.id.label_spinner);
            if (spinner != null) {
                spinner.setOnItemSelectedListener(this);
            }

            ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this,
                    R.array.brand_list, android.R.layout.simple_spinner_item);

            adapter.setDropDownViewResource (android.R.layout.select_dialog_singlechoice);

            if (spinner != null) {                                 // Apply the adapter to the spinner
                spinner.setAdapter(adapter);
            }
                                                                  // Defining TextViews, TextBoxes & Buttons
            selectedItem = findViewById(R.id.selected_brand);
            option = findViewById(R.id.button_identify);
            answer = findViewById(R.id.textView_answer);
            displayResponse = findViewById(R.id.textView_response);
            instructionText = findViewById(R.id.instruction);

            if (MainActivity.isChecked) {
                startCountdown();
            }
        }
        else {                                      // Changing activity to final activity after all images are displayed
            finish();
            Intent intent = new Intent(this, FinalActivity.class);
            System.out.println(displayedCarList);
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
                isCountdownRunning = false;
                countdown.setVisibility(View.INVISIBLE);
                verifyAnswer();

                clickCount++;
                clickCount++;
                option.setText(R.string.next_button);
            }
        }.start();
    }


    public void onItemSelected(View view) {

        clickCount++;
        if (clickCount == 1) {
            option.setText(R.string.next_button);
            verifyAnswer();
        } else if (clickCount > 1) {                                      // Refresh activity after current activity is finished
            refreshActivity();
        }
    }

                                                                         // Refresh activity
    public void refreshActivity() {
        finish();
        Intent refresh = new Intent(this, DisplayImageActivity.class);
        overridePendingTransition(0, 0);
        startActivity(refresh);
        overridePendingTransition(0, 0);
    }


    public void chooseBrand(String brand) {                             // Method for choosing the Correct Brand name

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


    public void verifyAnswer(){

        if (!response.equals("[SELECT BRAND]") || counter == 0) {

            if (response.equals(vehicleBrandName)) {
                answer.setText(R.string.correct_text);
                answer.setTextColor(Color.GREEN);

                instructionText.setVisibility(View.INVISIBLE);

                if (isCountdownRunning) {
                    countDownTimer.cancel();
                    countdown.setVisibility(View.INVISIBLE);
                }
            }
            else {
                answer.setText(R.string.wrong_text);
                answer.setTextColor(Color.RED);
                instructionText.setVisibility(View.INVISIBLE);

                if (isCountdownRunning) {
                    countDownTimer.cancel();
                    countdown.setVisibility(View.INVISIBLE);
                }

                displayResponse.setText(vehicleBrandName);
                displayResponse.setTextColor(Color.YELLOW);
                displayResponse.setVisibility(View.VISIBLE);
            }
            answer.setVisibility(View.VISIBLE);
        }
        else {
            Toast.makeText(this, "Select an appropriate Brand!", Toast.LENGTH_SHORT).show();
            option.setText(R.string.identify_button_text);
            clickCount--;
        }
    }

                                                               // Getting the user's spinner input
    @Override
    public void onItemSelected (AdapterView < ? > parent, View view,int position, long id){
        response = parent.getItemAtPosition(position).toString();
        ((TextView)view).setText(null);
        selectedItem.setText(response);
    }


    @Override
    public void onNothingSelected (AdapterView < ? > parent){}


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
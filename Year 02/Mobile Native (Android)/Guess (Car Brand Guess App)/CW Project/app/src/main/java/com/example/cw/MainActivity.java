package com.example.cw;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import android.annotation.SuppressLint;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.widget.Switch;

public class MainActivity extends AppCompatActivity{

    public static boolean isChecked;

    @SuppressLint("UseSwitchCompatOrMaterialCode")
    public Switch startCountDown;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        startCountDown = findViewById(R.id.switch1);

        ActionBar actionBar;                        // Adding a custom color to Action bar
        actionBar = getSupportActionBar();
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#1C032A"));

        if (actionBar != null) {
            actionBar.setBackgroundDrawable(colorDrawable);
        }
    }

    public void displayImage(View view){
        isChecked = startCountDown.isChecked();
        Intent intent = new Intent(this, DisplayImageActivity.class);
        startActivity(intent);
    }

    public void moveToHints(View view){
        isChecked = startCountDown.isChecked();
        Intent intent = new Intent(this, HintsActivity.class);
        startActivity(intent);
    }

    public void moveToIdentifyCarImage(View view){
        isChecked = startCountDown.isChecked();
        Intent intent = new Intent(this, IdentifyCarImageActivity.class);
        startActivity(intent);
    }

    public void moveToAdvancedLevel(View view){
        isChecked = startCountDown.isChecked();
        Intent intent = new Intent(this, AdvancedLevelActivity.class);
        startActivity(intent);
    }
}

                                                    // REFERENCES FOR CODE


   /*
      * Lecture Notes

      * Tutorials

      * Lecture Recordings

      * Reload an activity - https://stackoverflow.com/questions/3053761/reload-activity-in-android/6076299#:~:text=Start%20with%20an%20intent%20your,finish()%3B%20%2F%2Ffinish%20Activity.&text=Reloading%20your%20whole%20activity%20may%20be%20a%20heavy%20task

      * Create a countdown timer - https://abhiandroid.com/ui/countdown-timer

      * Refresh a timer - https://stackoverflow.com/questions/26232527/restart-or-refresh-a-timer-when-button-is-clicked-in-android

      * Add a rounded button - https://androideverywhere.com/tutorial/rounded-button-in-android-studio

      *  Add a border to a textView - https://stackoverflow.com/questions/3496269/how-do-i-put-a-border-around-an-android-textview#:~:text=Create%20a%20border%20view%20with,view%20inside%20the%20border%20view.

      * Change the popup box background color - https://stackoverflow.com/questions/16198666/how-to-change-a-spinners-list-background-color-in-android

      * Change the background color of element in drawable xml - https://stackoverflow.com/questions/16198666/how-to-change-a-spinners-list-background-color-in-android

      * Hide text in spinner selection - https://stackoverflow.com/questions/4931186/hide-text-of-android-spinner/12629047

      * Get the drawable in android - https://stackoverflow.com/questions/29041027/android-getresources-getdrawable-deprecated-api-22

      * How to set up the landscape orientation - https://stackoverflow.com/questions/18677421/android-relativelayout-in-scrollview

      * How to kill the activity when the back button is pressed - https://stackoverflow.com/questions/4778754/how-do-i-kill-an-activity-when-the-back-button-is-pressed

      * How to stop restarting the activity when the orientation changes - https://stackoverflow.com/questions/5913130/dont-reload-application-when-orientation-changes#:~:text=Just%20add%20android%3AconfigChanges%3D%22,t%20restart%20when%20orientation%20change.

      * How to add a Custom color to Title Bar - https://www.geeksforgeeks.org/how-to-change-the-color-of-action-bar-in-an-android-app/

      * Some extra Color Codes - https://htmlcolorcodes.com/

   */
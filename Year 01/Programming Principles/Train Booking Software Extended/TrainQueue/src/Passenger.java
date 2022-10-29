public class Passenger {

    private String firstName;           // Defining variables
    private String surName;
    private int secondsInQueue;
    private int randNum1;
    private int randNum2;
    private int randNum3;


    public String getName() {
        return firstName + " " + surName;          //-Concatenating the First name & Surname to produce "Name"---//
    }

    public void setName(String firstName, String surname) {
        this.firstName = firstName;
        this.surName = surname;
    }

    public void setSecondsInQueue(int randNum1, int randNum2, int randNum3) {
        this.randNum1 = randNum1;
        this.randNum2 = randNum2;
        this.randNum3 = randNum3;
    }

    public int getSeconds() {
        secondsInQueue = randNum1 + randNum2 + randNum3;        // Calculating Random generated processing Delay
        return secondsInQueue;
    }
}
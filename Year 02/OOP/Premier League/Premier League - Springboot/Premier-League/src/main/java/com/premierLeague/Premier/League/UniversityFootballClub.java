package com.premierLeague.Premier.League;

public class UniversityFootballClub extends FootballClub {

    private String universityName;                            // Creating instance variables for UniversityFootballClub
    private String universityLocation;

    public UniversityFootballClub() {                                               // Creating the default constructor

    }

    public String getUniversityName() {
        return universityName;
    }

    public void setUniversityName(String universityName) {
        this.universityName = universityName;
    }

    public String getUniversityLocation() {
        return universityLocation;
    }

    public void setUniversityLocation(String universityLocation) {
        this.universityLocation = universityLocation;
    }
}
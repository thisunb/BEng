package com.premierLeague.Premier.League;

public class SchoolFootballClub extends FootballClub{

    private String schoolName;                                    // Creating instance variables for schoolFootballClub
    private String schoolLocation;

    public SchoolFootballClub(){                                                    // Creating the default constructor

    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public String getSchoolLocation() {
        return schoolLocation;
    }

    public void setSchoolLocation(String schoolLocation) {
        this.schoolLocation = schoolLocation;
    }
}
package com.premierLeague.Premier.League;
import java.io.Serializable;

import org.springframework.stereotype.Component;

@Component
public class SportsClub implements Serializable {
                                                             // Creating instance variables to get FootballClub details
    private String clubName;
    private String clubType;
    private String location;

    public SportsClub(){                                                            // Creating the default constructor

    }

    public SportsClub (String clubName, String clubType, String location){           // Creating the second constructor
        this.clubName = clubName;
        this.clubType = clubType;
        this.location = location;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getClubType() {
        return clubType;
    }

    public void setClubType(String clubType) {
        this.clubType = clubType;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }


    @Override
    public String toString(){                                      // Creating the toString method to display the stats
        return "Club Name: "+ clubName + ", " +
                "Type: " + clubType + ", " +
                "Location: " + location;
    }
}
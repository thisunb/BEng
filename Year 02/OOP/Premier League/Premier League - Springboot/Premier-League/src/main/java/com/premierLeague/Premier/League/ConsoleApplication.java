package com.premierLeague.Premier.League;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

import java.awt.Desktop;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Scanner;

@SpringBootApplication
@RestController
@CrossOrigin("http://localhost:4200")

public class ConsoleApplication{

    @GetMapping("/")
    public String displayDefaultMessage(){

        return "Data Streaming links : http://localhost:8080/findMatchDetails, http://localhost:8080/sortByPoints," +
                " http://localhost:8080/sortByWins, http://localhost:8080/sortByGS";
    }


    @GetMapping("/findMatchDetails")                                            // Creating url to stream match details
    public ArrayList<MatchesPlayed> streamMatchDetails() {
                                                                                             // Sorting matches by date
        Collections.sort(PremierLeagueManager.matchesPlayed, new Comparator<MatchesPlayed>() {
            DateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");

            @Override
            public int compare(MatchesPlayed o1, MatchesPlayed o2) {
                try {
                    return dateFormat.parse(o1.getDate()).compareTo(dateFormat.parse(o2.getDate()));
                } catch (ParseException e) {
                    throw new IllegalArgumentException(e);
                }
            }
        });

        System.out.println("\n * All played matches so far: \n");

        for (int i = 0; i < PremierLeagueManager.matchesPlayed.size(); i++) {
            System.out.println(PremierLeagueManager.matchesPlayed.get(i) + "\n");
        }

        return PremierLeagueManager.matchesPlayed;                      // Returning all played match details to server
    }


    @GetMapping("/sortByPoints")                                                   // Creating url to stream club stats
    public ArrayList<FootballClub> sortByPoints() {
                                                                                             // Sorting teams by points
        Collections.sort(PremierLeagueManager.premierLeague, new Comparator<FootballClub>() {
            @Override
            public int compare(FootballClub fb1, FootballClub fb2) {
                if (fb1.getNoOfPoints() == fb2.getNoOfPoints()) {
                    return (fb2.getGoalDifference() - fb1.getGoalDifference());
                }
                return (fb2.getNoOfPoints()) - (fb1.getNoOfPoints());
            }
        });

        return PremierLeagueManager.premierLeague;          // Returning club stats (after sorting by points) to server
    }


    @GetMapping("/sortByWins")                                                     // Creating url to stream club stats
    public ArrayList<FootballClub> sortByWins() {
                                                                                                //Sorting teams by wins
        Collections.sort(PremierLeagueManager.premierLeague, new Comparator<FootballClub>() {
            @Override
            public int compare(FootballClub fb3, FootballClub fb4) {

                return (fb4.getNoOfWins()) - (fb3.getNoOfWins());
            }
        });

        return PremierLeagueManager.premierLeague;            // Returning club stats (after sorting by wins) to server
    }


    @GetMapping("/sortByGS")                                                       // Creating url to stream club stats
    public ArrayList<FootballClub> sortByGs() {
                                                                                       // Sorting teams by goals scored
        Collections.sort(PremierLeagueManager.premierLeague, new Comparator<FootballClub>() {
            @Override
            public int compare(FootballClub fb1, FootballClub fb2) {

                return (fb2.getNoOfGoalsScored()) - (fb1.getNoOfGoalsScored());
            }
        });

        return PremierLeagueManager.premierLeague;           // Returning club stats (sorted by goals scored) to server
    }


    @GetMapping("/randomMatch")                                          // Creating url to stream random match details
    public MatchesPlayed randomMatch() {

        if(PremierLeagueManager.premierLeague.size() > 1) {
            int year = 0;                                                                   // initialising date values
            int month = 0;
            int day = 0;

            Date date = new Date(year, month, day);                                   // Getting date as a random value

            date.dateCheckGui();                                                 // Validating the randomly chosen date

            int maxAvailClubNumber = PremierLeagueManager.premierLeague.size();

            int club1RandomIndex = (int) (Math.random() * ((maxAvailClubNumber - 1) + 1) + 0);

            int club2RandomIndex = (int) (Math.random() * ((maxAvailClubNumber - 1) + 1) + 0);

                                             // Avoid choosing the same first club as the second club to play the match
            while (true) {
                if (club1RandomIndex != club2RandomIndex) {
                    break;
                } else {
                    club2RandomIndex = (int) (Math.random() * ((maxAvailClubNumber - 1) + 1) + 0);
                }
            }


            FootballClub club1 = (PremierLeagueManager.premierLeague.get(club1RandomIndex));
            String clubName1 = club1.getClubName();

            FootballClub club2 = (PremierLeagueManager.premierLeague.get(club2RandomIndex));
            String clubName2 = club2.getClubName();

            int goalsScored1 = (int) (Math.random() * 10 + 0);
            int goalsScored2 = (int) (Math.random() * 10 + 0);

                                                                                              // Updating Team 01 stats
            FootballClub fb = new FootballClub();
            fb.setClubName(clubName1);
            fb.setNoOfGoalsScored(goalsScored1);


            club1.setNoOfGoalsScored(club1.getNoOfGoalsScored() + goalsScored1);
            club1.setNoOfGoalsAgainst(club1.getNoOfGoalsAgainst() + goalsScored2);
            club1.setNoOfMatches(club1.getNoOfMatches() + 1);
            club1.setGoalDifference(club1.getNoOfGoalsScored() - club1.getNoOfGoalsAgainst());


            if (goalsScored1 > goalsScored2) {

                club1.setNoOfWins(club1.getNoOfWins() + 1);
                club1.setNoOfPoints(club1.getNoOfPoints() + 3);
            }
            else if (goalsScored1 < goalsScored2) {

                club1.setNoOfDefeats(club1.getNoOfDefeats() + 1);
            }
            else {
                club1.setNoOfDraws(club1.getNoOfDraws() + 1);
                club1.setNoOfPoints(club1.getNoOfPoints() + 1);
            }
                                                                                              // Updating Team 02 stats
            fb.setClubName(clubName2);
            fb.setNoOfGoalsScored(goalsScored2);


            club2.setNoOfGoalsScored(club2.getNoOfGoalsScored() + goalsScored2);
            club2.setNoOfGoalsAgainst(club2.getNoOfGoalsAgainst() + goalsScored1);
            club2.setNoOfMatches(club2.getNoOfMatches() + 1);
            club2.setGoalDifference(club2.getNoOfGoalsScored() - club2.getNoOfGoalsAgainst());

            if (goalsScored2 > goalsScored1) {

                club2.setNoOfWins(club2.getNoOfWins() + 1);
                club2.setNoOfPoints(club2.getNoOfPoints() + 3);
            }
            else if (goalsScored2 < goalsScored1) {

                club2.setNoOfDefeats(club2.getNoOfDefeats() + 1);
            }
            else {
                club2.setNoOfDraws(club2.getNoOfDraws() + 1);
                club2.setNoOfPoints(club2.getNoOfPoints() + 1);
            }
                                                          // Updating match details and displaying random match details

            MatchesPlayed mp = new MatchesPlayed(date.toString(), clubName1, clubName2, goalsScored1, goalsScored2);
            PremierLeagueManager.matchesPlayed.add(mp);
            System.out.println("\n * Last played Random Match Details: \n");
            System.out.println(mp + "\n");


            PremierLeagueManager pr = new PremierLeagueManager();
            try {                                                        // Saving updated match & club details to file
                pr.saveData();
            } catch (IOException e) {
                e.printStackTrace();
            }

            return mp;                                                      // Returning random match details to server
        }
        else {                                                                    // Returning default values to server

            return new MatchesPlayed(null,null,null, 0, 0);
        }
    }


    public static void main(String[] args) {

        boolean guiEvent = true;                                                  // Variable declaration for GUI event

        PremierLeagueManager pr = new PremierLeagueManager();                 // Creating an object to access the class

        try {                                                      // Loading club & match details from file on startup
            pr.loadData();
        } catch (IOException | ClassNotFoundException e) {
            System.out.println("No previously saved data found. Loaded Main Menu.\n");
        }

        Scanner sc = new Scanner(System.in);

        System.out.println("* Please enter the club type: ");                                 // Checking the club type
        String clubType = sc.nextLine().toUpperCase();

        while (true) {                                                                               // Displaying menu

            if (clubType.equals("FOOTBALL")) {
                System.out.println("\n---------Premier League Manager---------");

                System.out.println("* Enter 1 to create and add a new football club to Premier League.");
                System.out.println("* Enter 2 to delete a football club from Premier League.");
                System.out.println("* Enter 3 to display various statistics for a club.");
                System.out.println("* Enter 4 to display the Premier League table.");
                System.out.println("* Enter 5 to add a played match with its score and date.");
                System.out.println("* Enter 6 to save the entered information.");
                System.out.println("* Enter 7 to display GUI.");
                System.out.println("* Enter 8 to exit.");

                System.out.println("\nEnter your choice: ");

                String choice = sc.nextLine();

                switch (choice) {

                    case "1":
                        pr.addClub();
                        break;

                    case "2":
                        pr.deleteClub();
                        break;

                    case "3":
                        pr.displayStats();
                        break;

                    case "4":
                        pr.displayTable();
                        break;

                    case "5":
                        pr.enterMatchPlayed();
                        break;

                    case "6":                                            // saving the match and club details to a file
                        try {
                            pr.saveData();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        break;

                    case "7":
                        Desktop desktop = Desktop.getDesktop();               // Launching web application from browser
                        System.out.println("Do you want to open the Web Application from browser? (Y/N)");
                        String userChoice = sc.nextLine().toUpperCase();

                        while (true) {
                            if (userChoice.equals("Y")) {

                                try {
                                    URI url = new URI("http://localhost:4200/");
                                    desktop.browse(url);
                                    System.out.println("Web Application has been launched!\n");
                                } catch (URISyntaxException | IOException e) {
                                    e.printStackTrace();
                                }
                                break;
                            }
                            else if(userChoice.equals("N")){
                                break;
                            }
                            else {
                                System.out.println("Invalid input! Please enter a valid input.(Y/N)");
                                userChoice = sc.nextLine().toUpperCase();
                            }
                        }

                        System.out.println("Do you want to start Spring Boot Server? (Y/N)");
                        String userChoice2 = sc.nextLine().toUpperCase();

                        while(true) {
                            if (userChoice2.equals("Y")) {                               // Launching SpringBoot Server
                                if (guiEvent) {
                                    System.out.println("Spring Boot server is starting...");
                                    SpringApplication.run(ConsoleApplication.class);
                                    System.out.println("\nSpring Boot server has started!");
                                    guiEvent = false;
                                }
                                else {
                                    System.out.println("Spring Boot Server is already running!");
                                }
                                break;
                            }
                            else if(userChoice2.equals("N")){
                                break;
                            }
                            else {
                                System.out.println("Invalid input! Please enter a valid input.(Y/N)");
                                userChoice2 = sc.nextLine().toUpperCase();
                            }
                        }
                        break;

                    case "8":
                        System.exit(0);

                    default:
                        System.out.println("Invalid input! Please enter a valid input.\n");
                }
            }                                                                                // Verifying the club type
            else {
                System.out.println("Invalid input or no other club types available right now.\n");
                System.out.println("Available club type:");
                System.out.println(" * Football \n");

                System.out.println("* Please enter the club type: ");
                clubType = sc.nextLine().toUpperCase();
            }
        }
    }
}
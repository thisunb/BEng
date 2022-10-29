package com.premierLeague.Premier.League;
import java.io.*;
import java.util.*;

import org.springframework.stereotype.Component;

@Component
public class PremierLeagueManager implements LeagueManager {

    public static ArrayList<FootballClub> premierLeague = new ArrayList<>();          // Creating an ArrayList to store
                                                                                              // club stats temporarily
    public static ArrayList<MatchesPlayed> matchesPlayed = new ArrayList<>();         // Creating an ArrayList to store
                                                                                           // match details temporarily

    @Override
    public void addClub() {
        while (true) {

            if (premierLeague.size() != 20) {                              // Setting the limit for max number of clubs
                Scanner sc = new Scanner(System.in);

                System.out.println("Enter the football club name: ");
                String clubName = sc.nextLine().toUpperCase();

                ArrayList <String> checkClubs = new ArrayList<>();           // Creating an ArrayList to store only the
                                                                                 // club names temporary for validation
                for (int i = 0; i < premierLeague.size(); i++) {

                    FootballClub club = premierLeague.get(i);
                    checkClubs.add(club.getClubName());
                }
                                                                                      // Checking the entered club name
                while(true) {                                                                  //is already in the list
                    if (checkClubs.contains(clubName)) {
                        System.out.println("The club entered is already in the premier league.\n");
                        System.out.println("Enter another football club name: ");
                        clubName = sc.nextLine().toUpperCase();
                    }
                    else if(clubName.equals("")){                                       // Checking for incorrect input
                        System.out.println("Invalid input.");
                        System.out.println("Enter a football club name: ");
                        clubName = sc.nextLine().toUpperCase();
                    }
                    else {
                        break;
                    }
                }

                System.out.println("Enter the club location (Enter the city name): ");
                String clubLocation = sc.nextLine().toUpperCase();

                while(clubLocation.equals("")){                                         // Checking user enters a value
                    System.out.println("Invalid Input.");
                    System.out.println("Enter the club location (Enter the city name): ");
                    clubLocation = sc.nextLine().toUpperCase();
                }

                String clubType = "FOOTBALL";                              // Setting team stats for its default values
                int matches = 0;
                int wins = 0;
                int draws = 0;
                int defeats = 0;
                int goalsScored = 0;
                int goalsAgainst = 0;
                int goalDifference = 0;
                int points = 0;                                                      // Adding club details to the list

                System.out.println(clubName + " club has been created successfully.\n");
                System.out.println("Do you want to add " + clubName + " to premier league? (Y/N)");
                String choice = sc.nextLine().toUpperCase();

                while (true) {
                    if (choice.equals("Y")) {

                        FootballClub fb = new FootballClub(clubName, clubType, clubLocation, matches, wins, draws,
                                defeats, goalsScored, goalsAgainst, goalDifference, points);
                        premierLeague.add(fb);

                        System.out.println("\n" + fb.getClubName() + " club has been added to Premier League.\n");
                        System.out.println(" * Added club details: \n");
                        System.out.println(fb + "\n");

                        break;
                    }
                    else if (choice.equals("N")) {

                        System.out.println(clubName + " club has not been added to premier league. ");
                        break;
                    }
                    else {

                        System.out.println("Invalid input. Please enter a valid input: ");
                        choice = sc.nextLine().toUpperCase();
                    }
                }
            }
            else{
                System.out.println("No available slots. Maximum of 20 football clubs are already included.");
            }
            break;
        }
    }


    @Override
    public void deleteClub() {

        if(premierLeague.size() != 0) {                                       // Checking there are any clubs to delete

            Scanner sc = new Scanner(System.in);
            System.out.println("Enter club name to delete: ");
            String clubName = sc.nextLine().toUpperCase();

            FootballClub fb = new FootballClub();
            fb.setClubName(clubName);

            ArrayList<String> checkClubs = new ArrayList<>();                // Creating an ArrayList to store only the
                                                                                 // club names temporary for validation
            for (FootballClub club : premierLeague) {

                checkClubs.add(club.getClubName());
            }

            while (true) {
                if (checkClubs.contains(fb.getClubName())) {             // Checking the entered club name is available
                                                                                                         // in the list
                    for (int i = 0; i < premierLeague.size(); i++) {

                        FootballClub club = (premierLeague.get(i));

                        if (club.getClubName().equals(fb.getClubName())) {

                            System.out.println("Do you really want to delete " + fb.getClubName() + " from the" +
                                    " premier league? (Y/N)");
                            String choice =  sc.nextLine().toUpperCase();

                            while(true) {
                                if (choice.equals("Y")) {
                                    System.out.println("\n" + club.getClubName() + " club has been removed from " +
                                            "premier league.\n");
                                    premierLeague.remove(premierLeague.get(i));

                                    System.out.println(" * Remaining list of clubs in premier league: ");

                                    for (int j = 0; j < premierLeague.size(); j++) {

                                        FootballClub remainingClubs = premierLeague.get(j);
                                        System.out.println(remainingClubs.getClubName());
                                    }

                                    System.out.println("\n * Remaining free slots: " + (20 - premierLeague.size())
                                            + "\n");
                                    break;
                                }
                                else if (choice.equals("N")){

                                    System.out.println(fb.getClubName() + " club has not been deleted from " +
                                            "the premier league.\n");

                                    System.out.println(" * The list of clubs available in the premier league: ");

                                    for (int j = 0; j < premierLeague.size(); j++) {

                                        FootballClub remainingClubs = premierLeague.get(j);
                                        System.out.println(remainingClubs.getClubName());
                                    }

                                    System.out.println("\n * Remaining free slots: " + (20 - premierLeague.size())
                                            + "\n");
                                    break;
                                }
                                else {
                                    System.out.println("Invalid input. Please enter a valid input:");
                                    choice = sc.nextLine().toUpperCase();
                                }
                            }
                        }
                    }
                    break;
                }
                else if(fb.getClubName().equals("")){

                    System.out.println("Invalid input.\n");
                    System.out.println("Enter a valid club name to delete from Premier League.");
                    clubName = sc.nextLine().toUpperCase();
                    fb.setClubName(clubName);
                }
                else {

                    System.out.println("No matches found.\n");
                    System.out.println("Enter club name to delete: ");
                    clubName = sc.nextLine().toUpperCase();
                    fb.setClubName(clubName);
                }
            }
        }
        else {
            System.out.println("No clubs available to delete. Add a club to premier league first.\n");
        }
    }


    @Override
    public void displayStats() {

        if(premierLeague.size() != 0) {                                // Checking there are any clubs to display stats

            ArrayList<String> checkClubs = new ArrayList<>();           // Creating an ArrayList to store only the club
                                                                                      // names temporary for validation
            for (int i = 0; i < premierLeague.size(); i++) {

                FootballClub club = premierLeague.get(i);
                checkClubs.add(club.getClubName());
            }

            Scanner sc = new Scanner(System.in);
            System.out.println("Enter club name to display statistics: ");

            String clubName = sc.nextLine().toUpperCase();

            FootballClub fb = new FootballClub();
            fb.setClubName(clubName);
                                                             // Checking the entered club name is available in the list
            while (true) {
                if (checkClubs.contains(fb.getClubName())) {

                    for (int i = 0; i < premierLeague.size(); i++) {

                        FootballClub club = (premierLeague.get(i));

                        if (club.getClubName().equals(fb.getClubName())) {
                            System.out.println("\n * The selected club details: \n\n" + club + "\n");
                            break;
                        }
                    }
                    break;
                }
                else if (fb.getClubName().equals("")) {

                    System.out.println("Invalid Input.\n");
                    System.out.println("Enter a valid Club Name to display stats.");
                    clubName = sc.nextLine().toUpperCase();
                    fb.setClubName(clubName);
                }
                else {

                    System.out.println("No matches found.\n");
                    System.out.println("Enter a Club Name to display stats.");
                    clubName = sc.nextLine().toUpperCase();
                    fb.setClubName(clubName);
                }
            }
        }
        else{
            System.out.println("No clubs available to display stats.\n");
        }
    }


    @Override
    public void displayTable(){

        if(premierLeague.size() != 0) {                 // Checking there are any clubs available to display in a table
            sortAccordingToPoints();

            System.out.println(" \n* Premier League Table: \n");

            for (FootballClub footballClub : premierLeague) {
                System.out.println(footballClub + "\n");
            }
        }
        else {
            System.out.println("No clubs available to display the Premier League table.\n");
        }
    }


    @Override
    public void enterMatchPlayed(){

        ArrayList <String> checkClubs = new ArrayList<>();                   // Creating an ArrayList to store only the
                                                                                 // club names temporary for validation
        for(int i = 0; i < premierLeague.size(); i++){
            FootballClub club = premierLeague.get(i);
            checkClubs.add(club.getClubName());
        }

        if(premierLeague.size() > 1) {                                    // Checking the min number of clubs available
                                                                                                     // to play a match
            Scanner sc = new Scanner(System.in);

            int year = 0;                                                                // Initialising date variables
            int month = 0;
            int day = 0;

            System.out.println("Enter Date of the match played: ");

            Date date = new Date(year,month,day);                                             // Getting the Date input

            date.dateCheckConsole();                                                       // Validating the date input

            System.out.println("\nEnter the team names, scores of the match...\n");

            System.out.println("Enter Team 01 name: ");
            String clubName1 = sc.nextLine().toUpperCase();

            while(true) {
                if (!checkClubs.contains(clubName1)) {
                    System.out.println("The club entered is currently not in the Premier League.\n");
                    System.out.println("Enter a club name which is in the Premier League: ");
                    clubName1 = sc.nextLine().toUpperCase();
                }
                else {
                    break;
                }
            }

            boolean loop = true;

            int goalsScored1 = 0;

            while (loop){

                try{
                    System.out.println("Enter goals scored: ");
                    goalsScored1 = sc.nextInt();
                    loop = false;
                }

                catch (InputMismatchException e){
                    System.out.println("Invalid Input.\n");
                    sc.nextLine();
                }
            }

            sc.nextLine();

            System.out.println("Enter Team 02 name: ");
            String clubName2 = sc.nextLine().toUpperCase();

            while(true) {
                                                                       // Checking the entered club name is in the list
                if (!checkClubs.contains(clubName2)) {
                    System.out.println("The club entered is currently not in the Premier League.\n");
                    System.out.println("Enter a club name which is in the Premier League: ");
                    clubName2 = sc.nextLine().toUpperCase();
                }
                                                                          // Avoid choosing the same team for the match
                else if(clubName1.equals(clubName2)){
                    System.out.println(clubName1 + " is already selected for this match.\n");
                    System.out.println("Enter a different club: ");
                    clubName2 = sc.nextLine().toUpperCase();
                }
                else {
                    break;
                }
            }

            loop = true;

            int goalsScored2 = 0;

            while (loop){

                try{
                    System.out.println("Enter goals scored: ");
                    goalsScored2 = sc.nextInt();
                    loop = false;
                }

                catch (InputMismatchException e){
                    System.out.println("Invalid Input.\n");
                    sc.nextLine();
                }
            }

            FootballClub fb = new FootballClub();
            fb.setClubName(clubName1);
            fb.setNoOfGoalsScored(goalsScored1);

                                                                                              // Updating Team 01 stats
            for (int i = 0; i < premierLeague.size(); i++) {

                FootballClub club = (premierLeague.get(i));

                if (club.getClubName().equals(fb.getClubName())) {

                    club.setNoOfGoalsScored(club.getNoOfGoalsScored() + goalsScored1);
                    club.setNoOfGoalsAgainst(club.getNoOfGoalsAgainst() + goalsScored2);
                    club.setNoOfMatches(club.getNoOfMatches() + 1);
                    club.setGoalDifference(club.getNoOfGoalsScored() - club.getNoOfGoalsAgainst());


                    if (goalsScored1 > goalsScored2) {

                        club.setNoOfWins(club.getNoOfWins() + 1);
                        club.setNoOfPoints(club.getNoOfPoints() + 3);
                    } else if (goalsScored1 < goalsScored2) {

                        club.setNoOfDefeats(club.getNoOfDefeats() + 1);
                    } else {

                        club.setNoOfDraws(club.getNoOfDraws() + 1);
                        club.setNoOfPoints(club.getNoOfPoints() + 1);
                    }
                }
            }

            fb.setClubName(clubName2);
            fb.setNoOfGoalsScored(goalsScored2);

                                                                                              // Updating Team 02 stats
            for (int i = 0; i < premierLeague.size(); i++) {

                FootballClub club = (premierLeague.get(i));

                if (club.getClubName().equals(fb.getClubName())) {

                    club.setNoOfGoalsScored(club.getNoOfGoalsScored() + goalsScored2);
                    club.setNoOfGoalsAgainst(club.getNoOfGoalsAgainst() + goalsScored1);
                    club.setNoOfMatches(club.getNoOfMatches() + 1);
                    club.setGoalDifference(club.getNoOfGoalsScored() - club.getNoOfGoalsAgainst());


                    if (goalsScored2 > goalsScored1) {

                        club.setNoOfWins(club.getNoOfWins() + 1);
                        club.setNoOfPoints(club.getNoOfPoints() + 3);
                    } else if (goalsScored2 < goalsScored1) {

                        club.setNoOfDefeats(club.getNoOfDefeats() + 1);
                    } else {

                        club.setNoOfDraws(club.getNoOfDraws() + 1);
                        club.setNoOfPoints(club.getNoOfPoints() + 1);
                    }
                }
            }
                                                                                          // Adding stats to match list

            MatchesPlayed mp = new MatchesPlayed(date.toString(), clubName1, clubName2, goalsScored1, goalsScored2);
            matchesPlayed.add(mp);

            System.out.println("\n * Played match details: \n");
            System.out.println(mp + "\n");
        }
        else {
            System.out.println("At least 2 clubs are required to play a random Match. Add more clubs.\n");
        }
    }


    @Override
    public void saveData() throws IOException{                                // Adding all team details to a text file

        FileOutputStream fileOutputStream1 = new FileOutputStream("Premier League Details.txt");
        ObjectOutputStream objectOutputStream1 = new ObjectOutputStream(fileOutputStream1);

        for(FootballClub footballClub : premierLeague){
            objectOutputStream1.writeObject(footballClub);
        }
                                                                             // Adding all match details to a text file

        FileOutputStream fileOutputStream2 = new FileOutputStream("Played Matches Details.txt");
        ObjectOutputStream objectOutputStream2 = new ObjectOutputStream(fileOutputStream2);

        for(MatchesPlayed matchesPlayed : matchesPlayed){
            objectOutputStream2.writeObject(matchesPlayed);
        }
        System.out.println("Data stored to file successfully.\n");
    }


    @Override
    public void loadData() throws IOException, ClassNotFoundException{

                                                                      // Retrieving all team details from the text file

        FileInputStream fileInputStream1 = new FileInputStream("Premier League Details.txt");
        ObjectInputStream objectInputStream1 = new ObjectInputStream(fileInputStream1);

        for(;;){
            try{
                premierLeague.add((FootballClub)objectInputStream1.readObject());
            }
            catch (EOFException e){
                break;
            }
        }

                                                                     // Retrieving all match details from the text file

        FileInputStream fileInputStream2 = new FileInputStream("Played Matches Details.txt");
        ObjectInputStream objectInputStream2 = new ObjectInputStream(fileInputStream2);

        for(;;){
            try{
                matchesPlayed.add((MatchesPlayed) objectInputStream2.readObject());
            }
            catch (EOFException e){
                break;
            }
        }
        System.out.println("Data loaded from file successfully.\n");
    }


    public void sortAccordingToPoints(){                         // Sorting teams by points method in console Component

        Collections.sort(premierLeague, new Comparator<FootballClub>() {
            @Override
            public int compare(FootballClub fb1, FootballClub fb2) {
                if (fb1.getNoOfPoints() == fb2.getNoOfPoints()) {
                    return (fb2.getGoalDifference() - fb1.getGoalDifference());
                }
                return (fb2.getNoOfPoints())-(fb1.getNoOfPoints());
            }
        });
    }
}
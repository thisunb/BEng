import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.*;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class GUI extends Application {

    public static Stage startProgram = new Stage();

    @Override
    public void start(Stage startProgram) {

    }

    public void gui() {

        ConsoleApplication.guiEventCheck = "";                                // Resetting the gui event check variable

        // Creating GUI

        VBox numberList = new VBox();                                                   // Adding topic for number list
        Button number = new Button("Number");
        number.setPrefSize(90,50);
        number.setStyle("-fx-text-fill: white; -fx-background-color: #13280D;");
        number.setPadding(new Insets(10, 0, 0, 10));
        numberList.getChildren().add(number);

        for (int i = 1; i <= 20; i = i + 1) {                                              // Adding number list (1-20)

            Button numbering = new Button(String.valueOf(i));
            numbering.setPrefSize(90,45);
            numbering.setStyle("-fx-text-fill: white; -fx-background-color: #13280D;");
            numbering.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            numbering.setPadding(new Insets(0, 0, 0, 10));
            numberList.getChildren().add(numbering);
        }


        VBox clubNameList = new VBox();                                                       // Adding topic name list
        Button clubName = new Button("Name");
        clubName.setPrefSize(180,50);
        clubName.setStyle("-fx-text-fill: white; -fx-background-color: #13280D;");
        clubName.setPadding(new Insets(10, 0, 0, 10));
        clubNameList.getChildren().add(clubName);
                                                                                               // Adding club name list
        for (int i = 0; i < PremierLeagueManager.premierLeague.size(); i = i + 1) {

            FootballClub club = PremierLeagueManager.premierLeague.get(i);
            Button name = new Button(club.getClubName());
            name.setTooltip(new Tooltip(club.getClubName()));
            name.setPrefSize(180,45);
            name.setStyle("-fx-text-fill: white; -fx-background-color: #1B0728;");
            name.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            name.setPadding(new Insets(0, 0, 0, 10));
            clubNameList.getChildren().add(name);
        }
                                                                      // Adding "-" marks to denote data unavailability

        for (int i = 0; i < 20 - PremierLeagueManager.premierLeague.size(); i = i + 1) {

            Button name = new Button("-");
            name.setTooltip(new Tooltip("No Data available"));
            name.setPrefSize(180,45);
            name.setStyle("-fx-text-fill: white; -fx-background-color: #1B0728;");
            name.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            name.setPadding(new Insets(0, 0, 0, 10));
            clubNameList.getChildren().add(name);
        }


        VBox locationList = new VBox();                                                   // Adding club location topic
        Button location = new Button("Location");
        location.setPrefSize(180,50);
        location.setPadding(new Insets(10, 0, 0, 10));
        location.setStyle("-fx-text-fill: white; -fx-background-color: #13280D;");
        locationList.getChildren().add(location);
                                                                                     // Adding club location for a club

        for (int i = 0; i < PremierLeagueManager.premierLeague.size(); i = i + 1) {

            FootballClub club = PremierLeagueManager.premierLeague.get(i);
            Button locations = new Button(club.getLocation());
            locations.setTooltip(new Tooltip(club.getLocation()));
            locations.setPrefSize(180,45);
            locations.setStyle("-fx-text-fill: white; -fx-background-color: #280026;");
            locations.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            locations.setPadding(new Insets(0, 0, 0, 10));
            locationList.getChildren().add(locations);
        }
                                                                      // Adding "-" marks to denote data unavailability

        for (int i = 0; i < 20 - PremierLeagueManager.premierLeague.size(); i = i + 1) {

            Button locations= new Button("-");
            locations.setTooltip(new Tooltip("No Data available"));
            locations.setPrefSize(180,45);
            locations.setStyle("-fx-text-fill: white; -fx-background-color: #280026;");
            locations.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            locations.setPadding(new Insets(0, 0, 0, 10));
            locationList.getChildren().add(locations);
        }


        VBox matchesList = new VBox();                                                   // Adding matches played topic
        Button matches = new Button("Matches");
        matches.setPrefSize(100,50);
        matches.setPadding(new Insets(10, 0, 0, 10));
        matches.setStyle("-fx-text-fill: white; -fx-background-color: #13280D;");
        matchesList.getChildren().add(matches);
                                                                                     // Adding number of matches played

        for (int i = 0; i < PremierLeagueManager.premierLeague.size(); i = i + 1) {

            FootballClub club = PremierLeagueManager.premierLeague.get(i);

            Button match = new Button(String.valueOf(club.getNoOfMatches()));
            match.setPrefSize(100,45);
            match.setStyle("-fx-text-fill: white; -fx-background-color: #1B0728;");
            match.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            match.setPadding(new Insets(0, 0, 0, 10));
            matchesList.getChildren().add(match);
        }
                                                                      // Adding "-" marks to denote data unavailability

        for (int i = 0; i < 20 - PremierLeagueManager.premierLeague.size(); i = i + 1) {

            Button match = new Button("-");
            match.setTooltip(new Tooltip("No Data available"));
            match.setPrefSize(100,45);
            match.setStyle("-fx-text-fill: white; -fx-background-color: #1B0728;");
            match.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            match.setPadding(new Insets(0, 0, 0, 10));
            matchesList.getChildren().add(match);
        }


        VBox winsList = new VBox();                                                       // Adding topic for win count
        Button wins  = new Button("Wins");
        wins.setPrefSize(100,50);
        wins.setPadding(new Insets(10, 0, 0, 10));
        wins.setStyle("-fx-text-fill: white; -fx-background-color: #13280D;");
        winsList.getChildren().add(wins);
                                                                                    // Adding number of wins for a club

        for (int i = 0; i < PremierLeagueManager.premierLeague.size(); i = i + 1) {

            FootballClub club = PremierLeagueManager.premierLeague.get(i);
            Button win = new Button(String.valueOf(club.getNoOfWins()));
            win.setPrefSize(100,45);
            win.setStyle("-fx-text-fill: white; -fx-background-color: #280026;");
            win.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            win.setPadding(new Insets(0, 0, 0, 10));
            winsList.getChildren().add(win);
        }
                                                                      // Adding "-" marks to denote data unavailability

        for (int i = 0; i < 20 - PremierLeagueManager.premierLeague.size(); i = i + 1) {

            Button win = new Button("-");
            win.setTooltip(new Tooltip("No Data available"));
            win.setPrefSize(100,45);
            win.setStyle("-fx-text-fill: white; -fx-background-color: #280026;");
            win.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            win.setPadding(new Insets(0, 0, 0, 10));
            winsList.getChildren().add(win);
        }


        VBox drawsList = new VBox();                                                // Adding topic for number of draws
        Button draws  = new Button("Draws");
        draws.setPrefSize(100,50);
        draws.setPadding(new Insets(10, 0, 0, 10));
        draws.setStyle("-fx-text-fill: white; -fx-background-color: #13280D;");
        drawsList.getChildren().add(draws);
                                                                                   // Adding number of draws for a club

        for (int i = 0; i < PremierLeagueManager.premierLeague.size(); i = i + 1) {

            FootballClub club = PremierLeagueManager.premierLeague.get(i);
            Button draw = new Button(String.valueOf(club.getNoOfDraws()));
            draw.setPrefSize(100,45);
            draw.setStyle("-fx-text-fill: white; -fx-background-color: #1B0728;");
            draw.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            draw.setPadding(new Insets(0, 0, 0, 10));
            drawsList.getChildren().add(draw);
        }
                                                                      // Adding "-" marks to denote data unavailability

        for (int i = 0; i < 20 - PremierLeagueManager.premierLeague.size(); i = i + 1) {

            Button draw = new Button("-");
            draw.setTooltip(new Tooltip("No Data available"));
            draw.setPrefSize(100,45);
            draw.setStyle("-fx-text-fill: white; -fx-background-color: #1B0728;");
            draw.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            draw.setPadding(new Insets(0, 0, 0, 10));
            drawsList.getChildren().add(draw);
        }


        VBox defeatsList = new VBox();                                            // Adding topic for number of defeats
        Button defeats  = new Button("Defeats");
        defeats.setPrefSize(100,50);
        defeats.setPadding(new Insets(10, 0, 0, 10));
        defeats.setStyle("-fx-text-fill: white; -fx-background-color: #13280D;");
        defeatsList.getChildren().add(defeats);
                                                                                 // Adding number of defeats for a club

        for (int i = 0; i < PremierLeagueManager.premierLeague.size(); i = i + 1) {

            FootballClub club = PremierLeagueManager.premierLeague.get(i);
            Button defeat = new Button(String.valueOf(club.getNoOfDefeats()));
            defeat.setPrefSize(100,45);
            defeat.setStyle("-fx-text-fill: white; -fx-background-color: #280026;");
            defeat.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            defeat.setPadding(new Insets(0, 0, 0, 10));
            defeatsList.getChildren().add(defeat);
        }
                                                                      // Adding "-" marks to denote data unavailability

        for (int i = 0; i < 20 - PremierLeagueManager.premierLeague.size(); i = i + 1) {

            Button defeat = new Button("-");
            defeat.setTooltip(new Tooltip("No Data available"));
            defeat.setPrefSize(100,45);
            defeat.setStyle("-fx-text-fill: white; -fx-background-color: #280026;");
            defeat.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            defeat.setPadding(new Insets(0, 0, 0, 10));
            defeatsList.getChildren().add(defeat);
        }

                                                                             // Adding topic for number of goals scored
        VBox goalsScoredList = new VBox();
        Button goalsScored  = new Button("GS");
        goalsScored.setPrefSize(100,50);
        goalsScored.setPadding(new Insets(10, 0, 0, 10));
        goalsScored.setStyle("-fx-text-fill: white; -fx-background-color: #13280D;");
        goalsScoredList.getChildren().add(goalsScored);
                                                                            // Adding number of goals scored for a club

        for (int i = 0; i < PremierLeagueManager.premierLeague.size(); i = i + 1) {

            FootballClub club = PremierLeagueManager.premierLeague.get(i);
            Button gScored = new Button(String.valueOf(club.getNoOfGoalsScored()));
            gScored.setPrefSize(100,45);
            gScored.setStyle("-fx-text-fill: white; -fx-background-color: #1B0728;");
            gScored.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            gScored.setPadding(new Insets(0, 0, 0, 10));
            goalsScoredList.getChildren().add(gScored);
        }
                                                                      // Adding "-" marks to denote data unavailability

        for (int i = 0; i < 20 - PremierLeagueManager.premierLeague.size(); i = i + 1) {

            Button gScored = new Button("-");
            gScored.setTooltip(new Tooltip("No Data available"));
            gScored.setPrefSize(100,45);
            gScored.setStyle("-fx-text-fill: white; -fx-background-color: #1B0728;");
            gScored.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            gScored.setPadding(new Insets(0, 0, 0, 10));
            goalsScoredList.getChildren().add(gScored);
        }
                                                                           // Adding number of goals against for a club
        VBox goalsAgainstList = new VBox();
        Button goalsAgainst  = new Button("GA");
        goalsAgainst.setPrefSize(100,50);
        goalsAgainst.setPadding(new Insets(10, 0, 0, 10));
        goalsAgainst.setStyle("-fx-text-fill: white; -fx-background-color: #13280D;");
        goalsAgainstList.getChildren().add(goalsAgainst);

                                                                           // Adding number of goals against for a club

        for (int i = 0; i < PremierLeagueManager.premierLeague.size(); i = i + 1) {

            FootballClub club = PremierLeagueManager.premierLeague.get(i);
            Button gAgainst = new Button(String.valueOf(club.getNoOfGoalsAgainst()));
            gAgainst.setPrefSize(100,45);
            gAgainst.setStyle("-fx-text-fill: white; -fx-background-color: #280026;");
            gAgainst.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            gAgainst.setPadding(new Insets(0, 0, 0, 10));
            goalsAgainstList.getChildren().add(gAgainst);
        }
                                                                      // Adding "-" marks to denote data unavailability

        for (int i = 0; i < 20 - PremierLeagueManager.premierLeague.size(); i = i + 1) {

            Button gAgainst = new Button("-");
            gAgainst.setTooltip(new Tooltip("No Data available"));
            gAgainst.setPrefSize(100,45);
            gAgainst.setStyle("-fx-text-fill: white; -fx-background-color: #280026;");
            gAgainst.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            gAgainst.setPadding(new Insets(0, 0, 0, 10));
            goalsAgainstList.getChildren().add(gAgainst);
        }

        VBox goalDifferenceList = new VBox();                                // Adding topic for number of goals scored
        Button goalDifference  = new Button("GD");
        goalDifference.setPrefSize(100,50);
        goalDifference.setPadding(new Insets(10, 0, 0, 10));
        goalDifference.setStyle("-fx-text-fill: white; -fx-background-color: #13280D;");
        goalDifferenceList.getChildren().add(goalDifference);

                                                                         // Adding number of goal difference for a club

        for (int i = 0; i < PremierLeagueManager.premierLeague.size(); i = i + 1) {

            FootballClub club = PremierLeagueManager.premierLeague.get(i);
            Button gDifference = new Button(String.valueOf(club.getGoalDifference()));
            gDifference.setPrefSize(100,45);
            gDifference.setStyle("-fx-text-fill: white; -fx-background-color: #1B0728;");
            gDifference.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            gDifference.setPadding(new Insets(0, 0, 0, 10));
            goalDifferenceList.getChildren().add(gDifference);
        }
                                                                      // Adding "-" marks to denote data unavailability

        for (int i = 0; i < 20 - PremierLeagueManager.premierLeague.size(); i = i + 1) {

            Button gDifference = new Button("-");
            gDifference.setTooltip(new Tooltip("No Data available"));
            gDifference.setPrefSize(100,45);
            gDifference.setStyle("-fx-text-fill: white; -fx-background-color: #1B0728;");
            gDifference.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            gDifference.setPadding(new Insets(0, 0, 0, 10));
            goalDifferenceList.getChildren().add(gDifference);
        }


        VBox pointsList = new VBox();                                              // Adding topic for number of points
        Button points  = new Button("Points");
        points.setPrefSize(100,50);
        points.setPadding(new Insets(10, 0, 10, 10));
        points.setStyle("-fx-text-fill: white; -fx-background-color: #13280D;");
        pointsList.getChildren().add(points);
                                                                                  // Adding number of points for a club

        for (int i = 0; i < PremierLeagueManager.premierLeague.size(); i = i + 1) {

            FootballClub club = PremierLeagueManager.premierLeague.get(i);
            Button point= new Button(String.valueOf(club.getNoOfPoints()));
            point.setPrefSize(100,45);
            point.setStyle("-fx-text-fill: white; -fx-background-color: #280026;");
            point.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            point.setPadding(new Insets(0, 0, 0, 10));
            pointsList.getChildren().add(point);
        }
                                                                      // Adding "-" marks to denote data unavailability

        for (int i = 0; i < 20 - PremierLeagueManager.premierLeague.size(); i = i + 1) {

            Button point = new Button("-");
            point.setTooltip(new Tooltip("No Data available"));
            point.setPrefSize(100,45);
            point.setStyle("-fx-text-fill: white; -fx-background-color: #280026;");
            point.setBorder(new Border(new BorderStroke(Color.BLACK,
                    BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
            point.setPadding(new Insets(0, 0, 0, 10));
            pointsList.getChildren().add(point);
        }


        VBox optionsList = new VBox();                                         // Adding all buttons to an Options Pane
        optionsList.setSpacing(20);
        optionsList.setPadding(new Insets(50,0,0,30));


        Image img = new Image("premierLeagueImage.png");                           // Adding image to the FlowPane
        ImageView imageView = new ImageView(img);
        imageView.setFitHeight(290);
        imageView.setFitWidth(320);
        imageView.setX(100);
        imageView.setY(3000);
        optionsList.getChildren().add(imageView);

                                                                       // Button to retrieve all played matches details

        Button matchesPlayed  = new Button("All matches played");
        matchesPlayed.setPrefSize(320,50);
        matchesPlayed.setPadding(new Insets(10, 0, 10, 10));
        matchesPlayed.setStyle("-fx-text-fill: white; -fx-background-color: #13280D");
        optionsList.getChildren().add(matchesPlayed);


        Button randomMatch  = new Button("Random Match");                         // Button to play a random match
        randomMatch.setPrefSize(320,50);
        randomMatch.setPadding(new Insets(10, 0, 10, 10));
        randomMatch.setStyle("-fx-text-fill: white; -fx-background-color: #13280D");
        optionsList.getChildren().add(randomMatch);

                                                              // Button to sort the premier league table by club points

        Button sortByPoints  = new Button("Sort By Points");
        sortByPoints.setPrefSize(320,50);
        sortByPoints.setPadding(new Insets(10, 0, 10, 10));
        sortByPoints.setStyle("-fx-text-fill: white; -fx-background-color: #13280D");
        optionsList.getChildren().add(sortByPoints);

                                                             // Button to sort the premier league table by Goals Scored

        Button sortByGoalsScored  = new Button("Sort By GS");
        sortByGoalsScored.setPrefSize(320,50);
        sortByGoalsScored.setPadding(new Insets(10, 0, 10, 10));
        sortByGoalsScored.setStyle("-fx-text-fill: white; -fx-background-color: #13280D");
        optionsList.getChildren().add(sortByGoalsScored);


        Button sortByWins  = new Button("Sort By Wins");              // Button to sort the premier league by wins
        sortByWins.setPrefSize(320,50);
        sortByWins.setPadding(new Insets(10, 0, 10, 10));
        sortByWins.setStyle("-fx-text-fill: white; -fx-background-color: #13280D");
        optionsList.getChildren().add(sortByWins);

        TextField searchDateTextField = new TextField();                      // Adding TextField to get the user input

        searchDateTextField.setStyle("-fx-text-fill: white; -fx-background-color: #280026");
        searchDateTextField.setBorder(new Border(new BorderStroke(Color.BLACK,
                BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
        Label labelSearchDate = new Label("Enter date to find matches (DD.MM.YYYY)");
        labelSearchDate.setStyle("-fx-text-fill: white;");
        labelSearchDate.setPadding(new Insets(20,0,0,25));

        optionsList.getChildren().add(labelSearchDate);
        optionsList.getChildren().add(searchDateTextField);

                                                       // Button to retrieve played match details for the selected date

        Button getDetails  = new Button("Get Details");
        getDetails.setPrefSize(320,50);
        getDetails.setStyle("-fx-text-fill: white; -fx-background-color: #13280D");
        optionsList.getChildren().add(getDetails);


        HBox exitPane = new HBox();
        exitPane.setPadding(new Insets(-60, 0, 10, 1280));

        Button exit = new Button("Exit");                                  // Dedicated button to exit the program
        exit.setPrefSize(320, 50);
        exit.setStyle("-fx-text-fill: white; -fx-background-color: #800000");
        exitPane.getChildren().add(exit);


        matchesPlayed.setOnAction(event -> {                          // Setting button action for matchesPlayed button

            if (PremierLeagueManager.matchesPlayed.size() != 0) {
                Stage stage = (Stage) matchesPlayed.getScene().getWindow();
                stage.setIconified(true);
                sortMatchesByDate();
            }
            else {
                Alert alert = new Alert(Alert.AlertType.WARNING,"No matches played so far.", ButtonType.OK);
                alert.showAndWait();
            }
        });


        randomMatch.setOnAction(event -> {                              // Setting button action for randomMatch button

            if (PremierLeagueManager.premierLeague.size() > 1) {

                ConsoleApplication.guiEventCheck = "Random";

                Stage stage = (Stage) randomMatch.getScene().getWindow();
                stage.close();
            }
            else {
                Alert alert = new Alert(Alert.AlertType.WARNING, "At least 2 clubs are required to play " +
                        "a Random Match. Add more clubs.", ButtonType.OK);
                alert.showAndWait();
            }
        });


        sortByPoints.setOnAction(event -> {                            // Setting button action for sortByPoints button

            ConsoleApplication.guiEventCheck = "Points";

            Stage stage = (Stage) sortByPoints.getScene().getWindow();
            stage.close();

        });


        sortByGoalsScored.setOnAction(event -> {                  // Setting button action for sortByGoalsScored button

            ConsoleApplication.guiEventCheck = "GS";

            Stage stage = (Stage) sortByGoalsScored.getScene().getWindow();
            stage.close();

        });


        sortByWins.setOnAction(event -> {                                // Setting button action for sortByWins button

            ConsoleApplication.guiEventCheck = "Wins";

            Stage stage = (Stage) sortByWins.getScene().getWindow();
            stage.close();

        });

                       // Validating the Date entered and retrieving match details for the date (Setting button action)

        getDetails.setOnAction(event -> {

            CharSequence dateCharacters = searchDateTextField.getCharacters();
                                                                                     // Checking the TextField is empty
            if (!searchDateTextField.getText().equals("")) {
                if (dateCharacters.length() == 10 && !searchDateTextField.getText().contains("/") &&
                        String.valueOf(dateCharacters.charAt(5)).equals(".") &&
                        String.valueOf(dateCharacters.charAt(2)).equals(".") &&
                        !String.valueOf(dateCharacters.charAt(4)).equals(".")) {

                                                                                         // Validating the entered date

                    int year = Integer.parseInt(dateCharacters.charAt(6) + "" + (dateCharacters.charAt(7)) + ""
                            + (dateCharacters.charAt(8)) + "" + (dateCharacters.charAt(9)));

                    int month = Integer.parseInt(dateCharacters.charAt(3) + "" + dateCharacters.charAt(4));

                    int day = Integer.parseInt(dateCharacters.charAt(0) + "" + dateCharacters.charAt(1));


                    if (month == 0 || month > 12){                        // Getting a value between 1 and 12 for month

                        Alert alert = new Alert(Alert.AlertType.WARNING, "Invalid Date. Please enter a" +
                                " valid Date.", ButtonType.OK);
                        alert.showAndWait();
                    }                                         // Checking the correct day count for the month, February

                    else if (month == 2 && (year % 4) == 0 && (day > 29 || day < 1)) {

                        Alert alert = new Alert(Alert.AlertType.WARNING, "Invalid Date. Please enter a " +
                                "valid Date.", ButtonType.OK);
                        alert.showAndWait();
                    }
                    else if (month == 2 && (year % 4) != 0 && (day > 28 || day < 1)) {

                        Alert alert = new Alert(Alert.AlertType.WARNING, "Invalid Date. Please enter a" +
                                " valid Date.", ButtonType.OK);
                        alert.showAndWait();
                    }                                            // Setting the day count as 30 for the relevant months

                    else if ((month == 4 || month == 6 || month == 9 || month == 11) && (day > 30 || day < 1)) {

                        Alert alert = new Alert(Alert.AlertType.WARNING, "Invalid Date. Please enter a" +
                                " valid Date.", ButtonType.OK);
                        alert.showAndWait();
                    }                                            // Setting the day count as 31 for the relevant months

                    else if ((month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 ||
                            month == 12) && (day > 31 || day < 1)) {

                        Alert alert = new Alert(Alert.AlertType.WARNING, "Invalid Date. Please enter a " +
                                "valid Date.", ButtonType.OK);
                        alert.showAndWait();
                    }
                    else {
                        String date = searchDateTextField.getText();

                        MatchesPlayed mp = new MatchesPlayed();
                        mp.setDate(date);

                        ArrayList<String> arrayList = new ArrayList<>();

                        for (int i = 0; i < PremierLeagueManager.matchesPlayed.size(); i++) {

                            MatchesPlayed match = (PremierLeagueManager.matchesPlayed.get(i));

                            if (match.getDate().equals(mp.getDate())) {
                                arrayList.add(String.valueOf(match));
                            }
                        }
                        if (arrayList.size() == 0) {

                            Alert alert = new Alert(Alert.AlertType.WARNING, "No matches found.",
                                    ButtonType.OK);
                            alert.showAndWait();
                        }
                        else {                                             // Displaying the match details for the date

                            Stage stage = (Stage) getDetails.getScene().getWindow();
                            stage.setIconified(true);

                            System.out.println("\n * Matches played on the selected Date: \n");

                            for (int i = 0; i < arrayList.size(); i++) {

                                System.out.println(arrayList.get(i) + "\n ");
                            }
                        }
                    }
                }
                else {
                    Alert alert = new Alert(Alert.AlertType.WARNING, "Incorrect Date Format." +
                            "\n\nPlease follow DD.MM.YYYY Format.\n\nEg: 01.01.2020", ButtonType.OK);
                    alert.showAndWait();
                }
            }
            else {
                Alert alert = new Alert(Alert.AlertType.WARNING, "Please enter a Date", ButtonType.OK);
                alert.showAndWait();
            }
        });


        exit.setOnAction(event -> {                                        // Adding set on close request to the window

            Alert alert = new Alert(Alert.AlertType.CONFIRMATION, "Do you really want to exit window?",
                    ButtonType.YES, ButtonType.NO, ButtonType.CANCEL);

            alert.showAndWait();

            if (alert.getResult() == ButtonType.YES) {
                startProgram.close();
            }

            else if (alert.getResult() == ButtonType.NO) {
                alert.close();
            }
        });


        FlowPane flowPane = new FlowPane();                                          // Adding all elements to FlowPane
        flowPane.setStyle(" -fx-background-color: #1B0728;");
        flowPane.setBorder(new Border(new BorderStroke(Color.GREEN,BorderStrokeStyle.SOLID, CornerRadii.EMPTY,
                BorderWidths.DEFAULT)));
        flowPane.getChildren().add(numberList);
        flowPane.getChildren().add(clubNameList);
        flowPane.getChildren().add(locationList);
        flowPane.getChildren().add(matchesList);
        flowPane.getChildren().add(winsList);
        flowPane.getChildren().add(drawsList);
        flowPane.getChildren().add(defeatsList);
        flowPane.getChildren().add(goalsScoredList);
        flowPane.getChildren().add(goalsAgainstList);
        flowPane.getChildren().add(goalDifferenceList);
        flowPane.getChildren().add(pointsList);
        flowPane.getChildren().add(optionsList);
        flowPane.getChildren().add(exitPane);


        startProgram.setScene(new Scene(flowPane));                      // Creating the Stage and Staging up the scene
        startProgram.setMinWidth(1635);
        startProgram.setMaxWidth(1635);
        startProgram.setMinHeight(990);
        startProgram.setMaxHeight(990);
        startProgram.setResizable(false);
        startProgram.setTitle("PREMIER LEAGUE TABLE");
        startProgram.showAndWait();
    }


    public void randomMatch() {

        int year = 0;                                                                       // initialising date values
        int month = 0;
        int day = 0;

        Date date = new Date(year, month, day);                                       // Getting date as a random value

        date.dateCheckGui();                                                     // Validating the randomly chosen date


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


        PremierLeagueManager pr = new PremierLeagueManager();                // Saving the random match details to file
        try {
            pr.saveData();
        }
        catch (IOException e) {
            e.printStackTrace();
        }

        startProgram.setIconified(true);                        // Minimise the window after executing the random match
        gui();                                                                   // Re-launching GUI to display updates
    }


    public void sortMatchesByDate(){                                              // Sort played matches by Date method

        Collections.sort(PremierLeagueManager.matchesPlayed, new Comparator<MatchesPlayed>() {
            DateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            @Override
            public int compare(MatchesPlayed o1, MatchesPlayed o2) {               // Comparing 2 matchesPlayed objects
                try {
                    return dateFormat.parse(o1.getDate()).compareTo(dateFormat.parse(o2.getDate()));
                } catch (ParseException e) {
                    throw new IllegalArgumentException(e);
                }
            }
        });

        System.out.println("\n * All played matches so far: \n");

        for(int i = 0; i < PremierLeagueManager.matchesPlayed.size(); i++){
            System.out.println(PremierLeagueManager.matchesPlayed.get(i) + "\n");
        }
    }


    public void sortTableByGoalsScored() {                                            // Sort all teams by goals scored

        Collections.sort(PremierLeagueManager.premierLeague, new Comparator<FootballClub>() {
            @Override
            public int compare(FootballClub fb1, FootballClub fb2) {                // Comparing 2 FootballClub objects

                return (fb2.getNoOfGoalsScored())-(fb1.getNoOfGoalsScored());
            }
        });

        gui();                                                                   // Re-launching GUI to display updates
    }


    public void sortTableByWins(){                                                     // Sort all teams by wins method

        Collections.sort(PremierLeagueManager.premierLeague, new Comparator<FootballClub>() {
            @Override
            public int compare(FootballClub fb1, FootballClub fb2) {                // Comparing 2 FootballClub objects

                return (fb2.getNoOfWins())-(fb1.getNoOfWins());
            }
        });

        gui();                                                                   // Re-launching GUI to display updates
    }


    public void sortTableByPoints() {                               // Sort all teams by points method in GUI component

        Collections.sort(PremierLeagueManager.premierLeague, new Comparator<FootballClub>() {
            @Override
            public int compare(FootballClub fb1, FootballClub fb2) {                // Comparing 2 FootballClub methods
                if (fb1.getNoOfPoints() == fb2.getNoOfPoints()) {
                    return (fb2.getGoalDifference() - fb1.getGoalDifference());
                }
                return (fb2.getNoOfPoints())-(fb1.getNoOfPoints());
            }
        });

        gui();                                                                   // Re-launching GUI to display updates
    }
}
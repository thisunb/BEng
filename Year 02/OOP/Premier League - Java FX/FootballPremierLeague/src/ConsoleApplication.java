import javafx.stage.Stage;
import java.io.IOException;
import java.util.Scanner;

public class ConsoleApplication extends GUI {

    public static String guiEventCheck = "";                                    // GUI event check variable declaration

    public void start(Stage startProgram) {

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
                        pr.sortAccordingToPoints();                          // Sorting clubs for points on GUI startup
                        GUI startGui = new GUI();
                        startGui.gui();

                        while (true) {                                         // Changing the GUI event to refresh GUI
                            if (guiEventCheck.equals("Points")) {
                                startGui.sortTableByPoints();
                            } else if (guiEventCheck.equals("GS")) {
                                startGui.sortTableByGoalsScored();
                            } else if (guiEventCheck.equals("Wins")) {
                                startGui.sortTableByWins();
                            } else if (guiEventCheck.equals("Random")) {
                                startGui.randomMatch();
                            } else {
                                break;
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
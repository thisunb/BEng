import com.mongodb.Block;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.DateCell;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import org.bson.Document;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.logging.Level;
import javafx.scene.control.Button;

public class TrainStation extends Application {

    public static MongoDatabase Database;                        //---Defining Mongo Database to Load Data---//
    public static MongoCollection<Document> Collection2;
    public static String Destination;
    public static LocalDate value;

    public static void main(String[] args) {
        launch();
    }

    public void start(Stage startProgram) throws IOException {

        Scanner sc2 = new Scanner(System.in);

        System.out.println("\n ---------DENUWARA MENIKE TRAIN QUEUE - SELECT THE ROUTE--------");      //--Topic--//

        System.out.println("\n  Enter \"1\" to select Colombo to Badulla Route: \n");   //---Displaying Train Stops--//
            System.out.println("     This Route includes the following Stops. ");

                System.out.println("         * Colombo to Badulla.(Full Trip)");
                System.out.println("         * Colombo to Peradeniya.");
                System.out.println("         * Colombo to Nanuoya.");
                System.out.println("         * Colombo to Hatton.");
                System.out.println("         * Colombo to Ella.");

        System.out.println("\n  Enter \"2\" to select Badulla to Colombo Route: \n");
            System.out.println("     This Route includes the following Stops. ");

                System.out.println("         * Badulla to Ella.");
                System.out.println("         * Badulla to Hatton.");
                System.out.println("         * Badulla to Nanuoya.");
                System.out.println("         * Badulla to Peradeniya.");
                System.out.println("         * Badulla to Colombo.(Full Trip)");

        System.out.println("\n  Enter your choice here: ");                 //---Getting the customer's choice---//

        String choice2 = sc2.nextLine();

        while (!choice2.equals("1") && !choice2.equals("2")) {

            System.out.println("Invalid response! Please enter a Correct response.");

            System.out.println("\n  Enter \"1\" to select Colombo to Badulla Route: \n");     //---Displaying Train
                System.out.println("     This Route includes the following Stops. ");                         //Stops

                    System.out.println("         * Colombo to Badulla.(Full Trip)");
                    System.out.println("         * Colombo to Peradeniya.");
                    System.out.println("         * Colombo to Nanuoya.");
                    System.out.println("         * Colombo to Hatton.");
                    System.out.println("         * Colombo to Ella.");

            System.out.println("\n  Enter \"2\" to select Badulla to Colombo Route: \n");
                System.out.println("     This Route includes the following Stops. ");

                    System.out.println("         * Badulla to Ella.");
                    System.out.println("         * Badulla to Hatton.");
                    System.out.println("         * Badulla to Nanuoya.");
                    System.out.println("         * Badulla to Peradeniya.");
                    System.out.println("         * Badulla to Colombo.(Full Trip)");

            System.out.println("\n  Enter your choice here: ");                //---Getting the customer's choice---//

            choice2 = sc2.nextLine();
        }

        switch (choice2) {                                        //---Choosing Train Stops---//
            case "1":
                selectTrip("Seats By Name - CMB to BDL");
                Destination = "CMB to BDL";
                break;
            case "2":
                selectTrip( "Seats By Name - BDL to CMB");
                Destination = "BDL to CMB";
                break;
        }

        Collection2.find().forEach((Block<Document>) document2 -> {                 //Getting Data from the Database
            ArrayList<String> key2 = new ArrayList<>(document2.keySet());

            for (int i = 0; i < key2.size(); i++) {
                if (String.valueOf(key2.get(i)).equals("_id")) continue;
                PassengerQueue.importNameList.add(String.valueOf(key2.get(i)));
            }
        });


        while (true) {

            System.out.println("\n--------------------Train Queue - Main Menu----------------------");
            System.out.println("    * Enter \"A\" to add a Passenger to the trainQueue.  ");
            System.out.println("    * Enter \"V\" to view the TrainQueue.  ");
            System.out.println("    * Enter \"D\" to delete Passenger from the TrainQueue.  ");
            System.out.println("    * Enter \"S\" to store TrainQueue Data. ");
            System.out.println("    * Enter \"L\" to load TrainQueue Data. ");
            System.out.println("    * Enter \"R\" to run the Simulation and produce a Report.  ");
            System.out.println("    * Enter \"Q\" to quit the Program.");
            System.out.println("\n      Enter your option: ");

            Scanner sc3 = new Scanner(System.in);
            String option = sc3.nextLine().toUpperCase();

            PassengerQueue passengerQueueObject = new PassengerQueue();     // Defining Passenger Queue Object to
                                                                                   // access PassengerQueue Class
            switch (option) {
                case "A":
                    passengerQueueObject.addPassenger();
                    break;

                case "V":
                    passengerQueueObject.viewTrainQueue();
                    break;

                case "D":
                    passengerQueueObject.deletePassenger();
                    break;

                case "S":
                    passengerQueueObject.storeData();
                    break;

                case "L":
                    passengerQueueObject.loadData();
                    break;

                case "R":
                    passengerQueueObject.run();
                    break;

                case "Q":
                    passengerQueueObject.quit();
                    break;

                default:
                    System.out.println("Invalid Response! Enter a option again. \n");
            }
        }
    }

    public void gui() {

        VBox section1 = new VBox();
        for (int i = 1; i <= 9; i = i + 1) {
            Button seatButton = new Button("Passenger 0" + i);
            seatButton.setStyle("-fx-background-color: #8904B1; -fx-text-fill: white;");

            section1.getChildren().add(seatButton);
            section1.setSpacing(10);
            section1.setPadding(new Insets(20, 0, 0, 15));
        }

        for (int i = 10; i <= 21; i = i + 1) {
            Button seatButton = new Button("Passenger " + i);
            seatButton.setStyle("-fx-background-color: #8904B1; -fx-text-fill: white;");

            section1.getChildren().add(seatButton);
            section1.setSpacing(10);
            section1.setPadding(new Insets(20, 0, 0, 15));
        }

        VBox passengerList1 = new VBox();
        for (int j = 0; j < PassengerQueue.PassengerLinkedList.size(); j++) {

            String getPassengerName = PassengerQueue.PassengerLinkedList.get(j);

            Button passengerName = new Button();
            passengerName.setStyle("-fx-background-color: #173B0B; -fx-text-fill: white;");
            passengerName.setText(getPassengerName);
            passengerName.setPrefSize(300,10);

            passengerList1.getChildren().add(passengerName);
            passengerList1.setSpacing(10);
            passengerList1.setPadding(new Insets(20, 0, 0, 30));
        }

        for (int j = PassengerQueue.PassengerLinkedList.size(); j < 42 ; j++) {

            Button passengerName = new Button();
            passengerName.setStyle("-fx-background-color: brown; -fx-text-fill: white;");
            passengerName.setText("Empty");
            passengerName.setPrefSize(300,10);

            passengerList1.getChildren().add(passengerName);
            passengerList1.setSpacing(10);
            passengerList1.setPadding(new Insets(20, 0, 0, 20));
        }

        VBox section2 = new VBox();
        for (int i = 22; i <= 42; i = i + 1) {

            Button seatButton = new Button("Passenger " + i);
            seatButton.setStyle("-fx-background-color: #8904B1; -fx-text-fill: white;");

            section2.getChildren().add(seatButton);
            section2.setSpacing(10);
            section2.setPadding(new Insets(20, 0, 0, 120));
        }

        VBox passengerList2 = new VBox();
        for (int j = 21; j < PassengerQueue.PassengerLinkedList.size() ; j++) {

            String getPassengerName = PassengerQueue.PassengerLinkedList.get(j);

            Button passengerName = new Button();
            passengerName.setStyle("-fx-background-color: #173B0B; -fx-text-fill: white;");
            passengerName.setText(getPassengerName);
            passengerName.setPrefSize(300,10);

            passengerList2.getChildren().add(passengerName);
            passengerList2.setSpacing(10);
            passengerList2.setPadding(new Insets(20, 0, 0, 20));
        }

        for (int j = PassengerQueue.PassengerLinkedList.size(); j < 42 ; j++) {

            Button passengerName = new Button();
            passengerName.setStyle("-fx-background-color: brown; -fx-text-fill: white;");
            passengerName.setText("Empty");
            passengerName.setPrefSize(300,10);

            passengerList2.getChildren().add(passengerName);
            passengerList2.setSpacing(10);
            passengerList2.setPadding(new Insets(20, 0, 0, 20));
        }

        FlowPane flowPane = new FlowPane();
        flowPane.getChildren().add(section1);
        flowPane.getChildren().add(passengerList1);
        flowPane.getChildren().add(section2);
        flowPane.getChildren().add(passengerList2);

        flowPane.setStyle("-fx-background-color: black; ");  //--Changing the Flowpane Background Color--//

        Stage startProgram = new Stage();                        //---STARTING UP THE GUI----//
        startProgram.setScene(new Scene(flowPane));
        startProgram.setMinWidth(1025);
        startProgram.setMaxWidth(1025);
        startProgram.setMinHeight(928);
        startProgram.setMaxHeight(928);
        startProgram.setMaximized(false);
        startProgram.setTitle("TRAIN QUEUE - Denuwara Menike");
        startProgram.showAndWait();
    }

    private static void selectTrip(String Name) {
        Stage startDate = new Stage();                                //--Defining the stage--//
        startDate.setTitle("Select Booking Dates");
        DatePicker datePicker = new DatePicker();

        startDate.setOnCloseRequest(e -> System.exit(0));

        datePicker.setDayCellFactory(picker -> new DateCell() {     //--Disabling the Past Dates in the Date Picker--//
            public void updateItem(LocalDate date, boolean empty) {
                super.updateItem(date, empty);
                LocalDate today = LocalDate.now();
                setDisable(empty || date.compareTo(today) < 0);
            }
        });

        Button button = new Button("Select Date");           //-----Adding a button select the desired date----//
        button.setStyle("-fx-background-color: brown; -fx-text-fill: white;");


        button.setOnAction(action -> {
            value = datePicker.getValue();

            if (value != null){                                                  //---------Mongo Database----------//
                java.util.logging.Logger.getLogger("org.mongodb.driver").setLevel(Level.SEVERE);
                MongoClient client = MongoClients.create();
                Database = client.getDatabase(String.valueOf(value));
                Collection2 = Database.getCollection(Name);

                startDate.close();                          //--Closing the Date Picker GUI when button is clicked--//
            }
            else {
                System.out.println("You have not selected a Date. Please select a date and click \"Select Date\" " +
                        "button for Seat Booking and try again!");
            }
        });


        Label description = new Label("Choose the Date");   //---Adding a Description to the Gui---//
        description.setStyle("-fx-text-fill: white;");

        HBox hbox = new HBox(datePicker, button);
        hbox.setPadding(new Insets(50, 50, 20, 35));
        hbox.setSpacing(20);

        HBox hbox2 = new HBox(description);
        hbox2.setPadding(new Insets(0, 50, 0, 95));

        FlowPane flowPane2 = new FlowPane(hbox,hbox2);                  //---Adding content to the Flowpane---//
        flowPane2.setStyle("-fx-background-color: black;");

        startDate.setScene(new Scene(flowPane2, 400, 150));      //------Starting the DatePicker GUI---//
        startDate.showAndWait();
    }

    public void gui2Report(){

        Button length = new Button();
        PassengerQueue passengerQueueObject = new PassengerQueue();
        String lengthText = ("Queue Length = " + passengerQueueObject.getMaxLength() + " Passengers");
        length.setText(lengthText);
        length.setStyle("-fx-background-color: #8904B1; -fx-text-fill: white;");
        length.setPrefSize(250,10);

        Button maxTime = new Button();
        String maxTimeText = ("Maximum Waiting Time = " + PassengerQueue.last + "s");
        maxTime.setText(maxTimeText);
        maxTime.setStyle("-fx-background-color: #8904B1; -fx-text-fill: white;");
        maxTime.setPrefSize(250,10);

        Button minTime = new Button();
        String minTimeText = ("Minimum Waiting Time = " + PassengerQueue.first + "s");
        minTime.setText(minTimeText);
        minTime.setStyle("-fx-background-color: #8904B1; -fx-text-fill: white;");
        minTime.setPrefSize(250,10);

        Button avgTime = new Button();
        String avgTimeText = ("Average Waiting Time = " + PassengerQueue.averageTime + "s");
        avgTime.setText(avgTimeText);
        avgTime.setStyle("-fx-background-color: #8904B1; -fx-text-fill: white;");
        avgTime.setPrefSize(250,10);

        HBox upperSection = new HBox(length,maxTime,minTime,avgTime);
        upperSection.setSpacing(10);
        upperSection.setPadding(new Insets(20, 0, 0, 25));


        VBox section1 = new VBox();
        for (int i = 0; i < PassengerQueue.tempArrayList2.size(); i = i + 1) {

            String reportInfo = PassengerQueue.tempArrayList2.get(i);

            Button passengerName = new Button();
            passengerName.setStyle("-fx-background-color: #173B0B; -fx-text-fill: white;");
            passengerName.setText( "P" + (i+1) + ". " + reportInfo);
            passengerName.setPrefSize(400,10);

            section1.getChildren().add(passengerName);
            section1.setSpacing(10);
            section1.setPadding(new Insets(40, 0, 0, 25));
        }

        for (int j = PassengerQueue.PassengerLinkedList.size(); j < 42 ; j++) {

            Button passengerName = new Button();
            passengerName.setStyle("-fx-background-color: brown; -fx-text-fill: white;");
            passengerName.setText("Data Not Available");
            passengerName.setPrefSize(400,10);

            section1.getChildren().add(passengerName);
            section1.setSpacing(10);
            section1.setPadding(new Insets(20, 0, 0, 20));
        }

        VBox section2 = new VBox();
        for (int i = 21; i < PassengerQueue.tempArrayList2.size(); i = i + 1) {

            String reportInfo = PassengerQueue.tempArrayList2.get(i);

            Button passengerName = new Button();
            passengerName.setStyle("-fx-background-color: #173B0B; -fx-text-fill: white;");
            passengerName.setText( "P" + (i+1) + ". " + reportInfo);
            passengerName.setPrefSize(400,10);

            section2.getChildren().add(passengerName);
            section2.setSpacing(10);
            section2.setPadding(new Insets(40, 0, 0, 240));
        }

        for (int j = PassengerQueue.PassengerLinkedList.size(); j < 42 ; j++) {

            Button passengerName = new Button();
            passengerName.setStyle("-fx-background-color: brown; -fx-text-fill: white;");
            passengerName.setText("Data Not Available");
            passengerName.setPrefSize(400,10);

            section2.getChildren().add(passengerName);
            section2.setSpacing(10);
            section2.setPadding(new Insets(20, 0, 0, 240));
        }

        FlowPane flowPane3 = new FlowPane();
        flowPane3.getChildren().add(upperSection);
        flowPane3.getChildren().add(section1);
        flowPane3.getChildren().add(section2);

        flowPane3.setStyle("-fx-background-color: black; ");           //--Changing the Flowpane Background Color--//

        Stage startProgram = new Stage();                        //---STARTING UP THE GUI----//
        startProgram.setScene(new Scene(flowPane3));
        startProgram.setMinWidth(1100);
        startProgram.setMaxWidth(1100);
        startProgram.setMinHeight(978);
        startProgram.setMaxHeight(978);
        startProgram.setMaximized(false);
        startProgram.setTitle("TRAIN QUEUE - REPORT");
        startProgram.showAndWait();
    }
}
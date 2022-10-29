import com.mongodb.Block;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import org.bson.Document;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;
import java.util.logging.Level;

public class TrainBookingProgram extends Application {

    static TextField firstNameTextField = new TextField();     //--Adding Textfields for first name and surname--//
    static TextField surNameTextField = new TextField();
    static TextField idTextField = new TextField();        //--Adding the Textfield ID to enter Customer ID--//
    static final int SEATING_CAPACITY = 42;
    private static MongoDatabase Database;                //---Defining the Mongo Database to store & load Data---//
    static MongoCollection<Document> Collection;
    static MongoCollection<Document> Collection2;
    static HashMap<String, String> HASHMAP = new HashMap<>();        //---Defining Hashmaps---//
    static HashMap<String, String> HASHMAP2 = new HashMap<>();
    static DatePicker datePicker = new DatePicker();                //--Defining DatePicker Object--//


    public static void main(String[] args) {

        launch();
    }

    @Override
    public void start(Stage primaryStage) {

        Scanner sc = new Scanner(System.in);

        System.out.println("\n ---------DENUWARA MENIKE TRAIN BOOKINGS--------");      //--Topic (in the Console)--//

        System.out.println("\n   ---Colombo to Badulla Route---\n");                  //---Displaying Train Stops--//
        System.out.println("       * Enter \"1\" to start booking from Colombo to Badulla.(Full Trip)");
        System.out.println("       * Enter \"2\" to start booking from Colombo to Peradeniya.");
        System.out.println("       * Enter \"3\" to start booking from Colombo to Nanuoya.");
        System.out.println("       * Enter \"4\" to start booking from Colombo to Hatton.");
        System.out.println("       * Enter \"5\" to start booking from Colombo to Ella.");

        System.out.println("\n   ---Badulla to Colombo Route---\n");
        System.out.println("       * Enter \"6\" to start booking from Badulla to Ella.");
        System.out.println("       * Enter \"7\" to start booking from Badulla to Hatton.");
        System.out.println("       * Enter \"8\" to start booking from Badulla to Nanuoya.");
        System.out.println("       * Enter \"9\" to start booking from Badulla to Peradeniya.");
        System.out.println("       * Enter \"10\" to start booking from Badulla to Colombo.(Full Trip)");

        System.out.println("\n   Enter your choice here: ");                 //---Getting the customer's choice---//
        String choice = sc.nextLine();


        while (!choice.equals("1") && !choice.equals("2") && !choice.equals("3") && !choice.equals("4") &&
                !choice.equals("5") && !choice.equals("6") && !choice.equals("7") && !choice.equals("8") &&
                !choice.equals("9") && !choice.equals("10")) {

            System.out.println("Invalid response! Please enter a Correct response.");

            System.out.println("\n ---------DENUWARA MENIKE TRAIN BOOKINGS--------");     //--Topic (in the Console)//

            System.out.println("\n   ---Colombo to Badulla Route---\n");                //---Displaying Train Stops--//
            System.out.println("       * Enter \"1\" to start booking from Colombo to Badulla.(Full Trip)");
            System.out.println("       * Enter \"2\" to start booking from Colombo to Peradeniya.");
            System.out.println("       * Enter \"3\" to start booking from Colombo to Nanuoya.");
            System.out.println("       * Enter \"4\" to start booking from Colombo to Hatton.");
            System.out.println("       * Enter \"5\" to start booking from Colombo to Ella.");

            System.out.println("\n   ---Badulla to Colombo Route---\n");
            System.out.println("       * Enter \"6\" to start booking from Badulla to Ella.");
            System.out.println("       * Enter \"7\" to start booking from Badulla to Hatton.");
            System.out.println("       * Enter \"8\" to start booking from Badulla to Nanuoya.");
            System.out.println("       * Enter \"9\" to start booking from Badulla to Peradeniya.");
            System.out.println("       * Enter \"10\" to start booking from Badulla to Colombo.(Full Trip)");

            System.out.println("\n   Enter your choice here: ");               //---Getting the customer's choice---//
            choice = sc.nextLine();
        }

        switch (choice) {                                        //---Choosing Train Stops for Booking---//
            case "1":
            case "2":
            case "3":
            case "4":
            case "5":
                selectTrip("Seats BY ID - CMB to BDL", "Seats By Name - CMB to BDL");
                break;
            default:                        //--If choice equals to 6/7/8/9/10--//
                selectTrip("Seats BY ID - BDL to CMB", "Seats By Name - BDL to CMB");
                break;
        }

        String trip;                                 //---Choosing Train Stops for "find the seat" option---//
        switch (choice) {
            case "1":
                trip = "Colombo to Badulla";
                break;
            case "2":
                trip = "Colombo to Peradeniya";
                break;
            case "3":
                trip = "Colombo to Nanuoya";
                break;
            case "4":
                trip = "Colombo to Hatton";
                break;
            case "5":
                trip = "Colombo to Ella";
                break;
            case "6":
                trip = "Badulla to Ella";
                break;
            case "7":
                trip = "Badulla to Hatton";
                break;
            case "8":
                trip = "Badulla to Nanuoya";
                break;
            case "9":
                trip = "Badulla to Peradeniya";
                break;
            default:                                //If the choice is equal to 10
                trip = "Badulla to Colombo";
                break;
        }

        mainOptions(trip);
    }


    // ---------------------------------------------METHODS--------------------------------------------------------//

    public  void selectTrip(String ID, String Name){
        Stage startDate = new Stage();                                //--Defining the stage--//
        startDate.setTitle("Select Booking Dates");


        startDate.setOnCloseRequest(e -> System.exit(0));

        datePicker.setDayCellFactory(picker -> new DateCell() {     //--Disabling the Past Dates in the Date Picker--//
            public void updateItem(LocalDate date, boolean empty) {
                super.updateItem(date, empty);
                LocalDate today = LocalDate.now();
                setDisable(empty || date.compareTo(today) < 0);
            }
        });

        Button button = new Button("Select Date");            //-----Adding a button select the desired date----//
        button.setStyle("-fx-background-color: brown; -fx-text-fill: white;");


        button.setOnAction(action -> {
           LocalDate pickDate = datePicker.getValue();

            if (pickDate != null){                                                  //---------Mongo Database----------//
                java.util.logging.Logger.getLogger("org.mongodb.driver").setLevel(Level.SEVERE);
                MongoClient client = MongoClients.create();
                Database = client.getDatabase(String.valueOf(pickDate));
                Collection = Database.getCollection(ID);
                Collection2 = Database.getCollection(Name);

                startDate.close();                          //--Closing the Date Picker GUI when button is clicked--//
            }
            else {
                System.out.println("You have not selected a Date. Please select a date and click \"Select Date\" " +
                        "button for Seat Booking and try again!");
            }
        });


        Label description = new Label("Choose the Date you want to book");   //---Adding a Description to the Gui---//
        description.setStyle("-fx-text-fill: white;");

        HBox hbox = new HBox(datePicker, button);
        hbox.setPadding(new Insets(50, 50, 20, 35));
        hbox.setSpacing(20);

        HBox hbox2 = new HBox(description);
        hbox2.setPadding(new Insets(0, 50, 0, 75));

        FlowPane flowPane2 = new FlowPane(hbox,hbox2);                  //---Adding content to the Flowpane---//
        flowPane2.setStyle("-fx-background-color: black;");

        startDate.setScene(new Scene(flowPane2, 400, 150));      //------Starting the DatePicker GUI---//
        startDate.showAndWait();
    }

    private static void mainOptions(String trip){
        while (true) {
            System.out.println("\n--------------------Main Menu----------------------");
            System.out.println("    * Enter \"A\" to add a Customer to a Seat. ");
            System.out.println("    * Enter \"V\" to view all the Seats. ");
            System.out.println("    * Enter \"E\" to view Empty Seats. ");
            System.out.println("    * Enter \"D\" to delete a Booked Seat. ");
            System.out.println("    * Enter \"F\" to find a seat by Customer's Name. ");
            System.out.println("    * Enter \"O\" to view Seats ordered Alphabetically by Customer's Name. ");
            System.out.println("    * Enter \"S\" to store Booking Details. ");
            System.out.println("    * Enter \"L\" to load Booking Details. ");
            System.out.println("    * Enter \"Q\" to quit. ");
            System.out.println("\n      Enter your option: ");

            Scanner sc3 = new Scanner(System.in);
            String option = sc3.nextLine().toUpperCase();

            switch (option) {
                case "A":
                    addCustomer();
                    break;

                case "V":
                    viewAllSeats();
                    break;

                case "E":
                    viewEmptySeats();
                    break;

                case "D":
                    deleteBooking();
                    break;

                case "F":
                    findSeatByCustomerName(trip);
                    break;

                case "O":
                    viewOrderedSeats();
                    break;

                case "S":
                    storeData();
                    break;

                case "L":
                    loadData();
                    break;

                case "Q":
                    quit();
                    break;

                default:
                    System.out.println("Invalid Response! Enter a option again. \n");
            }
        }
    }

    private static void CustomerDetailsGui(){
        firstNameTextField.setText("");           //--Clearing Name & ID Textfields--//
        surNameTextField.setText("");
        idTextField.setText("");

        Stage startProgram2 = new Stage();                      //--Defining Stage--//
        startProgram2.setTitle("Customer Details");


        Label labelFirstName = new Label("Enter your First Name ");         //--Adding the Label first Name to enter
        labelFirstName.setStyle("-fx-text-fill: white;");                                           //-- Customer Name
        HBox hboxFirstName = new HBox(labelFirstName, firstNameTextField);
        hboxFirstName.setSpacing(20);
        hboxFirstName.setPadding(new Insets(20,20,20,20));

        Label labelSurName = new Label("Enter your Surname   ");         //--Adding the Label surname to enter
        labelSurName.setStyle("-fx-text-fill: white;");                                              //Customer Name
        HBox hboxSurName = new HBox(labelSurName, surNameTextField);
        hboxSurName.setSpacing(20);
        hboxSurName.setPadding(new Insets(10,20,20,22));


        Label labelId = new Label("Enter your ID              ");      //--Adding the Label ID to enter Customer ID--//
        labelId.setStyle("-fx-text-fill: white;");
        HBox hboxId = new HBox(labelId, idTextField);
        hboxId.setSpacing(20);
        hboxId.setPadding(new Insets(10,20,20,21));

        Button submitButton = new Button("    Submit    ");                    //--Adding a Button to submit--//
        submitButton.setStyle("-fx-background-color: brown; -fx-text-fill: white;");
        submitButton.setOnAction(e -> startProgram2.close());


        HBox hboxSubmit = new HBox(submitButton);
        hboxSubmit.setSpacing(20);
        hboxSubmit.setPadding(new Insets(10,20,20,145));
                                                                               //--adding elements to the Flowpane--//
        FlowPane flowPane3 = new FlowPane(hboxFirstName, hboxSurName, hboxId, hboxSubmit);
        flowPane3.setStyle("-fx-background-color: black;");            //---changing the flowpane background color--//

        startProgram2.setScene(new Scene(flowPane3, 400, 250));         //---Starting up the GUI----//
        startProgram2.showAndWait();
    }

    private static void TrainSeatsGui() {
        Button upperButton = new Button("        Seating Arrangement (Select & Book Seats)         ");
        upperButton.setStyle("-fx-text-fill: white; -fx-background-color: #2F0B3A;");
        HBox UpperRow = new HBox(upperButton);
        UpperRow.setPadding(new Insets(10, 0, 0, 20));

        Label section1 = new Label("SECTION 01");
        section1.setPadding(new Insets(50, 100, 0, 50));
        section1.setStyle("-fx-text-fill: white; ");

        Label section2 = new Label("SECTION 02");
        section2.setPadding(new Insets(50, 30, 0, 70));
        section2.setStyle("-fx-text-fill: white;");


        //---------------------------SECTION 1 OF THE TRAIN (LEFT HANDSIDE)-----------------------------------------//

                                                //---Seat Column 1 (seats 1 to 9)---//
        VBox seatColumn1 = new VBox();
        for (int i = 1; i <= 9; i = i + 2) {

            Button seatButton = new Button("Seat 0" + i);    //--Naming the Seat--//
            int seatNumber = i;
            String seatName = "Seat";
            String seat = seatName + seatNumber;               //--Getting the Seat--//

            if (HASHMAP.containsValue(seat) || (HASHMAP2.containsValue((seat)))){          //--Changing Seat Color--//
                seatButton.setStyle("-fx-background-color: brown; -fx-text-fill: white;");
            }
            else {
                seatButton.setStyle("-fx-background-color: green; -fx-text-fill: white;");
            }

            seatButton.setOnAction(event -> {                        //--Avoiding booking a booked seat repeatedly--//
                if (HASHMAP.containsValue(seat) || (HASHMAP2.containsValue(seat))){
                    System.out.println("This seat is already booked!" );
                }
                else {                          //--Starting up the GUI to get the Customer Details--//
                    CustomerDetailsGui();
                                                        //--Avoiding using the Same name to book a seat--//
                    if (!firstNameTextField.getText().equals("") && !surNameTextField.getText().equals("") &&
                            !idTextField.getText().equals("")) {

                        while (HASHMAP2.containsKey(firstNameTextField.getText().toUpperCase())) {
                            System.out.println("This Name is already used by another customer. Please type a" +
                                    " different name: ");
                            CustomerDetailsGui();
                        }

                        System.out.println("You have successfully booked Seat No " + seatNumber + ".");
                        HASHMAP.put(idTextField.getText().toUpperCase(), seat);         //--Adding Customer Details

                        String name = firstNameTextField.getText().toUpperCase() + " " +
                                surNameTextField.getText().toUpperCase();

                        HASHMAP2.put(name, seat);                 // to Hashmaps--//
                        seatButton.setStyle("-fx-background-color: brown;");
                    }
                }

            });

            seatColumn1.getChildren().add(seatButton);
            seatColumn1.setSpacing(5);
            seatColumn1.setPadding(new Insets(20, 0, 0, 10));
        }

                                                    //---Seat Column 1 (seats 11 to 21)---//
        for (int i = 11; i <= 21; i = i + 2) {

            Button seatButton = new Button("Seat " + i);           //--Naming the Seat--//
            int seatNumber = i;
            String seatName = "Seat";
            String Seat = seatName + seatNumber;                //--Getting the Seat--//

            if (HASHMAP.containsValue(Seat) || (HASHMAP2.containsValue((Seat)))){           //--Changing Seat Color
                seatButton.setStyle("-fx-background-color: brown; -fx-text-fill: white;");
            }
            else {
                seatButton.setStyle("-fx-background-color: green; -fx-text-fill: white;");
            }

            seatButton.setOnAction(event -> {
                if (HASHMAP.containsValue(Seat) || (HASHMAP2.containsValue(Seat))){      //--Avoiding booking a //
                    System.out.println("This seat is already booked!");                    //booked seat repeatedly
                }
                else {
                    CustomerDetailsGui();                 //--Starting up the GUI to get the Customer Details--//

                    if (!firstNameTextField.getText().equals("") && !surNameTextField.getText().equals("") &&
                            !idTextField.getText().equals("")) {
                        while (HASHMAP2.containsKey(firstNameTextField.getText().toUpperCase())) {
                            System.out.println("This Name is already used by another customer. Please type a" +
                                                                                " different name: ");
                            CustomerDetailsGui();
                        }

                        System.out.println("You have successfully booked Seat No " + seatNumber + ".");
                        HASHMAP.put(idTextField.getText().toUpperCase(), Seat);         //--Adding Customer Details

                        String name = firstNameTextField.getText().toUpperCase() + " " +
                                surNameTextField.getText().toUpperCase();

                        HASHMAP2.put(name, Seat);                 // to Hashmaps--//
                        seatButton.setStyle("-fx-background-color: brown;");
                    }
                }
            });

            seatColumn1.getChildren().add(seatButton);
            seatColumn1.setSpacing(5);
            seatColumn1.setPadding(new Insets(20, 0, 0, 10));
        }

                                                //---Seat Column 2 (seats 2 to 8)---//
        VBox seatColumn2 = new VBox();
        for (int i = 2; i <= 8; i = i + 2) {

            Button seatButton = new Button("Seat 0" + i);          //--Naming the Seat--//
            int seatNumber = i;
            String seatName = "Seat";
            String seat = seatName + seatNumber;        //--Getting the Seat--//

            if (HASHMAP.containsValue(seat) || (HASHMAP2.containsValue((seat)))){           //--Changing Seat Color
                seatButton.setStyle("-fx-background-color: brown; -fx-text-fill: white;");
            }
            else {
                seatButton.setStyle("-fx-background-color: green; -fx-text-fill: white;");
            }

            seatButton.setOnAction(event -> {
                if (HASHMAP.containsValue(seat) || (HASHMAP2.containsValue(seat))){     //--Avoiding booking a- //
                    System.out.println("This seat is already booked!");                 //booked seat repeatedly--//
                }
                else {
                    CustomerDetailsGui();                 //--Starting up the GUI to get the Customer Details--//

                    if (!firstNameTextField.getText().equals("") && !surNameTextField.getText().equals("") &&
                            !idTextField.getText().equals("")) {
                        while (HASHMAP2.containsKey(firstNameTextField.getText().toUpperCase())) {
                            System.out.println("This Name is already used by another customer. Please type a" +
                                    " different name: ");
                            CustomerDetailsGui();
                        }

                        System.out.println("You have successfully booked Seat No " + seatNumber + ".");
                        HASHMAP.put(idTextField.getText().toUpperCase(), seat);         //--Adding Customer Details

                        String name = firstNameTextField.getText().toUpperCase() + " " +
                                surNameTextField.getText().toUpperCase();

                        HASHMAP2.put(name, seat);                 // to Hashmaps--//
                        seatButton.setStyle("-fx-background-color: brown;");
                    }
                }
            });

            seatColumn2.getChildren().add(seatButton);
            seatColumn2.setSpacing(5);
            seatColumn2.setPadding(new Insets(20, 100, 0, 10));
        }

                                                     //---Seat Column 2 (seats 10 to 20)---//
        for (int i = 10; i <= 20; i = i + 2) {

            Button seatButton = new Button("Seat " + i);           //--Naming the Seat--//
            int seatNumber = i;
            String seatName = "Seat";
            String seat = seatName + " " +  seatNumber;         //--Getting the Seat--//


            if (HASHMAP.containsValue(seat) || (HASHMAP2.containsValue((seat)))){           //--Changing Seat Color--//
                seatButton.setStyle("-fx-background-color: brown; -fx-text-fill: white;");
            }
            else {
                seatButton.setStyle("-fx-background-color: green; -fx-text-fill: white;");
            }

            seatButton.setOnAction(event -> {
                if (HASHMAP.containsValue(seat) || (HASHMAP2.containsValue(seat))){         //--Avoiding booking a //
                    System.out.println("This seat is already booked!");        // booked seat repeatedly--//
                }
                else {
                    CustomerDetailsGui();               //--Starting up the GUI to get the Customer Details--//

                    if (!firstNameTextField.getText().equals("") && !surNameTextField.getText().equals("") &&
                            !idTextField.getText().equals("")) {
                        while (HASHMAP2.containsKey(firstNameTextField.getText().toUpperCase())) {
                            System.out.println("This Name is already used by another customer. Please type a" +
                                    " different name: ");
                            CustomerDetailsGui();
                        }

                        System.out.println("You have successfully booked Seat No " + seatNumber + ".");
                        HASHMAP.put(idTextField.getText().toUpperCase(), seat);         //--Adding Customer Details

                        String name = firstNameTextField.getText().toUpperCase() + " " +
                                surNameTextField.getText().toUpperCase();

                        HASHMAP2.put(name, seat);                 // to Hashmaps--//
                        seatButton.setStyle("-fx-background-color: brown;");
                    }
                }
            });

            seatColumn2.getChildren().add(seatButton);
            seatColumn2.setSpacing(5);
            seatColumn2.setPadding(new Insets(20, 100, 0, 10));
        }


        // ----------------------------------SECTION 2 OF THE TRAIN (RIGHT HANDSIDE)---------------------------------//

                                                    //---Seat Column 3 (seats 22 to 42)---//
        VBox seatColumn3 = new VBox();
        for (int i = 22; i <= 42; i = i + 2) {

            Button seatButton = new Button("Seat " + i);           //--Naming the Seat--//
            int seatNumber = i;
            String seatName = "Seat";
            String seat = seatName + " " +  seatNumber;         //--Getting the Seat--//


            if (HASHMAP.containsValue(seat) || (HASHMAP2.containsValue((seat)))){       //--Changing Seat Color--//
                seatButton.setStyle("-fx-background-color: brown; -fx-text-fill: white;");
            }
            else {
                seatButton.setStyle("-fx-background-color: green; -fx-text-fill: white;");
            }

            seatButton.setOnAction(event -> {
                if (HASHMAP.containsValue(seat) || (HASHMAP2.containsValue(seat))){     //--Avoiding booking a //
                    System.out.println("This seat is already booked!");         //--booked seat repeatedly--//
                }
                else {
                    CustomerDetailsGui();       //--Starting up the GUI to get the Customer Details--//

                    if (!firstNameTextField.getText().equals("") && !surNameTextField.getText().equals("") &&
                            !idTextField.getText().equals("")) {
                        while (HASHMAP2.containsKey(firstNameTextField.getText().toUpperCase())) {
                            System.out.println("This Name is already used by another customer. Please type a" +
                                    " different name: ");
                            CustomerDetailsGui();
                        }

                        System.out.println("You have successfully booked Seat No " + seatNumber + ".");
                        HASHMAP.put(idTextField.getText().toUpperCase(), seat);         //--Adding Customer Details

                        String name = firstNameTextField.getText().toUpperCase() + " " +
                                surNameTextField.getText().toUpperCase();

                        HASHMAP2.put(name, seat);                 // to Hashmaps--//
                        seatButton.setStyle("-fx-background-color: brown;");
                    }
                }
            });

            seatColumn3.getChildren().add(seatButton);
            seatColumn3.setSpacing(5);
            seatColumn3.setPadding(new Insets(20, 0, 0, 0));
        }


                                        //---Seat Column 4 (seats 23 to 41)---//
        VBox seatColumn4 = new VBox();
        for (int i = 23; i <= 41; i = i + 2) {

            Button seatButton = new Button("Seat " + i);           //--Naming the Seat--//
            int seatNumber = i;
            String seatName = "Seat";
            String seat = seatName + " " +  seatNumber;            //--Getting the Seat--//


            if (HASHMAP.containsValue(seat) || (HASHMAP2.containsValue((seat)))){       //--Changing Seat Color--//
                seatButton.setStyle("-fx-background-color: brown; -fx-text-fill: white;");
            }
            else {
                seatButton.setStyle("-fx-background-color: green; -fx-text-fill: white;");
            }

            seatButton.setOnAction(event -> {
                if (HASHMAP.containsValue(seat) || (HASHMAP2.containsValue(seat))){     //--Avoiding booking a --//
                    System.out.println("This seat is already booked!");        //-- booked seat repeatedly--//
                }
                else {
                    CustomerDetailsGui();           //--Starting up the GUI to get the Customer Details--//

                    if (!firstNameTextField.getText().equals("") && !surNameTextField.getText().equals("") &&
                            !idTextField.getText().equals("")) {
                        while (HASHMAP2.containsKey(firstNameTextField.getText().toUpperCase())) {
                            System.out.println("This Name is already used by another customer. Please type a" +
                                    " different name: ");
                            CustomerDetailsGui();
                        }

                        System.out.println("You have successfully booked Seat No " + seatNumber + ".");
                        HASHMAP.put(idTextField.getText().toUpperCase(), seat);         //--Adding Customer Details

                        String name = firstNameTextField.getText().toUpperCase() + " " +
                                surNameTextField.getText().toUpperCase();

                        HASHMAP2.put(name, seat);                 // to Hashmaps--//
                        seatButton.setStyle("-fx-background-color: brown;");
                    }
                }
            });

            seatColumn4 .getChildren().add(seatButton);
            seatColumn4 .setSpacing(5);
            seatColumn4 .setPadding(new Insets(20, 0, 0, 10));
        }

                                                                            //---Additional Buttons---//
        Button booked = new Button("     Booked Seats     ");
        Button empty = new Button("      Empty Seats      ");
        booked.setStyle("-fx-background-color: brown; -fx-text-fill: white;");
        empty.setStyle("-fx-background-color: green; -fx-text-fill: white;");

        Button booked2 = new Button("     Booked Seats     ");
        Button empty2 = new Button("      Empty Seats      ");
        booked2.setStyle("-fx-background-color: brown; -fx-text-fill: white;");
        empty2.setStyle("-fx-background-color: green; -fx-text-fill: white;");

        VBox leftSide = new VBox(booked, empty);                         //--Adding Additional Buttons to the Vbox--//
        leftSide.setSpacing(5);
        leftSide.setPadding(new Insets(30, 100, 10, 10));

        VBox rightSide = new VBox(booked2, empty2);
        rightSide.setSpacing(5);
        rightSide.setPadding(new Insets(30, 0, 10, -5));


                                                //---ADDING ELEMENTS TO THE FLOWPANE---//
        FlowPane flowPane = new FlowPane();
        flowPane.getChildren().add(UpperRow);
        flowPane.getChildren().add(section1);
        flowPane.getChildren().add(section2);
        flowPane.getChildren().add(seatColumn1);
        flowPane.getChildren().add(seatColumn2);
        flowPane.getChildren().add(seatColumn3);
        flowPane.getChildren().add(seatColumn4);
        flowPane.getChildren().add(leftSide);
        flowPane.getChildren().add(rightSide);

        flowPane.setStyle("-fx-background-color: black; ");       //--Changing the Flowpane Background Color--//

                                                    //---STARTING UP THE GUI----//
        Stage startProgram = new Stage();
        startProgram.setScene(new Scene(flowPane));
        startProgram.setMinWidth(435);
        startProgram.setMaxWidth(435);
        startProgram.setMinHeight(690);
        startProgram.setMaxHeight(690);
        startProgram.setMaximized(false);
        startProgram.setTitle("DENUWARA MENIKE TRAIN");
        startProgram.showAndWait();
        startProgram.close();
    }

    private static void addCustomer()  {
        TrainSeatsGui();
    }

    private static void viewAllSeats() {

        //----------STARTING UP OF THE VIEW ALL SEATS OPTION GUI----------//

        Button upperButton = new Button("           Seating Arrangement (View only)            ");
        upperButton.setStyle("-fx-text-fill: white; -fx-background-color: #2F0B3A;");
        HBox upperRow = new HBox(upperButton);
        upperRow.setPadding(new Insets(10, 0, 0, 45));

        Label section1 = new Label("SECTION 01");
        section1.setPadding(new Insets(50, 100, 0, 50));
        section1.setStyle("-fx-text-fill: white; ");

        Label section2 = new Label("SECTION 02");
        section2.setPadding(new Insets(50, 30, 0, 70));
        section2.setStyle("-fx-text-fill: white;");


        // ---SECTION 1 OF THE TRAIN (LEFT HANDSIDE)---//

                                                //--SeatColumn1 (seats 1 to 9)--//
        VBox seatColumn1 = new VBox();
        for (int i = 1; i <= 9; i = i + 2) {
            Button seatButton = new Button("Seat 0" + i);
            seatButton.setStyle("-fx-background-color: green; -fx-text-fill: white;");

            seatColumn1.getChildren().add(seatButton);
            seatColumn1.setSpacing(5);
            seatColumn1.setPadding(new Insets(20, 0, 0, 10));
        }

                                                    //--row 1 (seats 11 to 21)--//
        for (int i = 11; i <= 21; i = i + 2) {
            Button seatButton = new Button("Seat " + i);
            seatButton.setStyle("-fx-background-color: green; -fx-text-fill: white;");

            seatColumn1.getChildren().add(seatButton);
            seatColumn1.setSpacing(5);
            seatColumn1.setPadding(new Insets(20, 0, 0, 10));
        }

                                                //SeatColumn2 (seats 2 to 8)
        VBox seatColumn2 = new VBox();
        for (int i = 2; i <= 8; i = i + 2) {
            Button seatButton = new Button("Seat 0" + i);
            seatButton.setStyle("-fx-background-color: green; -fx-text-fill: white;");

            seatColumn2.getChildren().add(seatButton);
            seatColumn2.setSpacing(5);
            seatColumn2.setPadding(new Insets(20, 100, 0, 10));
        }

                                                         //--SeatColumn2 (seats 10 to 20)--//
        for (int i = 10; i <= 20; i = i + 2) {
            Button seatButton = new Button("Seat " + i);
            seatButton.setStyle("-fx-background-color: green; -fx-text-fill: white;");

            seatColumn2.getChildren().add(seatButton);
            seatColumn2.setSpacing(5);
            seatColumn2.setPadding(new Insets(20, 100, 0, 10));
        }


        //----------SECTION 2 OF THE TRAIN (RIGHT HANDSIDE)-----------//

                                                //--SeatColumn3 (seats 22 to 42)--//
        VBox seatColumn3 = new VBox();
        for (int i = 22; i <= 42; i = i + 2) {
            Button seatButton = new Button("Seat " + i);
            seatButton.setStyle("-fx-background-color: green; -fx-text-fill: white;");

            seatColumn3.getChildren().add(seatButton);
            seatColumn3.setSpacing(5);
            seatColumn3.setPadding(new Insets(20, 0, 0, 0));
        }

                                                    //--SeatColumn4 (seats 23 to 41)--//
        VBox seatColumn4 = new VBox();
        for (int i = 23; i <= 41; i = i + 2) {
            Button seatButton = new Button("Seat " + i);
            seatButton.setStyle("-fx-background-color: green; -fx-text-fill: white;");

            seatColumn4.getChildren().add(seatButton);
            seatColumn4.setSpacing(5);
            seatColumn4.setPadding(new Insets(20, 0, 0, 10));
        }

        Button lowerButton = new Button("           Seating Arrangement (View only)            ");
        lowerButton.setStyle("-fx-background-color: #2F0B3A; -fx-text-fill: white;");
        HBox lowerRow = new HBox(lowerButton);
        lowerRow.setPadding(new Insets(50,20,20,45));

                                                //---ADDING ELEMENTS TO THE FLOWPANE---//
        FlowPane flowPane2 = new FlowPane();
        flowPane2.getChildren().add(upperRow);
        flowPane2.getChildren().add(section1);
        flowPane2.getChildren().add(section2);
        flowPane2.getChildren().add(seatColumn1);
        flowPane2.getChildren().add(seatColumn2);
        flowPane2.getChildren().add(seatColumn3);
        flowPane2.getChildren().add(seatColumn4);
        flowPane2.getChildren().add(lowerRow);

        flowPane2.setStyle("-fx-background-color: black; ");  //--Changing the Flowpane Background Color--//

                                                        //---STARTING UP THE GUI----//
        Stage startProgram2 = new Stage();
        startProgram2.setScene(new Scene(flowPane2));
        startProgram2.setMinWidth(435);
        startProgram2.setMaxWidth(435);
        startProgram2.setMinHeight(670);
        startProgram2.setMaxHeight(670);
        startProgram2.setMaximized(false);
        startProgram2.setTitle("DENUWARA MENIKE TRAIN");
        startProgram2.showAndWait();
    }

    private static void viewEmptySeats() {
        TrainSeatsGui();         //--Starting up of the Main GUI after the Data is loaded--//
    }

    private static void storeData(){
                                                //--Adding the HASHMAP Data into collection--//
        Document document = new Document();
        HASHMAP.forEach((s, s2) -> document.append("" + s , s2));

        try {
            Collection.insertOne(document);
        }
        catch (NullPointerException e){
            e.printStackTrace();
        }
                                            //--Adding the HASHMAP2 Data into collection2--//

        Document document2 = new Document();
        HASHMAP2.forEach((s, s2) -> document2.append("" + s , s2));

        try {
            Collection2.insertOne(document2);
        }
        catch (NullPointerException e){
            e.printStackTrace();
        }

        System.out.println("Data has been Stored!");
        TrainSeatsGui();         //--Starting up of the Main GUI after the Data is loaded--//
    }

    private static void loadData(){
                                                                    //--Loading Data from Collection to HASHMAP--//
        Collection.find().forEach((Block<Document>) document -> {
            ArrayList<String> key = new ArrayList<>(document.keySet());
            ArrayList <Object>value = new ArrayList<>(document.values());

            for (int i = 0; i < key.size(); i++  ) {
                for (int j = 0; j < value.size(); j++) {
                    if (String.valueOf(key.get(i)).equals("_id"))continue;
                    HASHMAP.put(String.valueOf(key.get(i)), String.valueOf(value.get(i)));
                }
            }
        });
                                                                    //--Loading Data from Collection2 to HASHMAP2--//
        Collection2.find().forEach((Block<Document>) document2 -> {
            ArrayList<String> key2 = new ArrayList<>(document2.keySet());
            ArrayList <Object>value2 = new ArrayList<>(document2.values());

            for (int i = 0; i < key2.size(); i++  ) {
                for (int j = 0; j < value2.size(); j++) {
                    if (String.valueOf(key2.get(i)).equals("_id"))continue;
                    HASHMAP2.put(String.valueOf(key2.get(i)), String.valueOf(value2.get(i)));
                }
            }
        });

        System.out.println("Data has been Loaded!");
        TrainSeatsGui();          //--Starting up of Main GUI after the Data is loaded--//
    }

    private static void viewOrderedSeats() {
                                                    //---Getting the keyset & values from the HASHMAP2 separately---//
        String[] key = HASHMAP2.keySet().toArray(new String[0]);
        String[] value = HASHMAP2.values().toArray(new String[0]);

        ArrayList<String> Arraylist = new ArrayList<>();     //---Concatenating the keyset & relevant value //
        for (int i = 0; i < HASHMAP2.size(); i = i + 1) {       //--as a single String value using an ArrayList---//
            Arraylist.add(key[i] + "-" + value[i] );
        }

        String[] Array = Arraylist.toArray(new String[0]);    //--Transferring the elements from ArrayList to Array--//

                                                        //---Sorting the Elements using Bubble Sort Algorithm---//
        String count;
        for (int t = 0; t < Arraylist.size() - 1; t = t + 1){
            for (int i = 0; i < Arraylist.size() - t - 1; i = i + 1){
                if (Array[i + 1].compareTo(Array[i]) < 0){
                    count = Array[i];
                    Array[i] = Array[i + 1];
                    Array[i + 1] = count;
                }
            }
        }
        for (int i = 0; i < Arraylist.size(); i = i + 1){
            System.out.println(Array[i]);
        }

        TrainSeatsGui();         //--Starting up the Main GUI--//
    }

    private static void deleteBooking() {

        CustomerDetailsGui();                 //---Getting the User Details (Name,ID) for seat deletion using GUI---//

        String Name = firstNameTextField.getText().toUpperCase() + " " + surNameTextField.getText().toUpperCase();
        String ID = idTextField.getText().toUpperCase();                 //--Getting Customer's inputs (Name & ID)--//

        if (HASHMAP2.containsKey(Name)){
            String Name2 = HASHMAP2.get(Name);              //--Extracting the relevant Seat for the Name & ID--//
            String ID2 = HASHMAP.get(ID);

            if (Name2.equals(ID2)){                  //---Validating and comparing the Customer Name & Customer ID---//
                HASHMAP.remove(idTextField.getText().toUpperCase());
                HASHMAP2.remove(Name);
                System.out.println(Name + ", your booked seat, " + Name2 + " has been removed! ");

                TrainSeatsGui();                       //--Starting up Main GUI to display the booked seats--//
            }
            else {
                System.out.println(Name + ", there is no seat available to your " +
                        "name or you might have entered a wrong ID number or might have deleted the seat.");
            }
        }
        else {
            System.out.println("Could not find a seat to your Name. Please make sure you have booked a seat, " +
                    "entered the Name & ID correctly and try again! ");
        }
    }

    private static void  findSeatByCustomerName(String trip) {

        LocalDate pickDate = datePicker.getValue();                             // Getting the Date picked by the user

        CustomerDetailsGui();                             //---Getting the User Details (Name,ID) using GUI---//

        String Name = firstNameTextField.getText().toUpperCase() + " " + surNameTextField.getText().toUpperCase();
        String ID = idTextField.getText().toUpperCase();            //--Getting Customer's inputs (Name & ID)--//

        if (HASHMAP2.containsKey(Name)) {
            String Name2 = HASHMAP2.get(Name);                 //--Extracting the relevant Seat for the Name & ID--//
            String ID2 = HASHMAP.get(ID);

            if (Name2.equals(ID2)){                   //--Validating and comparing the Customer Name & Customer ID--//
                String checkSeat = HASHMAP.get(ID);
                System.out.println(Name +  ", your booked Seat is " + checkSeat + ".");
                System.out.println("The Booking Date is " + pickDate + "." );
                System.out.println("The trip is from " + trip + ".");

                TrainSeatsGui();              //--Starting up Main GUI to display the booked seats--//
            }
            else  {
                System.out.println(Name + ", there is no seat available " +
                        "to your name or you might have entered a wrong ID number or might have deleted the seat.");
            }
        }
        else {
            System.out.println("Could not find a seat to your Name. Please make sure you have booked a seat, " +
                    "entered the name correctly and try again! ");
        }
    }

    private static void quit() {
        System.exit(0);              //--Program Termination when "Q" is pressed--//
    }
}
import com.mongodb.Block;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Scanner;
import java.util.logging.Level;

public class PassengerQueue {

    private static Scanner sc = new Scanner(System.in);
    public static LinkedList<String> PassengerLinkedList = new LinkedList<>();      //Defining the (Passenger Queue)
    public static ArrayList<String> importNameList = new ArrayList<>();         // Defining the waiting Room ArrayList
    public static ArrayList<String> tempArrayList = new ArrayList<>();          // Defining 2 temporary ArrayLists
    public static ArrayList<String> tempArrayList2 = new ArrayList<>();

    public static MongoDatabase Database;                  //---Defining the Mongo Database to store & load Data---//
    static MongoCollection<Document> Collection3;

    static int maxLength = 0;                   //----Defining Time Variables
    static double averageTime = 0;
    static int first = 0;
    static int last = 0;


    public void addPassenger() {
        TrainStation trainStationObject = new TrainStation();              // Creating TrainStation object to access
                                                                                              //TrainStation Class
        display();                           //----Display the Waiting room name list----//

        if (isFull()){
            System.out.println("Train Queue is Full.");
        }
        else {

            if (importNameList.size() != 0) {       //Checking whether waiting room is empty.
                while (true) {                                   // Getting a random number to add Passengers to Queue
                    int count = (int) (1 + (Math.random() * 6));

                    if (importNameList.size() >= count) {

                        System.out.println("\n" + count + " Passenger/Passengers can be moved to Train Queue. \n");
                        for (int i = 0; i < count; i++) {

                            String passengerName = importNameList.get(i);
                            PassengerLinkedList.add(passengerName);         //Adding passenger name to Train Queue.

                        }
                        for (int i = 0; i < count; i++) {
                            String passengerName = importNameList.get(0);
                            importNameList.remove(passengerName);          // Removing the passenger from waiting room.
                        }
                        break;
                    }
                }
            }
            else {
                System.out.println("The Waiting Room is Empty! (All the passengers have been moved to the Train " +
                                                                                                            "Queue)");
            }
        }
        trainStationObject.gui();
    }

    public void viewTrainQueue() {                //-------View The Train Queue----//

        TrainStation trainStationObject = new TrainStation();    // Creating TrainStation object to access TrainStation
                                                                                                            // Class
        trainStationObject.gui();
    }

    public void deletePassenger() {                      //------Delete a Passenger from the queue----//

        TrainStation trainStationObject = new TrainStation();    // Creating TrainStation object to access TrainStation
                                                                                                            // Class
        Passenger passengerObject = new Passenger();                  //--Calling the Passenger Class---//
        System.out.println("Enter your first name: ");
        String Name1 = sc.nextLine().toUpperCase();

        System.out.println("Enter your  surname: ");
        String Name2 = sc.nextLine().toUpperCase();

        passengerObject.setName(Name1,Name2);                     //---Concatenating the first name & surname--//

        if (PassengerLinkedList.contains(passengerObject.getName())){
            PassengerLinkedList.remove(passengerObject.getName());              // Removing Passenger from Train Queue
            importNameList.remove(passengerObject.getName());
            System.out.println(passengerObject.getName() + ", has been removed from the Train Queue.");
            trainStationObject.gui();
        }
        else {
            System.out.println("This is an Invalid Name. Please enter a valid name.");
        }
    }

    public void storeData() {                                   //------Store Train queue Details to Database----//
        Document document = new Document();

        for (int i=0; i < PassengerLinkedList.size(); i++ ){
            String TrainQueueName = PassengerLinkedList.get(i);
            document.append(TrainQueueName, "");                        //-- Adding Passenger name to document--//
        }

        try {
            java.util.logging.Logger.getLogger("org.mongodb.driver").setLevel(Level.SEVERE);
            MongoClient client = MongoClients.create();
            Database = client.getDatabase(String.valueOf(TrainStation.value));
            Collection3 = Database.getCollection(TrainStation.Destination + " - Train Queue");
            Collection3.insertOne(document);                //---Insert document into the Collection--//

            System.out.println("Data has been Saved.");
        }
        catch (NullPointerException e){
            e.printStackTrace();
        }
    }

    public void loadData() {                                             //------Load Data from Database----//

        MongoClient client = MongoClients.create();
        Database = client.getDatabase(String.valueOf(TrainStation.value));
        Collection3 = Database.getCollection(TrainStation.Destination + " - Train Queue");

        Collection3.find().forEach((Block<Document>) document -> {              //----Creating a Data Collection----//
            ArrayList<String> key = new ArrayList<>(document.keySet());

            for (int i = 0; i < key.size(); i++  ) {
                    if (String.valueOf(key.get(i)).equals("_id"))continue;                  //Getting only the Keyset
                        if (PassengerLinkedList.contains(String.valueOf(key.get(i)))){
                            System.out.println(key.get(i) + " is already loaded.");
                        }
                        else {
                            PassengerLinkedList.add(String.valueOf(key.get(i)));       //--Adding names to Linklist--//
                        }
            }
        });

        System.out.println("Data has been Loaded.");
        System.out.println(PassengerLinkedList);
    }

    private void display(){                                     //------Display the Waiting room Passenger list----//

        System.out.println("Waiting Room : " + importNameList);
    }

    public void run() throws IOException {

        if (PassengerLinkedList.size() != 0) {                                              //  Creating a Text File
            File file = new File(TrainStation.value + " - " + TrainStation.Destination + " - Train Queue " +
                    "Report.txt");
            FileWriter fileWriter = new FileWriter(file);
            PrintWriter printWriter = new PrintWriter(fileWriter);

            String passengerReport;                        //--Defining time variables for time and Passenger Details
            int timeCount;
            int totalTime = 0;
            int finalTime = 0;

            tempArrayList.addAll(PassengerLinkedList);      // Adding all the Passenger names to a Temporary ArrayList

            for (int i = 0; i < tempArrayList.size() + 1; i++) {

                if (isEmpty()) {                            // Continue simulation until the Queue is empty
                    System.out.println("All the Passengers have been moved to Train or No Passengers available in " +
                            "the Train Queue.");
                    break;
                } else {

                    if (i == 0) {             // Getting Data of First Passenger in the Queue to get  Min waiting Time
                        Passenger passengerObject = new Passenger();

                        int randomNumber1 = (int) (1 + (Math.random() * 6));
                        int randomNumber2 = (int) (1 + (Math.random() * 6));
                        int randomNumber3 = (int) (1 + (Math.random() * 6));
                        //Setter for Random numbers
                        passengerObject.setSecondsInQueue(randomNumber1, randomNumber2, randomNumber3);

                        String passengerName = tempArrayList.get(i);       //Getting Passenger Name
                        PassengerLinkedList.remove(passengerName);            //Removing the Passenger from the Queue.

                        timeCount = passengerObject.getSeconds();            //Getting random generated time(Getter)

                        totalTime = totalTime + timeCount;                // Calculating waiting time of the Passenger

                        finalTime = totalTime + finalTime;                // Calculating final total of waiting time

                        passengerReport = tempArrayList.get(i) + " : " + "Waiting Time = " + totalTime + "s.";
                        first = totalTime;            // Getting the Min waiting time according to the First passenger


                        tempArrayList2.add(passengerReport);     // Adding Passenger Details to a temporary Array List

                        printWriter.println(passengerReport);         // Adding First Passenger's Details to Text File
                    }
                    else if (i == tempArrayList.size() - 1) {      //Getting Data of Last Passenger in the Queue for
                                                                                            // max waiting Time
                        Passenger passengerObject = new Passenger();

                        int randomNumber1 = (int) (1 + (Math.random() * 6));
                        int randomNumber2 = (int) (1 + (Math.random() * 6));
                        int randomNumber3 = (int) (1 + (Math.random() * 6));
                        //Setter for Random
                        passengerObject.setSecondsInQueue(randomNumber1, randomNumber2, randomNumber3);

                        String passengerName = tempArrayList.get(i);            //Getting Passenger Name
                        PassengerLinkedList.remove(passengerName);            //Removing the Passenger from the Queue.

                        timeCount = passengerObject.getSeconds();              //Getting random generated time(Getter)

                        totalTime = totalTime + timeCount;              // Calculating waiting time of the Passenger


                        finalTime = totalTime + finalTime;               // Calculating final total of waiting time

                        passengerReport = tempArrayList.get(i) + " : " + "Waiting Time = " + totalTime + "s.";
                        last = totalTime;               // Getting the Max waiting time according to the Last passenger

                        tempArrayList2.add(passengerReport);      // Adding Passenger Details to a temporary Array List

                        printWriter.println(passengerReport);          // Adding Last Passenger's Details to Text File
                    } else {
                        Passenger passengerObject = new Passenger();

                        int randomNumber1 = (int) (1 + (Math.random() * 6));
                        int randomNumber2 = (int) (1 + (Math.random() * 6));
                        int randomNumber3 = (int) (1 + (Math.random() * 6));
                                                                                             //Setter for Random number
                        passengerObject.setSecondsInQueue(randomNumber1, randomNumber2, randomNumber3);

                        String passengerName = tempArrayList.get(i);        //Getting Passenger Name
                        PassengerLinkedList.remove(passengerName);             //Removing the Passenger from the Queue.

                        timeCount = passengerObject.getSeconds();        //Getting random generated time(Getter)

                        totalTime = totalTime + timeCount;          // Calculating waiting time of the Passenger

                        finalTime = totalTime + finalTime;          // Calculating final total of waiting time

                        passengerReport = tempArrayList.get(i) + " : " + "Waiting Time = " + totalTime + "s.";

                        tempArrayList2.add(passengerReport);      // Adding Passenger Details to a temporary Array List

                        printWriter.println(passengerReport);          // Adding other Passengers' Details to Text File
                    }
                }
            }                                                                // Calculating average time for the Queue
            averageTime = Math.round((double) finalTime / tempArrayList.size() * 100.0) / 100.0;

                                                          // Creating TrainStation object to access TrainStation class
            TrainStation trainStationObject = new TrainStation();

            trainStationObject.gui2Report();                                    // Displaying gui2 report

            printWriter.println("\nPassenger Queue length = " + tempArrayList.size() + " Passengers.");
            printWriter.println("Minimum Waiting Time = " + first + "s.");
            printWriter.println("Maximum Waiting Time = " + last + "s.");
            printWriter.println("Average Waiting Time = " + averageTime + "s.");

            printWriter.close();                     //Closing the Text File after entering the Passenger Details

            tempArrayList.clear();                              // Resetting required variables
            tempArrayList2.clear();
            first = 0;
            last = 0;
        }
        else {
            System.out.println("Cannot Load the Report. There are no Passengers in the Queue to board the Train.");
        }
    }

    static boolean isFull(){                                // Checking whether the Train Queue is Full
        boolean status = false;
        if (PassengerLinkedList.size() == 42){
            status = true;
        }
        return status;
    }

    static boolean isEmpty() {                            // Checking whether the Train Queue is Empty
        boolean status = false;
        if (PassengerLinkedList.size() == 0){
            status = true;
        }
        return status;
    }

    public int getMaxLength() {                                 // Getting max Length of the Queue
        return maxLength = tempArrayList.size();
    }

    public void quit() {                            //------Quit the program-----//
        System.exit(0);
    }
}
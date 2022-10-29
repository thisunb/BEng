/*
Student Name - M.R.T.T Bandara
UoW ID - W1761298
IIT ID - 2019356
*/

import java.io.FileReader;
import java.io.LineNumberReader;
import java.lang.*;

public class DataStructure {

    public static int numberOfNodes = 0;
    private static int[][] graph;

    public static void main(String[] args) throws java.lang.Exception {

        Stopwatch timer = new Stopwatch();       // Starting the timer to get elapsed time

        readData();            // Executing the method for reading input file data

        printGraph();             // Print Network graph

        MaximumFlow maximumFlowObj = new MaximumFlow();

        System.out.println("\n* The Maximum possible Flow is " + maximumFlowObj.fordFulkerson(graph, 0, numberOfNodes - 1));       // Executing Ford Fulkerson & Displaying the Max flow

        System.out.println("* Elapsed Time - " + timer.elapsedTime() + "s");      // Printing the elapsed time
    }


    public static void readData() throws java.lang.Exception {

        FileReader fileReader = new FileReader("Resources/UoW/ladder_1.txt");
        LineNumberReader lineNumberReader = new LineNumberReader(fileReader);

        for (String line = lineNumberReader.readLine(); line != null; line = lineNumberReader.readLine()) {

            if (lineNumberReader.getLineNumber() == 1) {                 // Getting the no of nodes from the 1st line
                numberOfNodes = Integer.parseInt(line);
                graph = new int[numberOfNodes][numberOfNodes];
            }
            if (lineNumberReader.getLineNumber() > 1) {                // Getting the data starting from line 2 to end
                parseData(graph, line);
            }
        }
    }


    public static void parseData(int[][] graph, String line){
        String[] nodes = line.split(" ");                 // Creating a temp array to store the line data
        int startNode = Integer.parseInt(nodes[0]);
        int endNode = Integer.parseInt(nodes[1]);
        int capacity = Integer.parseInt(nodes[2]);
        graph[startNode][endNode] = capacity;                   // Setting the capacity for edges
    }


    public static void printGraph(){
        for(int i = 0; i < numberOfNodes; i++){                // Read lines of the array
            for(int j = 0; j < numberOfNodes; j++){
                System.out.print((graph[i])[j] + "  ");         // Print element by element in a line
            }
            System.out.println();
        }
        System.out.println();                                 // Prints an additional line after printing the graph
    }
}
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict2client;

import server.Exception_Exception;

/**
 *
 * @author Thisun Bandara
 */
public class ICT2Client {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        ICT2Client ict2ClientObj = new ICT2Client();
        
        ict2ClientObj.execute();
    }
    
     
    public void execute(){
    
        if(testConnection() == 0.0){
            System.out.println("Connected to server successfully.");
            
            
            //------------------------Testing ShortestString method---------------------------//
            
            System.out.println("\nTesting the shortestString method:\n ");
            
            String s1 = "john";
            String s2 = "Luke";
            
           String answer =  shortestString(s1, s2);
           System.out.println("* Shortest String out of " + s1 + " & " + s2 + " is " + answer);
 
           
           s1 = "Thisun";
           s2 = "Avishka";
            
           answer =  shortestString(s1, s2);
           System.out.println("* Shortest String out of " + s1 + " & " + s2 + " is " + answer);
           
           s1 = "Walker";
           s2 = "Richards";
            
           answer =  shortestString(s1, s2);
           System.out.println("* Shortest String out of " + s1 + " & " + s2 + " is " + answer);
           
           
           //------------------------Testing safeShortestString method---------------------------//
           
           System.out.println("\nTesting the safeShortestString method:\n ");
           
           s1 = null;
           s2 = "Luke";
            
            try {
                answer =  safeShortestString(s1, s2);
                System.out.println("* Shortest String out of " + s1 + " & " + s2 + " is " + answer);
            } 
            catch (Exception_Exception ex) {
                System.out.println("* " + ex);
            }
           
          
           s1 = "Thisun";
           s2 = null;
            
            try {
                answer =  safeShortestString(s1, s2);
                System.out.println("* Shortest String out of " + s1 + " & " + s2 + " is " + answer);
            } 
            catch (Exception_Exception ex) {
                System.out.println("* " + ex);
            }
           
          
           s1 = null;
           s2 = null;
            
            try {
                answer =  safeShortestString(s1, s2);
                System.out.println("* Shortest String out of " + s1 + " & " + s2 + " is " + answer);
            } 
            catch (Exception_Exception ex) {
                System.out.println("* " + ex);
            }
            
            
           s1 = "Wesley";
           s2 = "Kingsley";
            
            try {
                answer =  safeShortestString(s1, s2);
                System.out.println("* Shortest String out of " + s1 + " & " + s2 + " is " + answer);
            } 
            catch (Exception_Exception ex) {
                System.out.println("* " + ex);
            }
            
            
            //------------------------Testing addIntegerOnServer metrhod--------------------// 
            
            System.out.println("\nTesting the addIntegerOnServer method: \n ");
            
            int integer1  = 10;
            addIntegerOnServer(integer1);
            System.out.println("* Adding integer1, " + integer1 + " to server.");
            
            int integer2 = 20;
            addIntegerOnServer(integer2);
            System.out.println("* Adding integer2, " + integer2 + " to server.");
            
            int integer3 = 1000;
            addIntegerOnServer(integer3);
            System.out.println("* Adding integer3, " + integer3 + " to server.");
            
            int integer4 = 25;
            addIntegerOnServer(integer4);
            System.out.println("* Adding integer4, " + integer4 + " to server.");
            
            int integer5 = 12;
            addIntegerOnServer(integer5);
            System.out.println("* Adding integer5, " + integer5 + " to server.");
            
            
              //------------------------Testing getSmallestInteger metrhod--------------------// 
            
            
            System.out.println("\nTesting getSmallestInteger method: \n");
            
            int smallestInteger = getSmallestInteger();
            
            System.out.println("* The smallest Integer out of all Integers added to server is " + smallestInteger );
            
            
            
             //------------------------Testing getAllIntegerSamplesBelow metrhod--------------------// 
             
            System.out.println("\nTesting getAllIntegerSamplesBelow method: \n");
             
            int inputInteger = 50;
             
            System.out.println("* The List of integers that are smaller or equal to entered integer - " + getAllIntegerSamplesBelow(inputInteger));
            
            inputInteger = 25;
             
            System.out.println("* The List of integers that are smaller or equal to entered integer - " + getAllIntegerSamplesBelow(inputInteger));
            
            inputInteger = 100;
             
            System.out.println("* The List of integers that are smaller or equal to entered integer - " + getAllIntegerSamplesBelow(inputInteger));
            
        }
        
        else{
            System.out.println("Server is not connected.");
        }
    }

    
    private static Double testConnection() {
        server.ICT2WebService_Service service = new server.ICT2WebService_Service();
        server.ICT2WebService port = service.getICT2WebServicePort();
        return port.testConnection();
    }
    

    private static String shortestString(java.lang.String s1, java.lang.String s2) {
        server.ICT2WebService_Service service = new server.ICT2WebService_Service();
        server.ICT2WebService port = service.getICT2WebServicePort();
        return port.shortestString(s1, s2);
    }

    
    private static String safeShortestString(java.lang.String s1, java.lang.String s2) throws Exception_Exception {
        server.ICT2WebService_Service service = new server.ICT2WebService_Service();
        server.ICT2WebService port = service.getICT2WebServicePort();
        return port.safeShortestString(s1, s2);
    }

    
    private static Boolean addIntegerOnServer(java.lang.Integer integer) {
        server.ICT2WebService_Service service = new server.ICT2WebService_Service();
        server.ICT2WebService port = service.getICT2WebServicePort();
        return port.addIntegerOnServer(integer);
    }

    
    private static Integer getSmallestInteger() {
        server.ICT2WebService_Service service = new server.ICT2WebService_Service();
        server.ICT2WebService port = service.getICT2WebServicePort();
        return port.getSmallestInteger();
    }
    

    private static java.util.List<java.lang.Integer> getAllIntegerSamplesBelow(java.lang.Integer integer) {
        server.ICT2WebService_Service service = new server.ICT2WebService_Service();
        server.ICT2WebService port = service.getICT2WebServicePort();
        return port.getAllIntegerSamplesBelow(integer);
    }
}
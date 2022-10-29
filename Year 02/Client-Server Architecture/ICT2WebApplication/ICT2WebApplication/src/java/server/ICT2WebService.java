/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package server;

import java.util.ArrayList;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author Thisun Bandara
 */
@WebService(serviceName = "ICT2WebService")
public class ICT2WebService {
    
    ArrayList <Integer> storeIntegers = new ArrayList();

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "testConnection")
    public Double testConnection() {
      
        System.out.println("Server Connected successfully.");
           
        return 0.0;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "shortestString")
    public String shortestString(@WebParam(name = "s1") String s1, @WebParam(name = "s2") String s2) {
        
        if(s1.length() < s2.length()){
            return s1;
        }
        
        else{
            return s2;
        }
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "safeShortestString")
    public String safeShortestString(@WebParam(name = "s1") String s1, @WebParam(name = "s2") String s2) throws Exception {
        
        
        if(s1 == null || s2 == null){
        
            throw new Exception("Cannot have null values");
        }
        
        else{
            if(s1.length() < s2.length()){
                return s1;
            }
            else{
                return s2;
            }
        }
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "addIntegerOnServer")
    public Boolean addIntegerOnServer(@WebParam(name = "integer") Integer integer) {
        
        storeIntegers.add(integer);
        System.out.println("Stored " + integer + "successfully.");
        return true;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getSmallestInteger")
    public Integer getSmallestInteger() {
        
        int smallestInteger = storeIntegers.get(0);
        
        for(int i = 0; i < storeIntegers.size(); i++){
        
            if(smallestInteger > storeIntegers.get(i)){
                
                smallestInteger = storeIntegers.get(i);
            }
        }
        
        System.out.println("Server returned " + smallestInteger + "as the smallest integer" );
        return smallestInteger ;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getAllIntegerSamplesBelow")
    public ArrayList<Integer> getAllIntegerSamplesBelow(@WebParam(name = "integer") Integer integer) {
       
        ArrayList<Integer> integers = new ArrayList<>();
        
        for(int i = 0; i < storeIntegers.size(); i++){
   
            if (storeIntegers.get(i) < integer || storeIntegers.get(i) == integer){
            
                System.out.println("");
                integers.add(storeIntegers.get(i));
            }
        }
        return integers;
    }
}
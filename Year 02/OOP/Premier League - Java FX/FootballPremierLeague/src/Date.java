import java.util.InputMismatchException;
import java.util.Scanner;

public class Date {

    private int year;                                          // Creating the instance variables to get the date value
    private int month;
    private int day;

    public Date (int year, int month, int day){                                             // Creating the constructor
        this.year = year;
        this.month = month;
        this.day = day;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;
    }


    @Override                                  // Creating the toString method to display the date in a specific format
    public String toString(){

        if (day < 10 && month < 10) {                                 // Checking day and month to set as double digits
            return  "0" + day + "." + "0" + month + "." + year;
        }
        else if(month < 10) {                                                 // Checking month to set as double digits
            return day + "." + "0" +  month + "." + year;
        }
        else if(day < 10) {                                                     // Checking day to set as double digits
            return "0" + day + "." + month + "." + year;
        }
        else {
            return day + "." + month + "." + year;                                                // Returning the date
        }
    }


    public void dateCheckConsole(){

        Scanner sc = new Scanner(System.in);

        boolean loop = true;

        while(loop){

            try {
                System.out.println(" Enter Year :");
                year = sc.nextInt();

                while(year < 2020 || year > 2025) {                                   // Setting year between 2020-2025
                    System.out.println("Incorrect value for year!");
                    System.out.println("Enter a correct value for year again : ");
                    year = sc.nextInt();
                }
                loop = false;
            }
            catch (InputMismatchException e){
                System.out.println("Invalid Input.\n");
                sc.nextLine();
            }
        }

        loop = true;

        while(loop){

            try {
                System.out.println(" Enter Month : ");
                month = sc.nextInt();

                while(month > 12 || month == 0) {                                       // Setting month between 1 - 12
                    System.out.println("Incorrect value for month!");
                    System.out.println("Enter a correct value for month again : ");
                    month = sc.nextInt();
                }
                loop = false;
            }
            catch (InputMismatchException e){
                System.out.println("Invalid Input.\n");
                sc.nextLine();
            }
        }

        loop = true;

        while(loop) {
            try {                                                             // Setting value for day between 1-30 for
                if (month == 4 || month == 6 || month == 9 || month == 11) {                     // the selected months

                    System.out.println(" Enter Day :");
                    day = sc.nextInt();

                    while (day < 1 || day >= 31) {
                        System.out.println("incorrect value for day!");
                        System.out.println("Enter a correct value for day again : ");
                        day = sc.nextInt();
                    }
                }
                else if (month == 2) {                                         // Validating value for day for February

                    System.out.println(" Enter Day :");
                    day = sc.nextInt();

                    if ((year % 4) == 0) {

                        while (day < 1 || day >= 30) {
                            System.out.println("Incorrect value for day!");
                            System.out.println("Enter a correct value for day again : ");
                            day = sc.nextInt();
                        }
                    }
                    else {

                        while (day < 1 || day >= 29) {
                            System.out.println("Incorrect value for days!");
                            System.out.println("Enter a value for day again : ");
                            day = sc.nextInt();
                        }
                    }
                }
                else {                                                         // Validating day value for other months
                                                                                      // Setting day value between 1-31
                    System.out.println(" Enter Day :");
                    day = sc.nextInt();

                    while (day < 1 || day > 31) {
                        System.out.println("Incorrect value for day!");
                        System.out.println("Enter a correct value for day again : ");
                        day = sc.nextInt();
                    }
                }
                loop = false;
            }
            catch (InputMismatchException e) {
                System.out.println("Invalid Input.\n");
                sc.nextLine();
            }
        }
    }


    public void dateCheckGui(){                                             // Validating date entered in GUI component

        year = (int) (Math.random() * (2026 - 2020)) + 2020;
        month = (int) (Math.random() * (13 - 1)) + 1;

        if(month == 4 || month == 6 || month == 9 || month == 11) {           // Validate day count for selected months

            day = (int) (Math.random() * (31 - 1)) + 1;
        }

        else if(month == 2) {                                     // Selecting the correct day count for month February

            if((year % 4) == 0) {

                day = (int) (Math.random() * (30 - 1)) + 1;
            }
            else {
                day = (int) (Math.random() * (29 - 1)) + 1;
            }
        }
        else {                                                             // Validating the day count for other months
            day = (int) (Math.random() * (32 - 1)) + 1;
        }
    }
}
import java.io.Serializable;

public class MatchesPlayed implements Serializable {
                                                                // Creating instance variables to collect match details
    private String date;
    private String club1;
    private String club2;
    private int goalsScored1;
    private int goalsScored2;

    public MatchesPlayed(){                                                         // Creating the default constructor

    }
                                                                                     // Creating the second constructor
    public MatchesPlayed(String date, String club1, String club2, int goalsScored1, int goalsScored2){
        this.date = date;
        this.club1 = club1;
        this.club2 = club2;
        this.goalsScored1 = goalsScored1;
        this.goalsScored2 = goalsScored2;
    }

    public String getDate(){
        return date;
    }

    public void setDate(String date){
        this.date = date;
    }

    public String getClub1() {
        return club1;
    }

    public void setClub1(String club1) {
        this.club1 = club1;
    }

    public String getClub2() {
        return club2;
    }

    public void setClub2(String club2) {
        this.club2 = club2;
    }

    public int getGoalsScored1() {
        return goalsScored1;
    }

    public void setGoalsScored1(int goalsScored1) {
        this.goalsScored1 = goalsScored1;
    }

    public int getGoalsScored2() {
        return goalsScored2;
    }

    public void setGoalsScored2(int goalsScored2) {
        this.goalsScored2 = goalsScored2;
    }

    @Override                                              // Creating the toString method to display the match details
    public String toString(){
        return  "Date: " + date + ", " +
                "Club 1: " + club1 + ", " +
                "Goals Scored by " + club1 + " : " + goalsScored1 + ", " +
                "Club 2: " + club2 + ", " +
                "Goals Scored by " + club2 + " : " + goalsScored2;
    }
}
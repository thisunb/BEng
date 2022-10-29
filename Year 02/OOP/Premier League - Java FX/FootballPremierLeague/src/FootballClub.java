import java.io.Serializable;

public class FootballClub extends SportsClub implements Serializable {
                                                             // Creating instance variables to get FootballClub details
    private int noOfMatches;
    private int noOfWins;
    private int noOfDraws;
    private int noOfDefeats;
    private int noOfGoalsScored;
    private int noOfGoalsAgainst;
    private int goalDifference;
    private int noOfPoints;

    public FootballClub(){                                                          // Creating the default constructor

    }

    public FootballClub(String clubName, String clubType, String location, int matches, int wins, int draws,
                        int defeats, int goalsScored, int goalsAgainst, int goalDiff, int points){

        super(clubName,clubType,location);                           // Calling the super class to import the variables
        this.noOfMatches = matches;
        this.noOfWins = wins;
        this.noOfDraws = draws;
        this.noOfDefeats = defeats;
        this.noOfGoalsScored = goalsScored;
        this.noOfGoalsAgainst = goalsAgainst;
        this.goalDifference = goalDiff;
        this.noOfPoints = points;
    }

    public int getNoOfMatches() {
        return noOfMatches;
    }

    public void setNoOfMatches(int noOfMatches) {
        this.noOfMatches = noOfMatches;
    }

    public int getNoOfWins() {
        return noOfWins;
    }

    public void setNoOfWins(int noOfWins) {
        this.noOfWins = noOfWins;
    }

    public int getNoOfDraws() {
        return noOfDraws;
    }

    public void setNoOfDraws(int noOfDraws) {
        this.noOfDraws = noOfDraws;
    }

    public int getNoOfDefeats() {
        return noOfDefeats;
    }

    public void setNoOfDefeats(int noOfDefeats) {
        this.noOfDefeats = noOfDefeats;
    }

    public int getNoOfGoalsScored() {
        return noOfGoalsScored;
    }

    public void setNoOfGoalsScored(int noOfGoalsScored) {
        this.noOfGoalsScored = noOfGoalsScored;
    }

    public int getNoOfGoalsAgainst() {
        return noOfGoalsAgainst;
    }

    public void setNoOfGoalsAgainst(int noOfGoalsAgainst) {
        this.noOfGoalsAgainst = noOfGoalsAgainst;
    }

    public int getGoalDifference() {
        return goalDifference;
    }

    public void setGoalDifference(int goalDifference) {
        this.goalDifference = goalDifference;
    }

    public int getNoOfPoints() {
        return noOfPoints;
    }

    public void setNoOfPoints(int noOfPoints) {
        this.noOfPoints = noOfPoints;
    }

    @Override                                        // Creating the toString method to display the football club stats
    public String toString(){
        return super.toString() + ", " +
                "Matches: " + noOfMatches + ", " +
                "Wins: " + noOfWins + ", " +
                "Draws: " + noOfDraws + ", " +
                "Defeats: " + noOfDefeats + ", " +
                "GS: " + noOfGoalsScored + ", " +
                "GA: " + noOfGoalsAgainst + ", " +
                "GD: " + goalDifference + ", " +
                "Points: " + noOfPoints;
    }
}
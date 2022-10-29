import java.io.IOException;

public interface LeagueManager {
    void addClub();
    void deleteClub();
    void displayStats();
    void displayTable();
    void enterMatchPlayed();
    void saveData() throws IOException;
    void loadData() throws IOException, ClassNotFoundException;
}
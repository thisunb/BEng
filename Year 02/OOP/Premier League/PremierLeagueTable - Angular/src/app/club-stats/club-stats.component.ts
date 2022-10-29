import { Component, OnInit } from '@angular/core';
import {HttpClient}from'@angular/common/http';

@Component({
  selector: 'app-club-stats',
  templateUrl: './club-stats.component.html',
  styleUrls: ['./club-stats.component.css']
})

export class ClubStatsComponent implements OnInit {

  constructor(private http:HttpClient) {}                                            // Creating constructor for HTTP

  ngOnInit(): void {}             

  clubDetails : any;                                                                        // Initialising variables
  matchList : any;
  sortPoints : any;
  sortWins : any;
  sortGS : any;
  randomMatch : any;


  sortByPoints(): void {                                                   // Method for sorting clubs by their points

    var checkUrl = new XMLHttpRequest();                                                // Checking the url is working
    checkUrl.timeout = 150;
    checkUrl.open('GET', 'http://localhost:8080/sortByPoints');       

    checkUrl.onreadystatechange = function(){
      if(this.readyState==4){
        if(this.status!=200){
          alert('No Server Response. Click OK to refresh page.');                      // Sending error message to user
          window.location.href = "http://localhost:4200";
        }
      }
    }
    checkUrl.send();                            


    this.http.get("http://localhost:8080/sortByPoints").toPromise().then(data => {          // Getting data from server 

    this.sortPoints = data;                                                                 
    
    for(var i = this.sortPoints.length; i < 20; i++){                 // Setting rows empty for elements without values

      this.sortPoints[i] = "";
    }                                                                                       // Displaying data in table

    this.clubDetails = [this.sortPoints[0],this.sortPoints[1],this.sortPoints[2],this.sortPoints[3],this.sortPoints[4],this.sortPoints[5],
    this.sortPoints[6],this.sortPoints[7],this.sortPoints[8],this.sortPoints[9],this.sortPoints[10],this.sortPoints[11],this.sortPoints[12],
    this.sortPoints[13],this.sortPoints[14],this.sortPoints[15],this.sortPoints[16],this.sortPoints[17],this.sortPoints[18],this.sortPoints[19]];
    
    });
  }
  

  sortByWins(): void {                                                          // Method for sorting clubs by their wins

    var checkUrl = new XMLHttpRequest();                                                   // Checking the url is working
    checkUrl.timeout = 150;
    checkUrl.open('GET', 'http://localhost:8080/sortByWins');

    checkUrl.onreadystatechange = function(){
      if(this.readyState==4){
        if(this.status!=200){
          alert('No Server Response. Click OK to refresh page.');                         // Sending error message to user
          window.location.href = "http://localhost:4200";
        }
      }
    }
    checkUrl.send();


    this.http.get("http://localhost:8080/sortByWins").toPromise().then(data => {               // Getting data from server

    this.sortWins = data;

    for(var i = this.sortWins.length; i < 20; i++){                      // Setting rows empty for elements without values

      this.sortWins[i] = "";
    }                                                                                          // Displaying data in table

    this.clubDetails = [this.sortWins[0],this.sortWins[1],this.sortWins[2],this.sortWins[3],this.sortWins[4],this.sortWins[5],
    this.sortWins[6],this.sortWins[7],this.sortWins[8],this.sortWins[9],this.sortWins[10],this.sortWins[11],this.sortWins[12],
    this.sortWins[13],this.sortWins[14],this.sortWins[15],this.sortWins[16],this.sortWins[17],this.sortWins[18],this.sortWins[19]];

    });
  }


  sortByGs(): void {                                                       // Method for sorting clubs by their goals scored

    var checkUrl = new XMLHttpRequest();                                                      // Checking the url is working
    checkUrl.timeout = 150;
    checkUrl.open('GET', 'http://localhost:8080/sortByGS');

    checkUrl.onreadystatechange = function(){
      if(this.readyState==4){
        if(this.status!=200){
          alert('No Server Response. Click OK to refresh page.');                            // Sending error message to user
          window.location.href = "http://localhost:4200";
        }
      }
    }
    checkUrl.send();
    

    this.http.get("http://localhost:8080/sortByGS").toPromise().then(data => {                    // Getting data from server

    this.sortGS = data;

    for(var i = this.sortGS.length; i < 20; i++){                           // Setting rows empty for elements without values
                                                              
      this.sortGS[i] = "";                                      
    }                                                                                             // Displaying data in table

    this.clubDetails = [this.sortGS[0],this.sortGS[1],this.sortGS[2],this.sortGS[3],this.sortGS[4],this.sortGS[5],
    this.sortGS[6],this.sortGS[7],this.sortGS[8],this.sortGS[9],this.sortGS[10],this.sortGS[11],this.sortGS[12],
    this.sortGS[13],this.sortGS[14],this.sortGS[15],this.sortGS[16],this.sortGS[17],this.sortGS[18],this.sortGS[19]];

    });
  }


  randomMatchPlayed(): void {                                                   // Method for random match played by two clubs

    var checkUrl = new XMLHttpRequest();                                                        // Checking the url is working
    checkUrl.timeout = 150;
    checkUrl.open('GET', 'http://localhost:8080/sortByPoints');

    checkUrl.onreadystatechange = function(){
      if(this.readyState==4){
        if(this.status!=200){
          alert('No Server Response. Click OK to refresh page.');                             // Sending error message to user
          window.location.href = "http://localhost:4200";
        }
      }
    }
    checkUrl.send();


    var date = "";                                                      // Initialising variables to store random match details
    var club1 = "";
    var club2 = "";
    var score1 = 0;
    var score2 = 0;                                                     // Checking min. no. of clubs are available for a match
                                                                        
    
    this.http.get("http://localhost:8080/randomMatch").toPromise().then(data => {                   // Getting data from server

      this.randomMatch = data;

      if(this.randomMatch.date == null) {

        alert("At least 2 clubs are required to play a Random Match!");                // Error message for club unavailability
      }

      else{

      date = this.randomMatch.date;
      club1 = this.randomMatch.club1;
      club2 = this.randomMatch.club2;
      score1 = this.randomMatch.goalsScored1;
      score2 = this.randomMatch.goalsScored2;


      this.http.get("http://localhost:8080/sortByPoints").toPromise().then(data => {                // Getting data from server

      this.sortPoints = data;

      for(var i = this.sortPoints.length; i < 20; i++){                       // Setting rows empty for elements without values

        this.sortPoints[i] = "";
      }                                                                                               // Updating data in table
  
      this.clubDetails = [this.sortPoints[0],this.sortPoints[1],this.sortPoints[2],this.sortPoints[3],this.sortPoints[4],this.sortPoints[5],
      this.sortPoints[6],this.sortPoints[7],this.sortPoints[8],this.sortPoints[9],this.sortPoints[10],this.sortPoints[11],this.sortPoints[12],
      this.sortPoints[13],this.sortPoints[14],this.sortPoints[15],this.sortPoints[16],this.sortPoints[17],this.sortPoints[18],this.sortPoints[19]];
  
      });                                                                                    // Displaying Random match details

      alert ("Random Match played (Results) \n\n" + "Date : " + date + "\n" + "Club 1 : " + club1 + ", " + "Score - " + score1 + " \n" +
      "Club 2 : " + club2 + ", " + "Score - " + score2);

    }
    });
  }


  allMatches(): void {                                                                   // Method to display all played matches         

    var checkUrl = new XMLHttpRequest();                                                          // Checking the url is working
    checkUrl.timeout = 150;
    checkUrl.open('GET', 'http://localhost:8080/sortByPoints');

    checkUrl.onreadystatechange = function(){
      if(this.readyState==4){
        if(this.status!=200){
          alert('No Server Response. Click OK to refresh page.');                               // Sending error message to user
          window.location.href = "http://localhost:4200";
        }
      }
    }
    checkUrl.send();

    this.http.get("http://localhost:8080/findMatchDetails").toPromise().then(data => {               // Getting data from server

      this.matchList = data;

      if(this.matchList.length == 0) {                                                        // Checking any matches are played 

        alert("No matches played so far.");                                                   
      }
  
      else{
        window.location.href="http://localhost:4200/matchDetails";          // Redirecting to matches page if match is available                 
      }

    });
  }


  getDetails(inputDate : any): void {                                                             // Method to get match by date

    var inputDateCharacters = inputDate.value.split('');

    if(inputDate.value != ""){                                                               // Checking date textfield is empty

      if(inputDateCharacters.length == 10 && inputDateCharacters[2] == "." && inputDateCharacters[5] == "." && 
        inputDateCharacters[4] != "."){

        var year = 0;                                                                             // Initialising date vatiables
        var month = 0;
        var day = 0;

        year = inputDateCharacters[6] + inputDateCharacters[7] + inputDateCharacters[8] + inputDateCharacters[9];
        month = inputDateCharacters[3] + inputDateCharacters[4];
        day = inputDateCharacters[0] + inputDateCharacters[1];

        if (month == 0 || month > 12){                                                             // Validating value for month

          alert("Invalid Date. Please enter a valid Date.");
        }

        else if ((month == 2 && (year % 4) == 0) && (day > 29 || day < 1)) {                     // Validating day value for Feb

          alert("Invalid Date. Please enter a valid Date.");
        }

        else if((month == 2 && (year % 4) != 0) && (day > 28 || day < 1)){                      

           alert("Invalid Date. Please enter a valid Date.");
        }                                                                                // Validating day value for other months

        else if((month == 4 || month == 6 || month == 9 || month == 11) && (day > 30 || day < 1)){    

          alert("Invalid Date. Please enter a valid Date.");
        }

        else if((month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) && (day > 31 || day < 1)){

          alert("Invalid Date. Please enter a valid Date.");
        }
        else{                                                                                      

          var checkUrl = new XMLHttpRequest();                                                      // Checking the url is working                            
          checkUrl.timeout = 150;
          checkUrl.open('GET', 'http://localhost:8080/sortByPoints');
      
          checkUrl.onreadystatechange = function(){
            if(this.readyState==4){
              if(this.status!=200){
                alert('No Server Response. Click OK to refresh page.');                           // Sending error message to user           
                window.location.href = "http://localhost:4200";
              }
            }
          }
          checkUrl.send();

          
          var array = [];

          this.http.get("http://localhost:8080/findMatchDetails").toPromise().then(data => {           // Getting data from server
        
            this.matchList = data;
        
            for(var i = 0; i < this.matchList.length; i++){
        
              if(this.matchList[i].date == inputDate.value){                      // Checking match is available for selected date
        
                var date = this.matchList[i].date;                                            // Adding match details to variables
                var clubName1 = this.matchList[i].club1;
                var clubName2 = this.matchList[i].club2;
              
                var clubScore1 = this.matchList[i].goalsScored1;
                var clubScore2 = this.matchList[i].goalsScored2;               // Adding all matches to an array for selected date 
                                                                                    
        
                array.push("\n\n" + "Date : " + date + "\n" + "Club 1 : " + clubName1 + ", " + "Score - " + clubScore1 + " \n" +
                "Club 2 : " + clubName2 + ", " + "Score - " + clubScore2);
        
              }
            }
            if(array.length == 0) {
                  
              alert("No matches found");                                        // Displaying message if matches are not available
            }
            else{
              alert("Matches Played for the selected Date:" + array);                  // Displaying all matches for selected date
            }
          });
        }
      }
      else {
        alert("Incorrect Date Format. \n\nPlease follow DD.MM.YYYY Format.\n\n Eg: 01.01.2020")
      }
    }
    else {
      alert("Please enter a date to find matches!")
    }
  }
}
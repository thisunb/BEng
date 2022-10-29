import { Component, OnInit } from '@angular/core';
import {HttpClient}from'@angular/common/http';

@Component({
  selector: 'app-match-details',
  templateUrl: './match-details.component.html',
  styleUrls: ['./match-details.component.css']
})

export class MatchDetailsComponent implements OnInit {

  title = 'MatchDetails';

  constructor(private http:HttpClient) {}                                              // Creating constructor for HTTP

  matchList : any;                                                      // Initialising variable to store match details 

  ngOnInit(): void {                                      

    this.http.get("http://localhost:8080/findMatchDetails").toPromise().then(data => {      // Getting data from server

      this.matchList = data;

    });
  }
}
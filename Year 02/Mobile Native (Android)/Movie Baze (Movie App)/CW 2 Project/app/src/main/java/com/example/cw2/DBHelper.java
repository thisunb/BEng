package com.example.cw2;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import java.io.File;

public class DBHelper extends SQLiteOpenHelper {

    public DBHelper(Context context) {                                              // Creating Database (DB)
        super(context, "MovieData.db", null, 1);
    }


    @Override                                                           // Creating table for movie details
    public void onCreate(SQLiteDatabase DB){
        DB.execSQL("create Table MovieDetails (title TEXT primary key, year TEXT, director TEXT, actors TEXT" +
                ", rating TEXT, review TEXT, favourites TEXT)");
    }


    @Override
    public void onUpgrade(SQLiteDatabase DB, int oldVersion, int newVersion) {

        DB.execSQL("drop Table if exists  MovieDetails");
    }


    public Boolean insertUserData(String title, String year, String director, String actors, String rating, String review){     // Inserting user entered data for a movie

        SQLiteDatabase DB = this.getWritableDatabase();

        ContentValues contentValues = new ContentValues();

        contentValues.put("title", title);
        contentValues.put("year", year);
        contentValues.put("director", director);
        contentValues.put("actors", actors);
        contentValues.put("rating", rating);
        contentValues.put("review", review);
        contentValues.put("favourites", "nFav");

        long result = DB.insert("MovieDetails", null, contentValues);

        return result != -1;
    }
                                                                            // Updating user entered data for a movie

    public void updateUserData(String title, String year, String director, String actors, String rating, String review, String favourite){

        SQLiteDatabase DB = this.getWritableDatabase();

        ContentValues contentValues = new ContentValues();

        contentValues.put("title", title);
        contentValues.put("year", year);
        contentValues.put("director", director);
        contentValues.put("actors", actors);
        contentValues.put("rating", rating);
        contentValues.put("review", review);
        contentValues.put("favourites", favourite);

        DB.update("MovieDetails", contentValues, "title=?", new String[]{title} );
    }


    public Cursor getData(){                                                                   // Retrieving all movie details (1)

        SQLiteDatabase database = this.getWritableDatabase();

        return database.rawQuery("Select * from MovieDetails", null);
    }


    public Cursor getMovieDetails(){                                                    // Retrieving all movie details (2)

        SQLiteDatabase database = this.getWritableDatabase();

        return database.rawQuery("Select * from MovieDetails", null);
    }


    public Cursor getFavourites(String favourites){                             // Retrieving favourites from DB

        SQLiteDatabase database = this.getWritableDatabase();

        return database.rawQuery("Select title from MovieDetails where favourites = ?",new String [] {favourites});
    }


    public Cursor getSingleMovieDetails(String movieName){                  // Retrieving details only for selected movie

        SQLiteDatabase database = this.getWritableDatabase();

        return database.rawQuery("Select * from MovieDetails where title = ?",new String [] {movieName});
    }


    public Cursor lookUpMovies(String userInput){                                   // Searching for a movie in DB

        SQLiteDatabase database = this.getWritableDatabase();

        return database.rawQuery("Select title from MovieDetails where title like ? OR director like ? OR actors like ?",new String [] {userInput,userInput,userInput});
    }


    public boolean databaseExist(Context context) {                                 // Checking the selected DB exists

        File dbFile = context.getDatabasePath("MovieData.db");
        return dbFile.exists();
    }


    public void insertFavourites(String title, String favourites){                  // Updating favourites

        SQLiteDatabase DB = this.getWritableDatabase();

        ContentValues contentValues = new ContentValues();

        contentValues.put("favourites", favourites);

        DB.update("MovieDetails", contentValues, "title=?", new String[]{title});
    }
}
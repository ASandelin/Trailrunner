package se.iths;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class Lap {
    private String id;
    private double distance_km;
    private LocalTime finish_time;
    private LocalDate date;

    // Konstruktor
    public Lap(String id, double distance_km, LocalTime finish_time, LocalDate date) {
        this.id = id;
        this.distance_km = distance_km;
        this.finish_time = finish_time;
        this.date = date;
    }
    // Getters och setters
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public double getDistance_km() {
        return distance_km;
    }
    public void setDistance_km(double distance_km) {
        this.distance_km = distance_km;
    }
     public LocalTime getFinish_time () {
        return finish_time; 
    }
    public void setFinish_time(LocalTime finishTime) {
        this.finish_time = finishTime;
    }
    public LocalDate getDate() {
        return date;
    }
    public void setDate(LocalDate date) {
        this.date = date;
    }
    // Beräkna medelhastighet i km/h
    public double calculateAverageSpeed() {
        Duration duration = Duration.between(LocalTime.MIN, finish_time);
        double timeInSeconds = duration.toSeconds();
        return (distance_km / timeInSeconds) * 3600; // km/h
    }
    // Beräkna tempo (tid per kilometer) i minuter
    public double calculatePace() {
        Duration duration = Duration.between(LocalTime.MIN, finish_time);
        double timeInSeconds = duration.toSeconds();
        return (timeInSeconds / distance_km) / 60; // min/km
    }
     @Override
    public String toString() {
        return "Run ID: " + id + "\n" +
               "Distance: " + distance_km + " km\n" +
               "Time: " + finish_time.format(DateTimeFormatter.ofPattern("HH:mm:ss")) + "\n" +
               "Date: " + date + "\n" +
               "Average Speed: " + calculateAverageSpeed() + " km/h\n" +
               "Pace: " + calculatePace() + " min/km";
    } 
} 



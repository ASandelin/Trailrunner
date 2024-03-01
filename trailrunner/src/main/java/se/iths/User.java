package se.iths;

import java.util.HashMap;
import java.util.Map;


public class User {
    private double length_cm;
    private double weight_kg;
    private Map<String, Lap> runList; // För att spara löprundorna

    // Konstruktor
    public User(double length_cm, double weight_kg) {
        this.length_cm = length_cm;
        this.weight_kg = weight_kg;
        this.runList = new HashMap<>();
    }
    // Getters och setters
    public double getLength() {
        return length_cm;
    }    
    public void setLength(double length) {
        this.length_cm = length;
    }
    public void setWeight(double weight) {
        this.weight_kg = weight;
    }
    public double getWeight() {
        return weight_kg;
    }
    public void setRunList(Map<String, Lap> runList) {
        this.runList = runList;
    }
    public Map<String, Lap> getRunList() {
        return runList;
    }    
    public Lap getRun(String id) {
        return runList.get(id);
    }
    // Beräkna BMI
    public double calculateBMI() {
        double height_m = length_cm / 100; // konvertera längd till meter
        return weight_kg / (height_m * height_m);
    }
    // Total distans av löprundorna
    public double totalDistance() {
        double total = 0.0;
        for (Lap run : runList.values()) {
            total += run.getDistance_km();
        }
        return total;
    }
    // Genomsnittlig distans av löprundorna
    public double averageDistance() {
        if (runList.isEmpty()) {
            return 0.0;
        }
        return totalDistance() / runList.size();
    }
    // Skriva ut detaljer om en Lap
    public void printRunDetails(String id) {
        if (runList.containsKey(id)) {
            Lap run = runList.get(id);
            System.out.println("Run ID: " + run.getId());
            System.out.println("Distance: " + run.getDistance_km() + " km");
            System.out.println("Time: " + run.getFinish_time () );
            System.out.println("Date: " + run.getDate());
            System.out.println("Average Speed: " + run.calculateAverageSpeed() + " km/h");
            System.out.println("Pace: " + run.calculatePace() + " min/km");
        } else {
            System.out.println("Run with ID " + id + " not found.");
        }
    }
    // Ta bort en Lap
    public void deleteRun(String id) {
        if (runList.containsKey(id)) {
            runList.remove(id);
            System.out.println("Run with ID " + id + " deleted.");
        } else {
            System.out.println("Run with ID " + id + " not found.");
        }
    }
    // Sparar en Lap
    public void saveRun(Lap run) {
        runList.put(run.getId(), run);
        System.out.println("Run with ID " + run.getId() + " saved.");
    }


}  

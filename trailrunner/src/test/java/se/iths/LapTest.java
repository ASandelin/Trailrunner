package se.iths;

import org.junit.jupiter.api.Test;
import java.time.LocalDate;
import java.time.LocalTime;

import static org.junit.jupiter.api.Assertions.*;

public class LapTest {

    @Test
    public void testGettersAndSetters() {
        // Skapar en löprunda med tilldelade värden
        LocalTime finishTime = LocalTime.of(0, 30, 0);
        double distanceKm = 10.0;
        LocalDate date = LocalDate.of(2023, 12, 15);
        Lap lap = new Lap("1", distanceKm, finishTime, date);

        // Testar getters
        assertEquals("1", lap.getId());
        assertEquals(distanceKm, lap.getDistance_km());
        assertEquals(finishTime, lap.getFinish_time());
        assertEquals(date, lap.getDate());

        // Testar setters
        lap.setId("2");
        lap.setDistance_km(15.0);
        lap.setFinish_time(LocalTime.of(0, 45, 0));
        lap.setDate(LocalDate.of(2023, 12, 20));

        assertEquals("2", lap.getId());
        assertEquals(15.0, lap.getDistance_km());
        assertEquals(LocalTime.of(0, 45, 0), lap.getFinish_time());
        assertEquals(LocalDate.of(2023, 12, 20), lap.getDate());
    }
    @Test
    public void testCalculateAverageSpeed() {
        // Skapar en löprunda med tilldelade värden
        LocalTime finishTime = LocalTime.of(0, 30, 0); // 30 minuter
        double distanceKm = 10.0; // 10 kilometers
        Lap lap = new Lap("1", distanceKm, finishTime, LocalDate.now());

        // Beräknar förväntad medelhastighet manuellt
        double expectedAverageSpeed = (distanceKm / 1800) * 3600; // km/h

        // Jämnför förväntad med faktiskt
        assertEquals(expectedAverageSpeed, lap.calculateAverageSpeed(), 0.01); // Delta used for double comparison
    }

    @Test
    public void testCalculatePace() {
        //Skapar en löprunda med tilldelade värden
        LocalTime finishTime = LocalTime.of(0, 30, 0); // 30 minutes
        double distanceKm = 10.0; // 10 kilometers
        Lap lap = new Lap("1", distanceKm, finishTime, LocalDate.now());

        // Beräknar förväntad tempo manuellt
        double expectedPace = (1800 / distanceKm) / 60; // min/km

        // Jämnför förväntad med faktiskt
        assertEquals(expectedPace, lap.calculatePace(), 0.01); // Delta used for double comparison
    }
    
}
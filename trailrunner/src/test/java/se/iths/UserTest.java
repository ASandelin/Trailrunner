package se.iths;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.Map;
import static org.junit.jupiter.api.Assertions.*;

class UserTest {

    private User user;

    @BeforeEach
    void setUp() {
        user = new User(175, 70); // + tom HashMap
    }

    @Test
    void testConstructor() {
        assertEquals(175, user.getLength());
        assertEquals(70, user.getWeight());
        assertTrue(user.getRunList().isEmpty());
    }

    @Test
    void testSetLength() {
        user.setLength(180);
        assertEquals(180, user.getLength());
    }

    @Test
    void testSetWeight() {
        user.setWeight(75);
        assertEquals(75, user.getWeight());
    }

    @Test
    void testCalculateBMI() {
        double expectedBMI = 22.86; // BMI calculated manually
        assertEquals(expectedBMI, user.calculateBMI(), 0.01); // Delta felmarginal vid double jämförelse
    }

    @Test
    void testTotalDistance() {
        Map<String, Lap> runList = new HashMap<>();
        runList.put("1", new Lap("1", 5.0, null, null));
        runList.put("2", new Lap("2", 8.0, null, null));
        user.setRunList(runList);

        double expectedTotalDistance = 13.0;
        assertEquals(expectedTotalDistance, user.totalDistance(), 0.01);
    }

    @Test
    void testAverageDistance() {
        Map<String, Lap> runList = new HashMap<>();
        runList.put("1", new Lap("1", 5.0, null, null));
        runList.put("2", new Lap("2", 8.0, null, null));
        user.setRunList(runList);

        double expectedAverageDistance = 6.5;
        assertEquals(expectedAverageDistance, user.averageDistance(), 0.01);
    }

    @Test
    void testPrintRunDetails() {
        Lap run = new Lap("1", 5.0, LocalTime.of(0, 30, 0), LocalDate.now());
        user.saveRun(run);

        assertDoesNotThrow(() -> user.printRunDetails("1")); // Ensure no exceptions are thrown
    }

    @Test
    void testDeleteRun() {
        Lap run = new Lap("1", 5.0, LocalTime.of(0, 30, 0), LocalDate.now());
        user.saveRun(run);
        user.deleteRun("1");

        assertNull(user.getRun("1"));
    }

    @Test
    void testSaveRun() {
        Lap run = new Lap("1", 5.0, LocalTime.of(0, 30, 0), LocalDate.now());
        //Lap run2 = new Lap("2", 10.0, LocalTime.of(0, 50, 0), LocalDate.now());
        user.saveRun(run);
        //user.saveRun(run2);
        
        assertEquals(run, user.getRun("1"));
    }

    @Test
    void testSaveRunWithExistingId() {
        Lap run1 = new Lap("1", 5.0, LocalTime.of(0, 30, 0), LocalDate.now());
        Lap run2 = new Lap("1", 8.0, LocalTime.of(1, 0, 0), LocalDate.now());
        user.saveRun(run1);
        user.saveRun(run2);

        assertEquals(1, user.getRunList().size()); // Försäkrar att endast en Lap är sparad
        assertEquals(run2, user.getRun("1")); // Försäkrar att den senaste run är skriver över den tidigare
    }


}

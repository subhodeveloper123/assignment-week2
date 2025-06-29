import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

public class CalculatorTest {

    private Calculator calculator;

    // Setup: Runs before each test
    @Before
    public void setUp() {
        calculator = new Calculator();  // Arrange
        System.out.println("Setup: Calculator initialized");
    }

    // Teardown: Runs after each test
    @After
    public void tearDown() {
        calculator = null;
        System.out.println("Teardown: Calculator cleared");
    }

    @Test
    public void testAddition() {
        // Act
        int result = calculator.add(2, 3);

        // Assert
        assertEquals(5, result);
    }

    @Test
    public void testSubtraction() {
        // Act
        int result = calculator.subtract(5, 2);

        // Assert
        assertEquals(3, result);
    }
}

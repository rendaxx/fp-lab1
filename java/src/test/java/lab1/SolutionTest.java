package lab1;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class SolutionTest {
    @Test
    void fibonacci_smallDigits() {
        assertEquals(1, Solution.fibonacciIndexWithDigits(1));
        assertEquals(7, Solution.fibonacciIndexWithDigits(2));
        assertEquals(12, Solution.fibonacciIndexWithDigits(3));
    }

    @Test
    void fibonacci_1000Digits() {
        assertEquals(4782, Solution.fibonacciIndexWithDigits(1000));
    }

    @Test
    void sumSquareDifference_examples() {
        assertEquals(2640L, Solution.sumSquareDifference(10));
        assertEquals(25164150L, Solution.sumSquareDifference(100));
    }
}


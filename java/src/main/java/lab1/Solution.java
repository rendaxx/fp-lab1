package lab1;

import java.math.BigInteger;

public final class Solution {
    private Solution() {}

    public static int fibonacciIndexWithDigits(int digits) {
        if (digits <= 1) return 1;
        BigInteger a = BigInteger.ONE; // F1
        BigInteger b = BigInteger.ONE; // F2
        int index = 2;
        while (digitsCount(b) < digits) {
            BigInteger next = a.add(b);
            a = b;
            b = next;
            index++;
        }
        return index;
    }

    private static int digitsCount(BigInteger n) {
        return n.toString().length();
    }

    public static long sumSquareDifference(int n) {
        long nn = n;
        long sum = nn * (nn + 1) / 2;
        long sumOfSquares = nn * (nn + 1) * (2 * nn + 1) / 6;
        return sum * sum - sumOfSquares;
    }
}


package oata.math;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Adder {
    public static final Logger logger = LoggerFactory.getLogger(Adder.class);

    public static int add(int a, int b) {
        logger.trace("Adding {} and {}", a, b);
        return a + b;
    }
}

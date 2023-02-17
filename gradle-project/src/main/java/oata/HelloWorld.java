package oata;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import oata.math.Adder;

public class HelloWorld {
    private static final Logger logger = LoggerFactory.getLogger(HelloWorld.class);

    public static void main(String[] args) {
        System.out.println(">>> Hello World " + Adder.add(1, 1));
        
        // log stuff
        logger.error("Hello World, I'm an error message");
        logger.warn("Hello World, I'm a warning message");
        logger.info("Hello World, I'm an info message");
        logger.debug("Hello World, I'm a debug message");
        logger.trace("Hello World, I'm a trace message");
    }
}

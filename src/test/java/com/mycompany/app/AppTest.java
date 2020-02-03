package com.mycompany.app;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import org.junit.Before;
import org.junit.Test;
import org.junit.After;
import static org.junit.Assert.*;

public class AppTest
{

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @Test
    public void testAppConstructor() {
        try {
            new App();
        } catch (Exception e) {
            fail("Construction failed.");
        }
    }

    @Test
    public void testAppMain()
    {
        App.main(null);
        try {
            assertEquals("A Simple Java Application - My first step to intuit !" + System.getProperty("line.separator"), outContent.toString());
        } catch (AssertionError e) {
            fail("\"message\" is not \"A Simple Java Application - My first step to intuit !\"");
        }
    }

    @Test
    public void testForNumeral()
    {
        App.main(null);
        try {
            String str=outContent.toString();
            // assertTrue(str.matches(".*\\d.*"));
            assertFalse(str.matches(".*\\d.*"));
        } catch (AssertionError e) {
            fail("There are no numeric digits in the output ! ");
        }
    }

    @After
    public void cleanUpStreams() {
        System.setOut(null);
    }

}

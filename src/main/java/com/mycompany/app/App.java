package com.mycompany.app;

public class App
{

    private final String message = "A Simple Java Application - My first step to intuit !";

    public App() {}

    public static void main(String[] args) {
        System.out.println(new App().getMessage());
    }

    private final String getMessage() {
        return message;
    }

}

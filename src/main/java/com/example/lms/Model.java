package com.example.lms;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Model {
    private final Car c;
    @Autowired
    public Model (Car c){


    //Spring Injects The  Engine Bean here

    this.c=c;


    }
    // public String drive(){
    //     return c.startCar();//calling the car method
    // }
     public String drive(){
        return c.startCar()
        + " | Car Model: " + c.getModel() + 
        " | Car Color: " + c.getColor() + 
        " | Car Stopped: " + c.stopCar() ;//calling the car & color method
    }
    
}

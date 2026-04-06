package com.example.lms.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Car {
    private String color ="White";
    private final Engine engine;
    private String model="Fortuner";

    @Autowired
    public Car(Engine engine){
        //Spring Injects the Engine bean here
        this.engine=engine;
    }

    public String startCar(){
        return engine.start();//calling Engine method
    }
    public String getModel(){
        return model;//returning the model of the car
    }

    public String getColor(){
        return color;
    }
    public String stopCar(){
        return engine.stop();//calling Engine method
    }
}

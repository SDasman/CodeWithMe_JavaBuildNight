package com.codewithme.javabuildnight;

import java.io.Serializable;

public class Choice implements Serializable {
    
    public enum Animal{Dog, Cat};
    private String username;
    private Animal chosenAnimal;

    public Choice(String username, Animal chosenAnimal) {
        this.username = username;
        this.chosenAnimal = chosenAnimal;
    }

    public String getUsername() {
        return username;
    }

    public Animal getChosenAnimal() {
        return chosenAnimal;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setChosenAnimal(Animal chosenAnimal) {
        this.chosenAnimal = chosenAnimal;
    }

}

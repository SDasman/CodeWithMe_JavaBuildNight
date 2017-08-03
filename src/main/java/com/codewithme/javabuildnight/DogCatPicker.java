package com.codewithme.javabuildnight;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DogCatPicker extends HttpServlet {

    private static final List<Choice> choices = new LinkedList<Choice>();

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("choices", choices);
        this.getServletContext().getRequestDispatcher("/dogcatpicker.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getParameter("username");
        String animal = (String) request.getParameter("choice");

        if (validInput(username) && validInput(animal)) {
            choices.add(new Choice(username, Choice.Animal.valueOf(animal)));
        }

        request.setAttribute("choices", choices);
        this.getServletContext().getRequestDispatcher("/dogcatpicker.jsp").forward(request, response);
    }

    private boolean validInput(String input) {
        return Objects.nonNull(input) && input.isEmpty() == false;
    }

}

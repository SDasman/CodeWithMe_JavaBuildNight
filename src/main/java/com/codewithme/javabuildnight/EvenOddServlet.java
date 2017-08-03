package com.codewithme.javabuildnight;

import java.io.IOException;
import java.util.Objects;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EvenOddServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.getServletContext().getRequestDispatcher("/evenodd.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parameter = request.getParameter("number");
        try {
            Long number = Long.valueOf(parameter);
            request.setAttribute("number", number);
            
            if (isEven(number)) {
                request.setAttribute("evenodd", "even");
            } else {
                request.setAttribute("evenodd", "odd");
            }
            
            
        } catch (Exception ex) {
            request.setAttribute("evenodd", null);
            request.setAttribute("msg", "Wait just a minute....You tried to trick me!!!");
        }
        
        this.getServletContext().getRequestDispatcher("/evenodd.jsp").forward(request, response);
    }
    
    private boolean isEven(Long number) throws Exception {
        if (Objects.isNull(number)) {
            throw new Exception("Null value provided");
        }
        
        return (number % 2) == 0;
    }

}

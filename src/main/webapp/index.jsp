<%@page import="java.util.Objects"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Even/Odd JSP Page</title>
    </head>
    <body>
        <h1>Give me a number and I will rack my brain, crunch some numbers, ask the gods and tell you if it's even or odd</h1>
        <form method="post" action="/evenodd"> 
            Please enter a number <br> 
            <input type="text" name="number" size="5">
            <input type="submit" value="submit"> 
        </form> 
    </body>
    <%
        Long number = (Long) request.getAttribute("number");
        String evenOdd = (String) request.getAttribute("evenodd");
        String msg = (String) request.getAttribute("msg");

        if (Objects.nonNull(evenOdd)) {
            out.println(number + " is... " + evenOdd);
        }

        if (Objects.nonNull(msg)) {
            out.println(msg);
        }
    %>
</html>

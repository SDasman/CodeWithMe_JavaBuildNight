<%@page import="java.util.ListIterator"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.codewithme.javabuildnight.Choice"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Objects"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div>
            <h1>Form Submission</h1>
            <form method="post" action="dogcatpicker"> 
                Username
                <input type="text" name="username" size="25"/><br>
                Dog or Cat
                <select name="choice">
                    <option>Dog</option>
                    <option>Cat</option>
                </select>
                <input type="submit" value="submit">
            </form>
        </div>
    </body>
    <%
        out.println();
        out.println("Here are the totals and latest activity");
        List<Choice> choices = (List) request.getAttribute("choices");
        if (Objects.nonNull(choices) && choices.isEmpty() == false) {
            for (int i = choices.size() - 1; i >= 0; i--) {
                Choice choice = choices.get(i);
                out.println("<br>" + choice.getUsername() + " picked " + choice.getChosenAnimal());
            }
        }
    %>
</html>

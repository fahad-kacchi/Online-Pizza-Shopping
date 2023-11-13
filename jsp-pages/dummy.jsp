<%@ page language="java" import="java.sql.*"%>
<%@include file="common-database.jsp" %>

<%
    String pizzaNo[] = request.getParameterValues("pizzaNo");
    String smallPizzaCheckBoxes[] = request.getParameterValues("smallCheckBoxPrice");
    String mediumPizzaCheckBoxes[] = request.getParameterValues("mediumCheckBoxPrice");
    String largePizzaCheckBoxes[] = request.getParameterValues("largeCheckBoxPrice");

    boolean flag[] = new boolean[4];
    if(pizzaNo != null){
        for(String pno : pizzaNo){
            out.println("<br>pno: " +pno);
        }
    } else {
        flag[0] = true;
    }
    
    if(smallPizzaCheckBoxes != null){
        for(String smallCheck : smallPizzaCheckBoxes){
            out.println("<br>smallCheck: " +smallCheck);
        }
    } else {
        flag[1] = true;
    }

    if(mediumPizzaCheckBoxes != null){
        for(String mediumCheck : mediumPizzaCheckBoxes){
            out.println("<br>mediumCheck: " +mediumCheck);
        }
    } else {
        flag[2] = true;
    }

    if(largePizzaCheckBoxes != null){
        for(String largeCheck : largePizzaCheckBoxes){
            out.println("<br>largeCheck: " +largeCheck);
        }
    } else {
        flag[3] = true;
    }
    
    if(flag[0] && flag[1] && flag[2] && flag[3]){
        response.sendRedirect("../pizza.html");
    }
    out.println(" I am here");
%>
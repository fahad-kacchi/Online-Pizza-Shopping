<%@ page language="java" import="java.sql.*"%>
<%@include file="common-database.jsp" %>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");
    String message = "";
    
    try{
        con = fetchConnection();
        stmt = con.createStatement();
        String query = "insert into admin values('"+name+"', '"+email+"', '"+password+"', '"+confirmPassword+"')";
        stmt.executeUpdate(query);
        message = "<center>"+
                        "<font size=5 color=green>"+ 
                            "<b> Record successfully inserted. </b>"+
                            "<a href=\"../admin-login.html\"> click here to go back.</a>"+
                        "</font>"+
                  "</center>";
        out.println(message);
    } catch(Exception e){
        message = "<center>"+
                        "<font size=5 color=red>"+ 
                            "<b> There is an error occurred during insertion. </b>"+
                        "</font>"+
                  "</center>";
        out.println(message);
        out.println(" Exception: " +e);
    } finally {
        closeConnection();
    }
%>
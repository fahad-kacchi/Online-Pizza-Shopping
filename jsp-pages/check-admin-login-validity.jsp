<%@ page language="java" import="java.sql.*"%>
<%@include file="common-database.jsp" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    try{
        con = fetchConnection();
        stmt = con.createStatement();
        String query = "select * from admin where email = '"+email+"' and password = '"+password+"'";
        rs = stmt.executeQuery(query);
        if(!rs.next()){
            out.println(" Invalid login");
        } else {
            response.sendRedirect("../add-new-pizza-details.html");
        }
    } catch(Exception e){
        out.println(" Exception: " +e);
    } finally {
        closeConnection();
    }
%>
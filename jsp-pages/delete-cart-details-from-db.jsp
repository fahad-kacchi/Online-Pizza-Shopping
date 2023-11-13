<%@ page language="java" import="java.sql.*"%>
<%@include file="common-database.jsp" %>

<%
    String pizzaNo = request.getParameter("pizzaNo");
    
    try{
        boolean flag = deleteFromCart(pizzaNo, out);
        if(flag){
            response.sendRedirect("../add-to-cart.html");
        } else {
            out.println(" <center> <font color=red> <b> There is an error occurred. </b> </font> </center>");
        }
    } catch(Exception e){
        out.println(" Exception: " +e);
    }
%>

<%!
    public static boolean deleteFromCart(String pizzaNo, JspWriter out) throws Exception{
        boolean deleteFlag = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String deleteQuery = "delete from add_to_cart where pizza_no = '"+pizzaNo+"'";
            stmt.executeUpdate(deleteQuery);
            deleteFlag = true;
        } catch(Exception e){
            out.println(" Delete from cart exception: " +e);
        } finally {
            closeConnection();
        }
        return deleteFlag;
    }
%>
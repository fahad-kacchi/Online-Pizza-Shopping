<%@ page language="java" import="java.sql.*"%>
<%@include file="common-database.jsp" %>

<%
    String pizzaNo = request.getParameter("pizza_no");
    try{
        boolean insertFlag = storePizzaDetailsToCartTable(pizzaNo, out);
        if(insertFlag){
            response.sendRedirect("../pizza.html");
        } else {
            out.println(" There were error occurred during adding.");
        }
    } catch(Exception e){
        out.println(" Store pizza details: " +e);
    }
%>

<!-- This method is used to store the pizza details to cart -->
<%!
    public static boolean storePizzaDetailsToCartTable(String pizzaNo, JspWriter out) throws Exception{
        boolean flag = false;
        try{
            int currentCartNo = getCurrentCartNo(out);
            con = fetchConnection();
            stmt = con.createStatement();
            String newCartNo = "C"+(currentCartNo+1);
            
            String query = "insert into add_to_cart values('"+newCartNo+"', '"+pizzaNo+"')";
            stmt.executeUpdate(query);
            flag = true;
        } catch(Exception e){
            out.println(" Storing exception: " +e);
        } finally {
            closeConnection();
        }
        return flag;
    }
%>

<!-- This method is used to get current cart no. -->
<%!
    public static int getCurrentCartNo(JspWriter out) throws Exception{
        int pizzaNo = 0;
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select add_to_cart_no from add_to_cart";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                pizzaNo = 0;
            } else {
                rs.last();
                pizzaNo = Integer.parseInt(rs.getString("add_to_cart_no").split("C")[1]);
            }
        } catch(Exception e){
            out.println(" Get current cart no exception: " +e);
        } finally {
            closeConnection();
        }
        return pizzaNo;
    }
%>

<!--
Following is used to fetch data of pizza using pizza_no
// con = fetchConnection();
// stmt = con.createStatement();
// String query = "select * from pizza where pizza_no = '"+pizzaNo+"'";
// rs = stmt.executeQuery(query);
// rs.next();

// String pizzaName = rs.getString("pizza_name");
// int smallSizeStatus = rs.getInt("small_size_status");
// int mediumSizeStatus = rs.getInt("medium_size_status");
// int largeSizeStatus = rs.getInt("large_size_status");
// double smallSizePrice = rs.getDouble("small_price");
// double mediumSizePrice = rs.getDouble("medium_price");
// double largeSizePrice = rs.getDouble("large_price");

-->
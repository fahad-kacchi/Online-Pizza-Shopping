<%@ page language="java" import="java.sql.*"%>
<%@include file="common-database.jsp" %>

<%
    String pizzaName = request.getParameter("pizza-name");
    float smallPizzaAmount = Float.parseFloat(request.getParameter("small-price"));
    float mediumPizzaAmount = Float.parseFloat(request.getParameter("medium-price"));
    float largePizzaAmount = Float.parseFloat(request.getParameter("large-price"));
    String vegNonVegStatus = request.getParameter("veg-non-veg-status");
    
    int smallSizeStatus = 1;
    int mediumSizeStatus = 2;
    int largeSizeStatus = 3;
    
    int intVegNonVegStatus = 0;
    
    if(vegNonVegStatus != null){
        intVegNonVegStatus = Integer.parseInt(vegNonVegStatus);
    }
    
    try{
        String latestPizzaNo = getLatestPizzaNo(out);
        String[] getNo = latestPizzaNo.split("P");
        int newPizzaNo = Integer.parseInt(getNo[1]) + 1;
        boolean flag = storeNewPizzaDetails("P"+newPizzaNo, pizzaName, smallSizeStatus, mediumSizeStatus, largeSizeStatus, smallPizzaAmount, mediumPizzaAmount, largePizzaAmount, intVegNonVegStatus, out);
        if(flag){
            response.sendRedirect("../add-new-pizza-details.html");
        }
    } catch(Exception e){
        out.println(" Get latest pizza no exception: " +e);
    }
%>

<%!
    public static boolean storeNewPizzaDetails(String pizzaNo, String pizzaName, int smallStatus, int mediumStatus, int largeStatus, float smallPrice, float mediumPrice, float largePrice, int vegNonVegStatus, JspWriter out) throws Exception{
        boolean flag = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "insert into pizza values('"+pizzaNo+"','"+pizzaName+"','"+smallStatus+"','"+mediumStatus+"','"+largeStatus+"','"+smallPrice+"','"+mediumPrice+"','"+largePrice+"','"+vegNonVegStatus+"')";
            stmt.executeUpdate(query);
            flag = true;
        } catch(Exception e){
            out.println(" Storing pizza details exception: " +e);
            flag = false;
        } finally {
            closeConnection();
        }
        return flag;
    }
%>

<%!
    public static String getLatestPizzaNo(JspWriter out) throws Exception{
        String latestPizzaNo = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select * from pizza";
            rs = stmt.executeQuery(query);

            if(rs.next()){
                rs.last();
                String pizzaNo = rs.getString("pizza_no");
                if(pizzaNo == null){
                    latestPizzaNo = "P0";
                } else {
                    latestPizzaNo = pizzaNo;
                }
            }
        } catch(Exception e){
            out.println(" Latest Pizza No Exception: " +e);
        } finally {
            closeConnection();
        }
        return latestPizzaNo;
    }
%>
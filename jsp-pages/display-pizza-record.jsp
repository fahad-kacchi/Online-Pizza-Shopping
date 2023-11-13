<%@ page language="java" import="java.sql.*"%>
<%@include file="common-database.jsp" %>

<%
    displayPizzaRecord(out);
%>

<%!
    public static void displayPizzaRecord(JspWriter out) throws Exception{
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select * from pizza";
            rs = stmt.executeQuery(query);

            String tableHeading = ""+
                                    "<tr>"+
                                        "<th>Sr. No.</th>"+
                                        "<th>Select</th>"+
                                        "<th>Pizza Name</th>"+
                                        "<th>Small&nbsp;&nbsp;</th>"+
                                        "<th>Medium</th>"+
                                        "<th>Large&nbsp;</th>"+
                                        "<th>Veg/Non-Veg</th>"+
                                        "<th>Add to Cart</th>"+
                                    "</tr>";
            out.println(tableHeading);
            
            if(!rs.next()){
                out.println(" There are no records are present.!! ");
            } else {
                int i = 0;
                rs.previous();
                while(rs.next()){
                    String pizzaNo = rs.getString("pizza_no");
                    String pizzaName = rs.getString("pizza_name");
                    String smallPrice = rs.getString("small_price");
                    String mediumPrice = rs.getString("medium_price");
                    int vegNonVegStatus = rs.getInt("veg_non_veg_status");
                    String largePrice = rs.getString("large_price");
                    
                    String vegOrNonVeg = "";
                    if(vegNonVegStatus == 0){
                        vegOrNonVeg = "Veg";
                    } else {
                        vegOrNonVeg = "Non-Veg";
                    }
                    String data = "";
                    data = "jsp-pages/store-cart-details.jsp?pizza_no="+rs.getString("pizza_no");
                    
                    String printPizzaDetails = "<tr>"+
                                                    "<td>"+(++i)+"</td>"+
                                                    "<td><input name=\"pizzaNo\" value="+pizzaNo+" type=\"checkbox\"></input></td>"+
                                                    "<td><hidden name=\"pizzaName\" value="+pizzaName+"></hidden>"+pizzaName+"</td>"+
                                                    "<td><span class=\"label label-warning\">&#8377;"+smallPrice+"</span></td>"+
                                                    "<td><span class=\"label label-info\">&#8377;"+mediumPrice+"</span></td>"+
                                                    "<td><span class=\"label label-danger\">&#8377;"+largePrice+"</span></td>"+
                                                    "<td>"+vegOrNonVeg+"</td>"+
                                                    "<td> <span class=\"glyphicon glyphicon-shopping-cart\"></span> <font color=red> <a href="+data+"> <b> Add </b> </a> </font> </td>"+
                                               "</tr>";
                    out.print(printPizzaDetails);
                }
            }
        } catch(Exception e){
            out.println(" Display pizza record exception: " +e);
        } finally {
            closeConnection();
        }
    }
%>
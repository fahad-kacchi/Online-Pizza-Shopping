

<%@ page language="java" import="java.sql.*, java.util.*" %>
<%@include file="jsp-pages/common-database.jsp" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Pizza | Online Pizza Order</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
		<script src="bootstrap/jquery/jquery-3.3.1.js"></script>
		<script src="bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="bootstrap/w3.css/w3.css">
	</head>
	<body>
        <%
            String orderDetails[] = null;
            try{
                orderDetails = getLatestOrderDetails(out);
            } catch(Exception e){
                out.println(" Order Exception: " +e);
            }
        %>
		<div class="container">
            <div class="jumbotron">
                <div class="row">
                    <div class="col-xs-12 text-center">
                        <h3><b>INVOICE</b></h3>
                        <h3><small>Pizza Bill</small></h3>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-xs-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h5> <b> From: </b> <%=orderDetails[0]%></h5>
                            </div>
                            <div class="panel-body">
                                <p>
                                    <b> <h5> Address: </b> <%=orderDetails[1]%> <br>
                                    <b> <h5> City: </b> <%=orderDetails[2]%> <br>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- / end client details section -->
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>
                                    <h4>Sr. No.</h4>
                                </th>
                                <th>
                                    <h4>Pizza Name</h4>
                                </th>
                                <th>
                                    <h4>Small Pizza Total</h4>
                                </th>
                                <th>
                                    <h4>Small Pizza Rate</h4>
                                </th>
                                <th>
                                    <h4>Medium Pizza Total</h4>
                                </th>
                                <th>
                                    <h4>Medium Pizza Rate</h4>
                                </th>
                                <th>
                                    <h4>Large Pizza Total</h4>
                                </th>
                                <th>
                                    <h4>Large Pizza Rate</h4>
                                </th>
                                <th>
                                    <h4>Total</h4>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            
                        <%
                            String pizzaDetails[] = null;
                            float finalTotal = 0.0f;
                            try{
                                String pizzaNo[] = orderDetails[9].split("/");
                                String smallPizzaTotalPrice[] = orderDetails[4].split(",");
                                String mediumPizzaTotalPrice[] = orderDetails[5].split(",");
                                String largePizzaTotalPrice[] = orderDetails[6].split(",");

                                for(int i = 0; i < pizzaNo.length; ++i){
                                    pizzaDetails = getPizzaDetails(pizzaNo[i], out);
                                    
                                    float totalPrice = Float.parseFloat(smallPizzaTotalPrice[i]) + Float.parseFloat(mediumPizzaTotalPrice[i]) + Float.parseFloat(largePizzaTotalPrice[i]);
                                    finalTotal += totalPrice;
                                    %>
                                        <tr>
                                            <td> <%=(i+1)%> </td>
                                            <td> <%=pizzaDetails[0]%></td>
                                            <td> <%=smallPizzaTotalPrice[i]%> </td>
                                            <td> <%=pizzaDetails[1]%> </td>
                                            <td> <%=mediumPizzaTotalPrice[i]%> </td>
                                            <td> <%=pizzaDetails[2]%> </td>
                                            <td> <%=largePizzaTotalPrice[i]%> </td>
                                            <td> <%=pizzaDetails[3]%> </td>
                                            <td> <%=totalPrice%> </td>
                                        </tr>
                                    <%
                                }
                            } catch(Exception e){
                                out.println(" Table Exception: " +e);
                            }
                        %>
                        </tbody>
                    </table>
                </div>
                <table align="right">
                    <tr>
                        <td> <b> Final Total Amount: </b> </td>
                        <td> &nbsp;&nbsp;&nbsp;&nbsp;<%=finalTotal%></td>
                    </tr>
                </table>
                <br><br>
				<a type="submit" class="btn btn-success" href="index.html">Logout</a>
            </div>
		</div>
	</body>
</html>

<%!
    public static String[] getLatestOrderDetails(JspWriter out) throws Exception{
        String orderDetails[] = new String[10];
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select * from order_now";
            rs = stmt.executeQuery(query);
            rs.last();
            orderDetails[0] = rs.getString("full_name");
            orderDetails[1] = rs.getString("address");
            orderDetails[2] = rs.getString("city");
            orderDetails[3] = rs.getString("contact_no");
            orderDetails[4] = rs.getString("small_pizza_final_price");
            orderDetails[5] = rs.getString("medium_pizza_final_price");
            orderDetails[6] = rs.getString("large_pizza_final_price");
            orderDetails[7] = rs.getString("price");
            orderDetails[8] = rs.getString("payment_mode");
            orderDetails[9] = rs.getString("pizza_no");
        } catch(Exception e){
            out.println(" Latest Order Pizza Details: " +e);
        } finally {
            closeConnection();
        }
        return orderDetails;
    }
%>

<%!
    public static String[] getPizzaDetails(String pizzaNo, JspWriter out) throws Exception{
        String pizzaDetails[] = new String[5];
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            rs = stmt.executeQuery("select * from pizza where pizza_no = '"+pizzaNo+"'");
            rs.next();
            pizzaDetails[0] = rs.getString("pizza_name");
            pizzaDetails[1] = rs.getString("small_price");
            pizzaDetails[2] = rs.getString("medium_price");
            pizzaDetails[3] = rs.getString("large_price");
            pizzaDetails[4] = rs.getString("veg_non_veg_status");
        } catch(Exception e){
            out.println(" Order Now Exception: " +e);
        } finally {
            closeConnection();
        }
        return pizzaDetails;
    }
%>
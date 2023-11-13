<%@ page language="java" import="java.util.*"%>
<%@include file="jsp-pages/common-database.jsp" %>
<%@include file="jsp-pages/pizza-quantity-pojo-class.jsp"%>


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
        <link rel="stylesheet" href="bootstrap/font-awesome/font-awesome.min.css">
        <script src="scripts/custom-js/validations.js"></script>
        <script src="scripts/custom-js/pizza-name-quantity.js"></script>
        
        <style>
            img {
                margin-bottom: -8px;
            }
            .mySlides {
                display: none;
            }
            
            <!-- This is used for date-picker -->
            [type="date"] {
              background:#fff url(https://cdn1.iconfinder.com/data/icons/cc_mono_icon_set/blacks/16x16/calendar_2.png)  97% 50% no-repeat ;
            }
            [type="date"]::-webkit-inner-spin-button {
              display: none;
            }
            [type="date"]::-webkit-calendar-picker-indicator {
              opacity: 0;
            }

            /* custom styles */
            label {
              display: block;
            }
            .datepicker {
              border: 1px solid #c4c4c4;
              border-radius: 5px;
              background-color: #fff;
              padding: 3px 5px;
              box-shadow: inset 0 3px 6px rgba(0,0,0,0.1);
              width: 190px;
            }
            <!-- Date-picker -->
            
        </style>
    </head>
    
    <body>
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>                        
                    </button>
                    <a class="navbar-brand" href="index.html">Logo</a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <li><a href="index.html">Home</a></li>
                        <li><a href="pizza.html">Pizza</a></li>
                        <li class="active"><a href="order-now-page.html">Order Now</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="admin-login.html"><span class="glyphicon glyphicon-user"></span> Admin-Login</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        
        <div class="container">
            <div class="w3-container w3-deep-orange">
                <div class="row">
                    <br>
                    <div class="col-md-3">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <img class="img-responsive" src="images/pizza-images/pizza.jpg" class="img-rounded" id="Panel_Image">
                            </div>
                        </div>
                    </div>    
                    
                    <font color="black">
                    <div class="col-md-9">                
                        <div class="panel panel-primary">
                            <div class="panel-heading"><center> Order Now </center> </div>
                            <div class="panel-body">
                                <form accept-charset="UTF-8" name="myForm" action="jsp-pages/store-order-now-details.jsp" method="post">
                                    <br>
                                    <div class="input-group">
                                        <span class="input-group-addon">Full name:</span>
                                        <input type="text" class="form-control" name="name" id="name" placeholder="First Middle Last" onchange="nameValidation()" required>
                                    </div>

                                    <br>
                                    <div class="input-group">
                                        <span class="input-group-addon">Address:</span>
                                        <textarea id="address" placeholder="Address with pincode" type="text" class="form-control" name="address" onchange="addressValidation()" required></textarea>
                                    </div>
                                    
                                    <br>
                                    <div class="input-group">
                                        <span class="input-group-addon">City:</span>
                                        <input id="city" type="text" class="form-control" name="city" placeholder="City" onchange="cityValidation()" required>
                                    </div>

                                    <br>
                                    <div class="input-group">
                                        <span class="input-group-addon">Contact No:</span>
                                        <input id="contact_no" type="number" class="form-control" name="contact_no" placeholder="Contact No" onchange="contactNoValidation()" required>
                                    </div>

                                    <br>
                                    <div class="input-group">
                                        <span class="input-group-addon">Pizza Size</span>
                                    </div>
                                    
                                    
                                    <div class="table-responsive">
                                        <table class="table table-hover" id="table-div">
                                            <tr>
                                                <thead>
                                                    <th>Pizza Name</th>
                                                    <th>Small Quantity</th>
                                                    <th>Medium Quantity</th>
                                                    <th>Large Quantity</th>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        String pizzaNo[] = request.getParameterValues("pizzaNo");
                                                        try{
                                                            if(pizzaNo != null){
                                                                for(String pno : pizzaNo){
                                                                    String pizzaName = getPizzaNameByNo(pno, out);
                                                                    String smallPizzaId = "Small-"+pno;
                                                                    String mediumPizzaId = "Medium-"+pno;
                                                                    String largePizzaId = "Large-"+pno;
                                                                    %>
                                                                        <tr>
                                                                            <td><%=pizzaName%></td>
                                                                            <input type="hidden" id="pizzaNo" name="pizzaNo[]" value="<%=pno%>"></input>
                                                                            <input type="hidden" id="pizzaName" name="pizzaName[]" value="<%=pizzaName%>"></input>
                                                                            <td><input type="numbers" name="smallPizzaQuantity[]"  id="smallPizzaQuantity"  required> </input></td>
                                                                            <td><input type="numbers" name="mediumPizzaQuantity[]" id="mediumPizzaQuantity"  required> </input></td>
                                                                            <td><input type="numbers" name="largePizzaQuantity[]"  id="largePizzaQuantity"  required> </input></td>
                                                                        </tr>
                                                                    <%
                                                                }
                                                            }
                                                        } catch(Exception e){
                                                            out.println(" Exception: " +e);
                                                        }
                                                    %>

                                                </tbody>
                                            </tr>
                                        </table>
                                        <button type="button" onclick="getValuesOfInputText()" class="btn btn-info btn-block" id="save-button">Save</button>
                                    </div>
                                    
                                    <br>
                                    <div class="input-group">
                                        <span class="input-group-addon">Payment Mode</span>
                                    </div>
                                    <br>
                                    <div class="input-group">
                                        <label class="radio-inline">
                                            <input type="radio" name="payment-mode" value="credit-card" id="credit-card" required>Credit/Debit Card
                                        </label>
                                    </div>

                                    <div class="input-group">
                                        <label class="radio-inline">
                                            <input type="radio" name="payment-mode" value="cash-on-delivery" id="cash-on-delivery" required>Cash on Delivery
                                        </label>
                                    </div>

                                    
                                    <br>
                                    <button type="submit" id="submit_button" class="btn btn-primary btn-block" disabled>Order Now</button>                                 
                                </form>
                            </div>
                        </div>
                    </div>
                    </font>
                </div>
            </div>
        </div>
        <br>
    </body>
</html>


<%!
    public static List<PizzaDetails> pizzaDetailsList = new ArrayList<PizzaDetails>();
%>

<%!
    /*
    public static void setPizzaDetails(String pno, String pizzaName, HttpServletRequest request, PizzaDetails pizzaDetails){
        try{
            int smQuantity = Integer.parseInt(request.getParameter("smallPizzaQuantity"));
            int mdQuantity = Integer.parseInt(request.getParameter("mediumPizzaQuantity"));
            int lgQuantity = Integer.parseInt(request.getParameter("largePizzaQuantity"));
            
            //pizzaDetails = new PizzaDetails();
            pizzaDetails.setPizzaNo(pno);
            pizzaDetails.setPizzaName(pizzaName);
            pizzaDetails.setSmallPizzaQuantity(smQuantity);
            pizzaDetails.setMediumPizzaQuantity(mdQuantity);
            pizzaDetails.setLargePizzaQuantity(lgQuantity);
            pizzaDetailsList.add(pizzaDetails);
        } catch(Exception e){
            e.printStackTrace();
        }
    }
    */
%>

<%!
    /*
    public static void printList(JspWriter out){
        try{
            for(PizzaDetails pd : pizzaDetailsList){
                out.println(" => " +pd.getPizzaNo());
                out.println(" =>" +pd.getSmallPizzaQuantity());
                out.println(" =>" +pd.getMediumPizzaQuantity());
                out.println(" =>" +pd.getLargePizzaQuantity());
            }
        } catch(Exception e){
            e.printStackTrace();
        }
    }
    */
%>


<%!
    public static String getPizzaNameByNo(String pizzaNo, JspWriter out) throws Exception{
        String pizzaName = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select pizza_name from pizza where pizza_no = '"+pizzaNo+"'";
            rs = stmt.executeQuery(query);
            rs.next();
            pizzaName = rs.getString("pizza_name");
        } catch(Exception e){
            out.println(" Pizza No Exception: " +e);
        } finally {
            closeConnection();
        }
        return pizzaName;
    }
%>

<script>
    function getValuesOfInputText(){

        var pizzaNo = document.getElementsByName("pizzaNo[]");
        var pizzaName = document.getElementsByName("pizzaName[]");
        var smallQuantity = document.getElementsByName("smallPizzaQuantity[]");
        var mediumQuantity = document.getElementsByName("mediumPizzaQuantity[]");
        var largeQuantity = document.getElementsByName("largePizzaQuantity[]");
        
        var data = "";
        for (var i = 0; i <smallQuantity.length; i++) {
            var pno = pizzaNo[i];
            var pname = pizzaName[i];
            var smallQ = smallQuantity[i];
            var mediumQ = mediumQuantity[i];
            var largeQ = largeQuantity[i];

            data += pno.value+","+pname.value+","+smallQ.value+","+mediumQ.value+","+largeQ.value+"$";
        }
        
        xmlhttp = new XMLHttpRequest();
        xmlhttp.open("GET","/online-pizza-shopping/jsp-pages/store-pizza-details-to-session.jsp?data="+data,false);
        xmlhttp.send();
        output = xmlhttp.responseText;
        
        
        document.getElementById("submit_button").disabled = false;
        document.getElementById("save-button").disabled = true;
        
        //Following is used for debugging purpose dont uncomment it.
        //window.location = "jsp-pages/store-pizza-details-to-session.jsp?data="+data;
    }
</script>

<!--
<br>
<div class="input-group">
    <label class="checkbox-inline">
        <input type="checkbox" name="pizza-size" value="small" id="small" onclick="checkBoxChecked('small','small-div')">Small
    </label>
</div>

<br>
<hidden id="small-div" style="display:none">
    <div class="input-group">
        <span class="input-group-addon">Small Pizza Quantity:</span>
        <input type="number" id="small-size-quantity" class="form-control" name="small-size-quantity" placeholder="Enter quantity" onchange="quantityValidation('small-size-quantity')" />
    </div>
</hidden>
    
<br>
<div class="input-group">
    <label class="checkbox-inline">
        <input type="checkbox" name="pizza-size" value="medium" id="medium" onclick="checkBoxChecked('medium','medium-div')">Medium
    </label>
</div>

<br>
<hidden id="medium-div" style="display:none">
    <div class="input-group">
        <span class="input-group-addon">Medium Pizza Quantity:</span>
        <input id="medium-size-quantity" type="number" class="form-control" name="medium-size-quantity" placeholder="Enter quantity" onchange="quantityValidation('medium-size-quantity')">
    </div>
</hidden>

<br>
<div class="input-group">
    <label class="checkbox-inline">
        <input type="checkbox" name="pizza-size" value="large" id="large" onclick="checkBoxChecked('large','large-div')">Large
    </label>
</div>

<br>
<hidden id="large-div" style="display:none">
    <div class="input-group">
        <span class="input-group-addon">Large Pizza Quantity:</span>
        <input id="large-size-quantity" type="number" class="form-control" name="large-size-quantity" placeholder="Enter quantity" onchange="quantityValidation('large-size-quantity')">
    </div>
</hidden>
-->
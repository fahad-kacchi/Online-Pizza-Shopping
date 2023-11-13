<%@ page language="java" import="java.util.*"%>
<%@include file="jsp-pages/common-database.jsp" %>

<!--
    Code Art Solutions
    Project Name: online-pizza-shopping
-->

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <script src="jquery/jquery-3.3.1.js"> </script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="bootstrap/fonts/glyphicons-halflings-regular.ttf"></script>
        <script src="scripts/custom-js/payment-validation.js"></script>
        <link rel="stylesheet" href="bootstrap/w3.css/w3.css">
        
        <title>Pizza | Payment</title>
        <style>
            body { margin-top:20px; }
            .panel-title {display: inline;font-weight: bold;}
            .checkbox.pull-right { margin: 0; }
            .pl-ziro { padding-left: 0px; }        
        </style>
    </head>
    
    <body>
        <div class="container">
            <div class="jumbotron" style="background-color:#D4F26A">
                <div class="row">
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <img class="img-responsive" src="images/payment/payment.png" class="img-rounded" id="Panel_Image">
                            </div>
                        </div>
                    </div>    
                    
                    <div class="col-xs-12 col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    Payment Details
                                </h3>
                                <div class="checkbox pull-right">
                                    <label>
                                        <input type="checkbox" />
                                        Remember
                                    </label>
                                </div>
                            </div>
                            <div class="panel-body">
                                <form role="form" action="jsp-pages/store-payment-details.jsp" method="post">
                                    <div class="form-group">
                                        <label for="cardNumber">
                                            CARD NUMBER</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="Enter 16 digit card number"
                                                required autofocus onchange="cardNumberValidation()"/>
                                            <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-7 col-md-7">
                                            <div class="form-group">
                                                <label for="expityMonth">
                                                    ENTER EXPIRY DATE
                                                </label>
                                                <div class="col-xs-6 col-lg-6 pl-ziro">
                                                    <input type="text" class="form-control" id="expiryMonth" name="expiryMonth" placeholder="MM" onchange="checkExpiryMonth()" required />
                                                </div>
                                                <div class="col-xs-6 col-lg-6 pl-ziro">
                                                    <input type="text" class="form-control" id="expiryYear" name="expiryYear" placeholder="YY" onchange="checkExpiryYear()" required />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-5 col-md-5 pull-right">
                                            <div class="form-group">
                                                <label for="cvCode">
                                                    CV CODE</label>
                                                <input type="password" class="form-control" id="cvCode" name="cvCode" placeholder="CV" onchange="checkCVVNo()" required/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <ul class="nav nav-pills nav-stacked">
                                <li class="active">
                                    <a href="#">
                                        <span class="badge pull-right">
                                            <i class="fa fa-rupee"></i><%=getLatestOrderNoPrice(out)%>
                                        </span> 
                                        Final Payment Amount
                                    </a>
                                </li>
                            </ul>
                            <br/>
                            <button type="submit" class="btn btn-success btn-lg btn-block">Pay</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>


<%!
    public static float getLatestOrderNoPrice(JspWriter out) throws Exception{
        float price = 0.0f;
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select * from order_now";
            rs = stmt.executeQuery(query);
            rs.last();
            String str[] = rs.getString("price").split(",");
            for(int i = 0; i < str.length; ++i){
                price += Float.parseFloat(str[i]);
            }
        } catch(Exception e){
            out.println(" Exception: " +e);
        } finally {
            closeConnection();
        }
        return price;
    }
%>
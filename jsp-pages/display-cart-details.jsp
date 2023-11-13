<%@ page language="java" import="java.sql.*"%>
<%@include file="common-database.jsp" %>


<%
    try{
        displayCartDetailsInDivision(out);
    } catch(Exception e){
        out.println(" Display Cart Exception: " +e);
    }
%>

<%!
    static String RECORD_NOT_FOUND = "Records not found.";
%>

<%!
    public static void displayCartDetailsInDivision(JspWriter out) throws Exception{
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select * from pizza where pizza_no in(select pizza_no from add_to_cart);";
            rs = stmt.executeQuery(query);
            
            if(!rs.next()){
                out.println(RECORD_NOT_FOUND);
            } else {
                rs.previous();
                while(rs.next()){
                    String pizzaName = rs.getString("pizza_name");
                    double smallPizzaPrice = rs.getDouble("small_price");
                    double mediumPizzaPrice = rs.getDouble("medium_price");
                    double largePizzaPrice = rs.getDouble("large_price");
                    int vegOrNonVeg = rs.getInt("veg_non_veg_status");
                    String pizzaNo = rs.getString("pizza_no");
                    
                    String vegNonVeg = "";
                    if(vegOrNonVeg == 0){
                        vegNonVeg = "Veg";
                    } else {
                        vegNonVeg = "Non-Veg";
                    }
                    displayPizzaDetailsInDivision(pizzaNo, pizzaName, smallPizzaPrice, mediumPizzaPrice, largePizzaPrice, vegNonVeg, out);
                }
            }
        } catch(Exception e){
            out.println(" Database: Display cart exception: " +e);
        }
    }
%>


<%!
    public static void displayPizzaDetailsInDivision(String pizzaNo, String pizzaName, double smallPizzaPrice, double mediumPizzaPrice, double largePizzaPrice, String vegOrNonVeg, JspWriter out) throws Exception{
        try{
            String link = "jsp-pages/delete-cart-details-from-db.jsp?pizzaNo="+pizzaNo;
            String displayCart = ""+
                    "<div class=\"w3-half w3-section\">"+
                        "<ul class=\"w3-ul w3-card w3-hover-shadow\">"+
                            "<li class=\"w3-black w3-xlarge w3-padding-5\">"+pizzaName+"</li>"+
                            "<li class=\"w3-padding-8\"><b> &nbsp;&nbsp;&nbsp;Small: &nbsp; &#8377;"+smallPizzaPrice+"</b></li>"+
                            "<li class=\"w3-padding-8\"><b> Medium: &nbsp; &#8377;"+mediumPizzaPrice+"</b> </li>"+
                            "<li class=\"w3-padding-8\"><b> &nbsp;&nbsp;&nbsp;Large: &nbsp; &#8377;"+largePizzaPrice+"</b></li>"+
                            "<li class=\"w3-padding-8\">"+
                                "<h2 class=\"w3-opacity\">"+vegOrNonVeg+"</h2>"+
                            "</li>"+
                            "<hidden id=\"pno\" value="+pizzaNo+"></hidden>"+
                            "<li class=\"w3-light-grey w3-padding-10\">"+
                                "<b><span class=\"glyphicon glyphicon-trash\"></span>&nbsp;<a href="+link+"><font size=4>Remove</font></a></b>"+
                            "</li>"+
                        "</ul>"+
                    "</div>";
            out.println(displayCart);
        } catch(Exception e){
            out.println(" Show exception: " +e);
        }
    }
%>

<!--
    public static void displayPizzaDetailsInDivision(String pizzaNo, String pizzaName, double smallPizzaPrice, double mediumPizzaPrice, double largePizzaPrice, String vegOrNonVeg, JspWriter out) throws Exception{
        try{
            String displayCart = ""+
                    "<div class=\"w3-half w3-section\">"+
                        "<ul class=\"w3-ul w3-card w3-hover-shadow\">"+
                            "<li class=\"w3-black w3-xlarge w3-padding-5\">"+pizzaName+"</li>"+
                            "<li class=\"w3-padding-8\"><b> &nbsp;&nbsp;&nbsp;Small: &nbsp; &#8377;"+smallPizzaPrice+"</b></li>"+
                            "<li class=\"w3-padding-8\"><b> Medium: &nbsp; &#8377;"+mediumPizzaPrice+"</b> </li>"+
                            "<li class=\"w3-padding-8\"><b> &nbsp;&nbsp;&nbsp;Large: &nbsp; &#8377;"+largePizzaPrice+"</b></li>"+
                            "<li class=\"w3-padding-8\">"+
                                "<h2 class=\"w3-opacity\">"+vegOrNonVeg+"</h2>"+
                            "</li>"+
                            "<hidden id=\"pno\" value="+pizzaNo+"></hidden>"+
                            "<li class=\"w3-light-grey w3-padding-10\">"+
                                "<button class=\"w3-button w3-black w3-padding-large\" onclick=\"deleteCartDetailsFromDB()\"><i class=\"fa fa-download\"></i>Remove</button>"+
                                "<button class=\"w3-button w3-black w3-padding-large\" onclick=\"\"><i class=\"fa fa-download\"></i>Order Now</button>"+
                            "</li>"+
                        "</ul>"+
                    "</div>";
            out.println(displayCart);
        } catch(Exception e){
            out.println(" Show exception: " +e);
        }
    }
-->
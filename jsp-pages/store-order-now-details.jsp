<%@ page language="java" import="java.sql.*, java.util.*" %>
<%@include file="common-database.jsp" %>
<%@include file="pizza-quantity-pojo-class.jsp"%>

<!--
    Here details are arrived you have to store only details into the database.
-->

<%
    String fullName = request.getParameter("name");
    
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String contactNo = request.getParameter("contact_no");
    
    String paymentMode = request.getParameter("payment-mode");

    //-------------------Following code is used to retrieve data from db-------------------------
    try{
        int latestPizzaCount = getLatestCountOfPizza(out);
        
        List<PizzaDetails> pizzaListDetails = new ArrayList<PizzaDetails>();
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select * from temp_pizza_quantity order by id desc limit '"+latestPizzaCount+"'";
            rs = stmt.executeQuery(query);
            while(rs.next()){
                PizzaDetails pizzaDetail = new PizzaDetails();
                pizzaDetail.setPizzaNo(rs.getString("pizza_no"));
                pizzaDetail.setPizzaName(rs.getString("pizza_name"));
                pizzaDetail.setSmallPizzaQuantity(rs.getInt("small_pizza_quantity"));
                pizzaDetail.setMediumPizzaQuantity(rs.getInt("medium_pizza_quantity"));
                pizzaDetail.setLargePizzaQuantity(rs.getInt("large_pizza_quantity"));
                pizzaListDetails.add(pizzaDetail);
            }
        } catch(Exception e){
            out.println(" Pizza Details List Exception: " +e);
        } finally {
            closeConnection();
        }
        //--------------------------------------------------------------------------
        
        
        //--------------------------------------------------------------------------
        Map<String, List<Double>> pizzaNoAndPriceTable = new LinkedHashMap<String, List<Double>>(); 
        for(PizzaDetails p : pizzaListDetails){
            String pizzaNo = p.getPizzaNo();
            List<Double> pricesList = getPizzaPricesByNo(pizzaNo, p.getSmallPizzaQuantity(), p.getMediumPizzaQuantity(), p.getLargePizzaQuantity(), out);
            pizzaNoAndPriceTable.put(pizzaNo, pricesList);
        }
        
        //printPricesTable(pizzaNoAndPriceTable, out);
        //--------------------------------------------------------------------------
        
        //---------------------Store Order now details to db----------------------------
        try{
            int currentOrderNo = getCurrentOrderNo(out);
            con = fetchConnection();
            stmt = con.createStatement();
            String newOrderNo = "O"+(currentOrderNo+1);
            
            String pizzaNo = "";
            String finalPrice = "";
            String smallPizzaPriceStr = "";
            String mediumPizzaPriceStr = "";
            String largePizzaPriceStr = "";
            
            for(PizzaDetails p : pizzaListDetails){
                pizzaNo = pizzaNo + p.getPizzaNo() + "/";
                double pricesArray[] = getPizzaPricesByNo(p.getPizzaNo(), pizzaNoAndPriceTable, out);
                
                float smallPizzaPrice = (float)pricesArray[0];
                float mediumPizzaPrice = (float)pricesArray[1];
                float largePizzaPrice = (float)pricesArray[2];
                
                smallPizzaPriceStr += smallPizzaPrice + ",";
                mediumPizzaPriceStr += mediumPizzaPrice + ",";
                largePizzaPriceStr += largePizzaPrice + ",";
                
                finalPrice = finalPrice + (smallPizzaPrice + mediumPizzaPrice + largePizzaPrice) + ",";
            }
            
            String query = "insert into order_now values('"+newOrderNo+"', '"+fullName+"', '"+address+"', '"+city+"', '"+contactNo+"', '"+smallPizzaPriceStr+"', '"+mediumPizzaPriceStr+"', '"+largePizzaPriceStr+"', '"+finalPrice+"', '"+paymentMode+"', '"+pizzaNo+"')";
            stmt.executeUpdate(query);
            if(paymentMode.equals("cash-on-delivery")){
                response.sendRedirect("../download-receipt.jsp");
            } else {
                response.sendRedirect("../payment.jsp");
            }
        } catch(Exception e){
            out.println(" Store order now details exception: " +e);
        } finally {
            closeConnection();
        }
        //--------------------------------------------------------------------------
        
    } catch(Exception e){
        out.println(" Exception: " +e);
    }
%>


<%!
    public static double[] getPizzaPricesByNo(String pizzaNo, Map<String, List<Double>> tableOfPrices, JspWriter out) throws Exception{
        int arrayLength = 3;
        double[] d = new double[arrayLength];
        int i = 0;
        for(Map.Entry m : tableOfPrices.entrySet()){
            String pno = (String)m.getKey();
            if(pno.equals(pizzaNo)){
                List<Double> pricesList = (List<Double>)m.getValue();
                for(Double doublePrice : pricesList){
                    d[i++] = doublePrice;
                }
                break;
            }
        }
        return d;
    }
%>

<%!
    public static int getCurrentOrderNo(JspWriter out) throws Exception{
        int orderNo = 0;
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select order_no from order_now";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                orderNo = 0;
            } else {
                rs.last();
                orderNo = Integer.parseInt(rs.getString("order_no").split("O")[1]);
            }
        } catch(Exception e){
            out.println(" Get current order no exception: " +e);
        } finally {
            closeConnection();
        }
        return orderNo;
    }
%>




<%!
    public static void printPricesTable(Map<String, List<Double>> tableOfPrices, JspWriter out) throws Exception{
        for(Map.Entry m : tableOfPrices.entrySet()){
            List<Double> priceList = (List<Double>)m.getValue();
            out.println(" <br> PizzaNo: " +m.getKey());
            for(Double d : priceList){
                out.println(" => " +d);
            }
        }          
    }
%>


<%!
    public static List<Double> getPizzaPricesByNo(String pizzaNo, int smQuantity, int mdQuantity, int lgQuantity, JspWriter out) throws Exception{
        List<Double> listOfPrices = new ArrayList<Double>();
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select * from pizza where pizza_no = '"+pizzaNo+"'";
            rs = stmt.executeQuery(query);
            while(rs.next()){
                double smallPizzaPrice = rs.getDouble("small_price");
                double mediumPizzaPrice = rs.getDouble("medium_price");
                double largePizzaPrice = rs.getDouble("large_price");
                
                //Here we calculate the final price of each item of pizza (small, medium, large)
                
                double finalSmallPizzaPrice = smallPizzaPrice * smQuantity;
                double finalMediumPizzaPrice = mediumPizzaPrice * mdQuantity;
                double finalLargePizzaPrice = largePizzaPrice * lgQuantity;
                
                listOfPrices.add(finalSmallPizzaPrice);
                listOfPrices.add(finalMediumPizzaPrice);
                listOfPrices.add(finalLargePizzaPrice);
            }
        } catch(Exception e){
            out.println(" Pizza Price Exception: " +e);
        } finally {
            closeConnection();
        }
        return listOfPrices;
    }
%>

<%!
    public static int getLatestCountOfPizza(JspWriter out) throws Exception{
        int count = 0;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select count_of_pizza from temp_pizza_quantity order by id desc";
            rs = stmt.executeQuery(query);
            rs.next();
            count = rs.getInt("count_of_pizza");
        } catch(Exception e){
            out.println(" Lastest Pizza Count Exception: " +e);
        } finally {
            closeConnection();
        }
        return count;
    }
%>

<%!
    public static void printList(List<PizzaDetails> list, JspWriter out) throws Exception{
        for(PizzaDetails pd : list){
            out.println("<br>" +pd.getPizzaNo());
            out.println(pd.getPizzaName());
            out.println(pd.getSmallPizzaQuantity());
            out.println(pd.getMediumPizzaQuantity());
            out.println(pd.getLargePizzaQuantity());
        }
    }
%>
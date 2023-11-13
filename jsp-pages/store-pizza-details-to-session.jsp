<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="pizza-quantity-pojo-class.jsp"%>
<%@include file="common-database.jsp"%>

<!-- The following code is used to fetch data from URL split it and store into the list containing
     pizza details.
     Here, PizzaDetails is a user defined POJO class.
     and we store object of PizzaDetails in List.
-->
<%
    String data = request.getParameter("data");
    StringTokenizer str = new StringTokenizer(data, "$");
    String dataSplitByDoller[] = new String[str.countTokens()];
    int i = 0;
    
    List<PizzaDetails> pizzaList = new ArrayList<PizzaDetails>();
    while(str.hasMoreTokens()){
        dataSplitByDoller[i] = str.nextToken();
        out.println("<br>" + dataSplitByDoller[i]);
        StringTokenizer dataSplitByComma = new StringTokenizer(dataSplitByDoller[i], ",");
        if(dataSplitByComma.hasMoreTokens()){
            PizzaDetails pizzaDetails = new PizzaDetails();
            pizzaDetails.setPizzaNo(dataSplitByComma.nextToken().toString());
            pizzaDetails.setPizzaName(dataSplitByComma.nextToken().toString());
            pizzaDetails.setSmallPizzaQuantity(Integer.parseInt(dataSplitByComma.nextToken().toString()));
            pizzaDetails.setMediumPizzaQuantity(Integer.parseInt(dataSplitByComma.nextToken().toString()));
            pizzaDetails.setLargePizzaQuantity(Integer.parseInt(dataSplitByComma.nextToken().toString()));
            pizzaList.add(pizzaDetails);
        }
        ++i;
    }
    
    try{
        boolean flag = storeTempPizzaDetails(pizzaList, out);
        if(flag){
            out.println(" Details stored ");
        } else {
            out.println(" Details not stored ");
        }
    } catch(Exception e){
        out.println(" Exception: " +e);
    }
%>

<%!
    public static boolean storeTempPizzaDetails(List<PizzaDetails> pizzaList, JspWriter out) throws Exception{
        boolean flag = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            int countOfPizza = pizzaList.size();

            for(PizzaDetails pd : pizzaList){
                String pizzaNo = pd.getPizzaNo();
                String pizzaName = pd.getPizzaName();
                int smallPizzaQuantity = pd.getSmallPizzaQuantity();
                int mediumPizzaQuantity = pd.getMediumPizzaQuantity();
                int largePizzaQuantity = pd.getLargePizzaQuantity();
                
                String insertQuery = "insert into temp_pizza_quantity(pizza_no, pizza_name, small_pizza_quantity, medium_pizza_quantity, large_pizza_quantity, count_of_pizza) values('"+pizzaNo+"', '"+pizzaName+"', "+smallPizzaQuantity+", "+mediumPizzaQuantity+", "+largePizzaQuantity+", "+countOfPizza+")";
                stmt.executeUpdate(insertQuery);
            }
            flag = true;
        } catch(Exception e){
            out.println(" Insert Exception: " +e);
        } finally {
            closeConnection();
        }
        return flag;
    }
%>
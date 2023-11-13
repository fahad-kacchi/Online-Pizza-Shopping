<%@ page language="java" import="java.sql.*, java.util.*" %>
<%@include file="common-database.jsp" %>

<%
    String cardNumber = request.getParameter("cardNumber");
    String expiryMonth = request.getParameter("expiryMonth");
    String expiryYear = request.getParameter("expiryYear");
    String cvvNo = request.getParameter("cvCode");
    
    try{
        String orderNo = getLatestOrderNo(out);
        int currentPaymentNo = getCurrentPaymentNo(out);
        String newPaymentNo = "P"+(currentPaymentNo+1);
        
        con = fetchConnection();
        stmt = con.createStatement();
        String query = "insert into payment values('"+newPaymentNo+"', '"+cardNumber+"', '"+expiryMonth+"', '"+expiryYear+"', '"+cvvNo+"', '"+orderNo+"')";
        stmt.executeUpdate(query);
        response.sendRedirect("../download-receipt.jsp");
    } catch(Exception e){
        out.println(" Exception: " +e);
    }
%>

<%!
    public static int getCurrentPaymentNo(JspWriter out) throws Exception{
        int currentPaymentNo = 0;
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select * from payment";            
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                currentPaymentNo = 0;
            } else {
                rs.last();
                currentPaymentNo = Integer.parseInt(rs.getString("payment_no").split("P")[1]);
            }
            out.println(" => " +currentPaymentNo);
        } catch(Exception e){
            out.println(" Get current payment no exception: " +e);
        } finally {
            closeConnection();
        }
        return currentPaymentNo;
    }
%>


<%!
    public static String getLatestOrderNo(JspWriter out) throws Exception{
        String latestOrderNo = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select * from order_now";
            rs = stmt.executeQuery(query);
            rs.last();
            latestOrderNo = rs.getString("order_no");
        } catch(Exception e){
            out.println(" Exception: " +e);
        } finally {
            closeConnection();
        }
        return latestOrderNo;
    }
%>
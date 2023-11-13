<%@ page language="java" import="java.sql.*"%>
<%@include file="common-database.jsp" %>

<%
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String feedbackMessage = request.getParameter("feedbackMessage");
    
    boolean flag = storeFeedbackDetails(fullName, email, feedbackMessage, out); 
    if(flag){
        out.println(" <center> <font color=green> <b> Details successfully stored </b> </font> </center>");
    } else {
        out.println(" <center> <font color=red> <b> There is an error occurred. </b> </font> </center>");
    }
%>

<%!
    public static boolean storeFeedbackDetails(String fullName, String email, String feedbackMessage, JspWriter out) throws Exception{
        boolean flag = false;
        String feedbackNo = getNewFeedbackNo(out);
        if(feedbackNo == null){
            feedbackNo = "F1";
        }
        
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "insert into feedback_details values('"+feedbackNo+"','"+fullName+"','"+email+"','"+feedbackMessage+"')";
            stmt.executeUpdate(query);
            flag = true;
        } catch(Exception e){
            out.println(" Feedback Storing Exception: " +e);
        } finally{
            closeConnection();
        }
        return flag;
    }
%>

<%!
    public static String getNewFeedbackNo(JspWriter out) throws Exception{
        String newFeedbackNo = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select feedbackno from feedback_details";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                newFeedbackNo = null;
            } else {
                rs.last();
                String feedbackNo = rs.getString("feedbackno");
                String arr[] = feedbackNo.split("F");
                int latestNo = Integer.parseInt(arr[1]);
                ++latestNo;
                newFeedbackNo = "F"+latestNo;
            }
        } catch(Exception e){
            out.println(" Exception: " +e);
        } finally {
            closeConnection();
        }
        return newFeedbackNo;
    }
%>
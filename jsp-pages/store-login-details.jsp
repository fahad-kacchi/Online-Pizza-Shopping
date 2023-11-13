<%@ page language="java"%>
<%@include file="common-database.jsp" %>

<%
    String fullname = request.getParameter("name");
    String emailId = request.getParameter("emailid");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");
    
    try{
        boolean flag = storeLoginDetails(fullname, emailId, password, confirmPassword, out);
        if(flag){
            response.sendRedirect("../login-page.html");
        }
    } catch(Exception e){
        out.println(" Login Exception: " +e);
    }
%>

<%!
    public static boolean storeLoginDetails(String fullname, String emailId, String password, String confirmPassword, JspWriter out) throws Exception{
        boolean flag = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "insert into customer values('"+fullname+"','"+emailId+"','"+password+"','"+confirmPassword+"')";
            stmt.executeUpdate(query);
            flag = true;
        } catch(Exception e) {
            out.println(" <br><br><br><br> <center> <font size=5 color=red> <b> There is an error occurred during storing the details. <br>" + e + "</b> </font> </center>");
        } finally {
            closeConnection();
        }
        return flag;
    }
%>

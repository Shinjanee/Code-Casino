<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ include file="register.jsp" %>
<%@ page import="java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" >
title>CODE CASINO</title>
</head>
<body>
<% 
try 
{
  Class.forName("oracle.jdbc.driver.OracleDriver");
  Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","system");
  String teamname = request.getParameter("teamname");
  String email = request.getParameter("email");
  String phone = request.getParameter("contact");
  String mem1 = request.getParameter("member1name");
  String mem2 = request.getParameter("member2name");
  String cllg = request.getParameter("college");
  String pass = request.getParameter("password");
  Statement stat = conn.createStatement();
  ResultSet rse=stat.executeQuery("select * from REGISTER");
  int f=0;
  while(rse.next())
  {
  	if(rse.getString("TEAM_NAME").equals(teamname))
  	 {f=1;break;}
  }

  if(f==0){
	  stat.executeUpdate("insert into REGISTER(TEAM_NAME,EMAIL_ID,CONTACT_NO,MEM1_FIRSTNAME,MEM2_FIRSTNAME,COLLEGE,PASSWORD) values('"+teamname+"','"+email+"','"+phone+"','"+mem1+"','"+mem2+"','"+cllg+"','"+pass+"')");
	  rse=stat.executeQuery("select * from REGISTER");
	  stat.executeUpdate("insert into ANSWERS(TEAM_NAME) values('"+teamname+"')");
	  rse=stat.executeQuery("select * from ANSWERS");
	  stat.executeUpdate("insert into QUESTIONS(TEAM_NAME) values('"+teamname+"')");
	  rse=stat.executeQuery("select * from QUESTIONS");
	  String n=(String)request.getParameter("teamname");
	  HttpSession sess=request.getSession();
	  sess.setAttribute("SCORE",0);
	  sess.setAttribute("TEAM_NAME",n);
	  RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
		rd.forward(request,response);
  }
  else
  {
	  %><script>alert("Team Name Already Registered!");</script><% 
  }
 %>

<% }catch(ClassNotFoundException e)
{
    out.println(e.getLocalizedMessage());
}
%>
<style>
.text{
	color:white;
	font-weight:bold;
	position: fixed;
	font-size:20px;
	left:45%;
	top:5%
	}
.text1{
	color:red;
	font-weight:bold;
	position: relative;
	font-size:20px;
	margin-left:45%;
}
</style>
</body>

</html>
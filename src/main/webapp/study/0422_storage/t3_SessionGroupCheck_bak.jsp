<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 
<%
  String mid = session.getAttribute("sMid")==null ? "" : (String) session.getAttribute("sMid");
  String nickName = session.getAttribute("sNickName")==null ? "" : (String) session.getAttribute("sNickName");
  int age = session.getAttribute("sAge")==null ? 0 : (int) session.getAttribute("sAge");
%>
 --%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t3_SessionGroupCheck.jsp</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>세션 확인</h2>
  <hr/>
  <table class="table table-hover">
<%
    Enumeration names = session.getAttributeNames();

		while(names.hasMoreElements()) {
			out.println("<tr>");
			out.println("<td>세션명</td>");
			out.println("<td>"+names.nextElement()+"</td>");
			out.println("</tr>");
		}
%>
  </table>
  <br/>
  <div><a href="t3_SessionMain.jsp" class="btn btn-success form-control m-1">돌아가기</a></div>
  <div><button type="button" onclick="location.href='t3_SessionMain.jsp';" class="btn btn-success form-control m-1">돌아가기</button></div>
</div>
<p><br/></p>
</body>
</html>
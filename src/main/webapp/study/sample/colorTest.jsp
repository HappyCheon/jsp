<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>colorTest.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<p><br/></p>
<div class="container">
  <div class="w3-indigo" style="width:300px; height:150px;">
    이곳은 색상 연습입니다.(Indigo)
  </div>
  <br/><br/>
  <div>
    <input type="button" value="버튼컬러" class="btn form-control w3-red w3-hover-gray"/>
    <input type="button" value="버튼컬러" class="btn form-control w3-vivid-yellowish-green w3-hover-blue"/>
  </div>
</div>
<p><br/></p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
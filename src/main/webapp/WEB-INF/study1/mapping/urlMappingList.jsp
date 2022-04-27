<%@page import="study.database.LoginVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
  ArrayList<LoginVO> vos = (ArrayList) request.getAttribute("vos");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>urlMappingList.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<p><br/></p>
<div class="container">
  <h2 class="text-center">전체 회원 리스트</h2>
  <table class="table table-hover text-center">
    <tr class="table-dark text-white">
      <th>번호</th><th>아이디</th><th>성명</th><th>포인트</th><th>최종방문일</th><th>방문횟수</th>
    </tr>
<%
    LoginVO vo = new LoginVO();
		for(int i=0; i<vos.size(); i++) {
			vo = vos.get(i);
%>
      <tr>
        <td><%=vo.getIdx()%></td>
        <td><%=vo.getMid()%></td>
        <td><%=vo.getName()%></td>
        <td><%=vo.getPoint()%></td>
        <td><%=vo.getLastDate()%></td>
        <td><%=vo.getvCount()%></td>
      </tr>
<%  } %>
    <tr><td colspan="6" class="p-0"></td></tr>
  </table>
  <br/>
  <%-- <p class="text-center"><a href="${ctp}/study1/urlMapping" class="btn btn-secondary">돌아가기</a> --%>
  <p class="text-center"><a href="${ctp}/urlMapping.um" class="btn btn-secondary">돌아가기</a>
</div>
<p><br/></p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
<%@page import="guest.GuestVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  ArrayList<GuestVO> vos = (ArrayList<GuestVO>) request.getAttribute("vos");
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>guestList</title>
  <%@ include file="/include/bs4.jsp" %>
  <style>
    th {background-color:#ccc; text-align:center}
  </style>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<p><br/></p>
<div class="container">
  <h2 class="text-center m-3">방 명 록 리 스 트</h2>
  <div class="text-right mb-2">
    <a href="${ctp}/guestInput.gu" class="btn btn-secondary">글쓰기</a>
  </div>
<%
  GuestVO vo = new GuestVO();
  for(int i=0; i<vos.size(); i++) {
  	vo = vos.get(i);

  	String vDate = vo.getvDate().substring(0,19);
  	String content = vo.getContent().replace("\n", "<br/>");
%>
    <table class="table table-borderless m-0 p-0">
      <tr>
        <td class="text-left">방문번호 : <%=vo.getIdx() %></td>
        <td class="text-right">방문IP : <%=vo.getHostIp() %></td>
      </tr>
    </table>
	  <table class="table table-bordered">
	    <tr>
	      <th width="20%">성명</th>
	      <td width="30%"><%=vo.getName() %></td>
	      <th width="20%">방문일자</th>
	      <td width="30%"><%=vDate %></td>
	    </tr>
	    <tr>
	      <th>전자우편</th>
	      <td colspan="3"><%=vo.getEmail() %></td>
	    </tr>
	    <tr>
	      <th>홈페이지</th>
	      <td colspan="3"><%=vo.getHomepage() %></td>
	    </tr>
	    <tr>
	      <th>글내용</th>
	      <td colspan="3"><%=content %></td>
	    </tr>
    </table>
    <br/>
<%
  }
%>
  
<% %>

</div>
<p><br/></p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
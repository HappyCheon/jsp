<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boList.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<p><br/></p>
<div class="container">
  <h2 class="text-center">게 시 판 리 스 트</h2>
  <br/>
  <table class="table table-borderless">
    <tr>
      <td class="text-left p-0">
        <a href="boInput.bo" class="btn btn-secondary btn-sm">글쓰기</a>
      </td>
    </tr>
  </table>
  <table class="table table-hover">
    <tr class="table-dark text-dark">
    	<th>글번호</th>
    	<th>글제목</th>
    	<th>글쓴이</th>
    	<th>글쓴날짜</th>
    	<th>조회수</th>
    	<th>좋아요</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
      <tr>
        <td>${vo.idx}</td>
        <td><a href="boContent.bo?idx=${vo.idx}">${vo.title}</a></td>
        <td>${vo.nickName}</td>
        <td>${vo.wDate}</td>
        <td>${vo.readNum}</td>
        <td>${vo.good}</td>
      </tr>
    </c:forEach>
    <tr><td colspan="6" class="p-0"></td></tr>
  </table>
</div>
<p><br/></p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>wmList.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    setTimeout("location.reload()", 1000*5);
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <table class="table table-hover">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th> <!-- mSw=> 1:받은메세지, 2:새메세지, 3:보낸메세지, 4:수신확인, 5:휴지통, 6:한건의내용상세보기 -->
        <c:if test="${mSw==1 || mSw==2 || mSw==5}">보낸사람</c:if>
        <c:if test="${mSw==3 || mSw==4}">받은사람</c:if>
      </th>
      <th>제목</th>
      <th>
      	<c:if test="${mSw==1 || mSw==2 || mSw==5}">보낸/확인(날짜)</c:if>
        <c:if test="${mSw==3 || mSw==4}">받은사람</c:if>
      </th>
    </tr>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${vo.idx}</td>
        <td>
        	<c:if test="${mSw==1 || mSw==2 || mSw==5}">${vo.sendId}</c:if>
        	<c:if test="${mSw==3 || mSw==4}">${vo.receiveId}</c:if>
        </td>
        <td>
          <a href="wmMessage.wm?mSw=6&idx=${vo.idx}&mFlag=${param.mFlag}">
          	${vo.title}
          </a>
          <c:if test="${vo.receiveSw=='n'}"><img src="${ctp}/images/new.gif"/></c:if>
        </td>
        <td>
          <c:if test="${vo.nReceiveDate < 24}">${fn:substring(vo.receiveDate,11,19)}</c:if>
          <c:if test="${vo.nReceiveDate >= 24}">${fn:substring(vo.receiveDate,0,19)}</c:if>
        </td>
      </tr>
    </c:forEach>
  </table>
</div>
<p><br/></p>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>scMenu.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    $(document).ready(function() {
    	$("#scheduleInputHidden").hide();
    });
  </script>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<p><br/></p>
<div class="container">
  <h4><font color="bule"><b>${ymd}</b></font> 일정 입니다.</h4>
  <p>오늘의 일정은 총 <font color="red"><b>${scheduleCnt}</b></font>건 있습니다.</p>
  <hr/>
  <div>
  	<input type="button" value="일정등록" onclick="scheduleInputView()" id="scheduleInputView" class="btn btn-info"/>
  	<input type="button" value="등록창닫기" onclick="scheduleInputHidden()" id="scheduleInputHidden" class="btn btn-info"/>
  	<input type="button" value="돌아가기" onclick="location.href='${ctp}/schedule.sc?yy=${fn:split(ymd,'-')[0]}&mm=${fn:split(ymd,'-')[1]-1}';" id="scheduleInputHidden" class="btn btn-info"/>
  </div>
  <hr/>
  <c:if test="${scheduleCnt != 0}">
  	<table class="table table-hover text-center">
  	  <tr class="table-dark text-dark">
  	    <th>번호</th>
  	    <th>제 목</th>
  	    <th>분류</th>
  	  </tr>
  	  <c:forEach var="vo" items="${vos}" varStatus="st">
  	    <tr>
  	      <td>${st.count}</td>
  	      <td><a href="#">${fn:substring(vo.content,0,15)}</a></td>
  	      <td>${vo.part}</td>
  	    </tr>
  	  </c:forEach>
  	  <tr><td colspan="3" class="p-0"></td></tr>
  	</table>
  </c:if>
	  
</div>
<p><br/></p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
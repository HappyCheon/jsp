<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>wmInput.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    'use strict';
    function fCheck() {
    	let receiveId = myForm.receiveId.value;
    	let title = myForm.title.value;
    	let content = myForm.content.value;
    	
    	if(receiveId == "") {
    		alert("받는 사람 아이디를 입력하세요!");
    		myForm.receiveId.focus();
    	}
    	else if(title == "") {
    		alert("제목을 입력하세요!");
    		myForm.title.focus();
    	}
    	else if(content == "") {
    		alert("메세지 내용을 입력하세요!");
    		myForm.content.focus();
    	}
    	else {
    		myForm.submit();
    	}
    }
  </script>
</head>
<body>
<br/>
<div class="container">
  <form name="myForm" method="post" action="wmInputOk.wm">
    <table class="table table-bordered">
      <tr>
        <th>보내는 사람</th>
        <td><input type="text" name="sendId" value="${sMid}" readonly class="form-control"/></td>
      </tr>
      <tr>
        <th>받는 사람</th>
        <td>
          <c:if test="${empty param.receiveId}"><input type="text" name="receiveId" value="${param.receiveId}" placeholder="받는사람 아이디" class="form-control"/></c:if>
          <c:if test="${!empty param.receiveId}"><input type="text" name="receiveId" value="${param.receiveId}" readonly placeholder="받는사람 아이디" class="form-control"/></c:if>
        </td>
      </tr>
      <tr>
        <th>메세지 제목</th>
        <td><input type="text" name="title" placeholder="메세지 제목을 입력하세요." class="form-control"/></td>
      </tr>
      <tr>
        <th>메세지 내용</th>
        <td><textarea rows="5" name="content" class="form-control"></textarea></td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="메세지 전송" onClick="fCheck()" class="btn btn-success"/> &nbsp;
          <input type="reset" value="다시쓰기" class="btn btn-secondary"/> &nbsp;
          <input type="button" value="돌아가기" onclick="history.back();" class="btn btn-info"/>
        </td>
      </tr>
    </table>
  </form>
</div>
</body>
</html>
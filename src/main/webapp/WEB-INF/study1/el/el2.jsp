<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>el2.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<p><br/></p>
<div class="container">
  <h3>Form값을 전달받아 출력해본다.</h3>
  아이디 : ${param.mid}<br/>
  비밀번호 : ${param.pwd}<br/>
  성명 : ${param.name}<br/>
  idx : ${param.idx}<br/>
  취미 : ${param.hobby}<br/><br/>
  - 앞의 문장중 '취미'는 같은 변수명을 사용해서 여러개를 넘기므로 배열처리해야 한다.<br/>
  - 만약 배열의 값을 직접 받아 출력하고자 한다면? paramValues 를 사용한다.<br/>
  hobby[0] : ${paramValues.hobby[0]}<br/>
  hobby[1] : ${paramValues.hobby[1]}<br/>
  hobby[2] : ${paramValues.hobby[2]}<br/>
  <hr/>
<%
  int[] num1 = new int[5];
  for(int i=0; i<num1.length; i++) {
  	num1[i] = (i+1) * 10;
  }
  int[] num2 = {10,2,3,4,50};
  
  pageContext.setAttribute("num1", num1);
  pageContext.setAttribute("num2", num2);
%>
  <h3>배열에 저장된 값 출력</h3>
  num1 : ${num1}<br/>
  num1[0] : ${num1[0]}<br/>
  num1[4] : ${num1[4]}<br/>
  num1[5] : ${num1[5]}<br/>
  <p><hr/><br/><a href="el.st" class="btn btn-secondary">돌아가기</a></p>
</div>
<p><br/></p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
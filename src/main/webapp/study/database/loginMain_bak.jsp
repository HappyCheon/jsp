<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  int point = Integer.parseInt(request.getParameter("point"));
  int vCount = Integer.parseInt(request.getParameter("vCount"));
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>loginMain.jsp</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<p><br/></p>
<div class="container text-center">
  <h2>회원 전용방</h2>
  <hr/>
  <p><font color="blue"><b>${sMid}(${sName})</b></font>님 로그인 중이십니다.</p>
  <p><img src="<%=request.getContextPath()%>/images/1.jpg" width="400px"/></p>
  <hr/>
  <p>방문횟수 : <%=vCount%> / 포인트 : <%=point%></p>
  <hr/>
  <div class="row">
    <div class="col"><a href="t2_LoginDel.jsp" class="btn btn-success form-control">개인 정보수정</a></div>
    <div class="col"><a href="t2_LogOut.jsp" class="btn btn-success form-control">회원 탈퇴</a></div>
  </div>
</div>
<p><br/></p>
</body>
</html>
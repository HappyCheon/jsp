<%@page import="board.BoardVO"%>
<%@page import="board.BoardDAO"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberVO"%>
<%@page import="study.database.LoginVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
  MemberDAO memberDao = new MemberDAO();
  ArrayList<MemberVO> memberVos = memberDao.getMemList(99);
  pageContext.setAttribute("memberVos", memberVos);
  
  BoardDAO boardDao = new BoardDAO();
  ArrayList<BoardVO> boardVos = boardDao.getBoList(0, 10, 0);
  pageContext.setAttribute("boardVos", boardVos);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>javagreenJ프로젝트(홍길동)</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <%@ include file="/include/bs4.jsp" %>
  <style>
	  .fakeimg {
	    height: 200px;
	    background: #eee;
	  }
	  .mySlides {display:none;}
  </style>
</head>
<body>

<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>

<!-- 본문영역 -->
<div class="container" style="margin-top:30px">
  <div class="row">
    <div class="col-sm-4">
      <h3 class="p-2">신규 가입 회원</h3>
      <h6 class="text-right">최근 가입한 회원 명단</h6>
      <div class="fakeimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white bg-secondary">
            <th>아이디</th>
            <th>닉네임</th>
          </tr>
	        <c:forEach var="i" begin="0" end="2">
	          <tr>
	             <td>${memberVos[i].mid}</td>
	             <td>${memberVos[i].nickName}</td>
	           </tr>
	        </c:forEach>
	      </table>
      </div>
      <p style="font-size:12px">1회 방문시마다 5point를 지급합니다.(단, 1일 최대 50point 까지 지급)</p>
      <h3>100대 명소</h3>
      <p>대한민국 숨은명소 100선</p>
      <div class="w3-content" style="max-width:400px">
			  <img class="mySlides" src="images/61.jpg" style="width:100%">
			  <div class="mySlides w3-container w3-red">
			    <h3><b>전국 방방곡곡</b></h3>
			    <h4><i>죽기전에 꼭 가봐야 할 곳</i></h4>
			  </div>
			  <img class="mySlides" src="images/62.jpg" style="width:100%">
			  <img class="mySlides" src="images/63.jpg" style="width:100%">
			  <div class="mySlides w3-container w3-large w3-white w3-card-4">
			    <p><span class="w3-tag w3-yellow">New!</span>
			    <p>볼거리 먹을거리 풍성한곳</p>
			    <p>이거리를 생각하세요</p>
			  </div>
			  <img class="mySlides" src="images/1.jpg" style="width:100%">
			  <img class="mySlides" src="images/2.jpg" style="width:100%">
			  <img class="mySlides" src="images/3.jpg" style="width:100%">
			  <img class="mySlides" src="images/4.jpg" style="width:100%">
			  <img class="mySlides" src="images/5.jpg" style="width:100%">
			  <img class="mySlides" src="images/6.jpg" style="width:100%">
			</div>
    </div>
    <div class="col-sm-8">
      <h3 class="text-center p-2">게시판 신규자료</h3>
      <h6 class="text-right">최근에 게시된 글을 보여줍니다.</h6>
      <div class="fakeimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white bg-secondary">
            <th>올린이</th>
            <th>글제목</th>
            <th>올린날짜</th>
          </tr>
	        <c:forEach var="i" begin="0" end="2">
	          <tr>
	             <td>${boardVos[i].nickName}</td>
	             <td>${boardVos[i].title}</td>
	             <td>${fn:substring(boardVos[i].wDate,0,10)}</td>
	           </tr>
	        </c:forEach>
	      </table>
      </div>
      <p>Some text..</p>
      <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
      <br>
      <h2>TITLE HEADING</h2>
      <h5>Title description, Sep 2, 2017</h5>
      <div class="fakeimg">Fake Image</div>
      <p>Some text..</p>
      <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
    </div>
  </div>
</div>
<script>
	var slideIndex = 0;
	carousel();
	
	function carousel() {
	  var i;
	  var x = document.getElementsByClassName("mySlides");
	  for (i = 0; i < x.length; i++) {
	    x[i].style.display = "none"; 
	  }
	  slideIndex++;
	  if (slideIndex > x.length) {slideIndex = 1} 
	  x[slideIndex-1].style.display = "block"; 
	  setTimeout(carousel, 2000); 
	}
</script>
<%@ include file="/include/footer.jsp" %>
</body>
</html>

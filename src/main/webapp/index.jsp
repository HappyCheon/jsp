<%@page import="board.BoardVO"%>
<%@page import="board.BoardDAO"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberVO"%>
<%@page import="study.database.LoginVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  MemberDAO memberDao = new MemberDAO();
  ArrayList<MemberVO> memberVos = memberDao.getMemList(99);
  pageContext.setAttribute("memberVos", memberVos);
  
  BoardDAO boardDao = new BoardDAO();
  ArrayList<BoardVO> boardVos = boardDao.getBoList(0, 10);
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
          <tr class="text-white bg-dark">
            <th>아이디</th>
            <th>닉네임</th>
          </tr>
	        <c:forEach var="i" begin="0" end="2">
	          <tr>
	             <td>&nbsp; - ${memberVos[i].mid}</td>
	             <td>${memberVos[i].nickName}</td>
	           </tr>
	        </c:forEach>
	      </table>
      </div>
      <p>1회 방문시마다 5point를 지급합니다.(단, 1일 최대 50point 까지 지급)</p>
      <h3>Some Links</h3>
      <p>Lorem ipsum dolor sit ame.</p>
      <ul class="nav nav-pills flex-column">
        <li class="nav-item">
          <a class="nav-link active" href="#">Active</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#">Disabled</a>
        </li>
      </ul>
      <hr class="d-sm-none">
    </div>
    <div class="col-sm-8">
      <h3 class="text-center p-2">게시판 신규자료</h3>
      <h6 class="text-right">최근에 게시된 글을 보여줍니다.</h6>
      <div class="fakeimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white bg-dark">
            <th>올린이</th>
            <th>글제목</th>
          </tr>
	        <c:forEach var="i" begin="0" end="2">
	          <tr>
	             <td>${boardVos[i].nickName}</td>
	             <td>${boardVos[i].title}</td>
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

<%@ include file="/include/footer.jsp" %>
</body>
</html>

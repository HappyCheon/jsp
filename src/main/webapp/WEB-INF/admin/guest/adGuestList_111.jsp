<%@page import="guest.GuestVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<%
  String admin = session.getAttribute("sAdmin")==null ? "" : (String) session.getAttribute("sAdmin");
  ArrayList<GuestVO> vos = (ArrayList<GuestVO>) request.getAttribute("vos");
  
  int pag = request.getAttribute("pag")==null? 1 : (int) request.getAttribute("pag");
  int totPage = (int) request.getAttribute("totPage");
  int curScrStartNo = (int) request.getAttribute("curScrStartNo");
  int blockSize = (int) request.getAttribute("blockSize");
  int curBlock = (int) request.getAttribute("curBlock");
  int lastBlock = (int) request.getAttribute("lastBlock");
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adGuestList.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    'use strict';
    function delCheck(idx) {
    	let ans = confirm("게시글을 삭제하시겠습니까?");
    	if(ans) location.href="${ctp}/guestDelete.gu?idx="+idx;
    }
  </script>
  <style>
    th {background-color:#ccc; text-align:center}
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center m-3">방 명 록 리 스 트</h2>
  <div class="row mb-2">
	  <div class="col text-left"></div>
    
    <!-- 페이징 처리 시작 -->
	  <div class="col text-right">
	    <c:if test="${pag >= 1}">
        <a href="adGuestList.ad?pag=1" title="첫페이지">|◁</a>
        <a href="adGuestList.ad?pag=${pag-1}" title="이전페이지">◀</a>
	    </c:if>
	    ${pag}Page / ${totPage}Pages
	    <c:if test="${pag != totPage}">
        <a href="adGuestList.ad?pag=${pag+1}" title="다음페이지">▶</a>
		    <a href="adGuestList.ad?pag=${totPage}" title="마지막페이지">▷|</a>
	    </c:if>
	  </div>
	  <!-- 페이징 처리 끝 -->
  </div>
  <c:forEach var="vo" items="${vos}">
    <c:set var="email" value="${vo.email}"/>
    <c:if test="${empty email}"><c:set var="email" value="- 없음 -"/></c:if>
    <c:set var="homepageStr" value="${vo.homepage}"/>
    <c:if test="${!empty homepage}"><c:set var="homepageStr" value="${fn:substring(homePageStr,7,fn:length(homePageStr))}"/></c:if>
    <c:if test="${empty homepage}"><c:set var="homepageStr" value=""/></c:if>
    <c:if test="${empty homePage}"><c:set var="homePage" value="- 없음 -"/></c:if>
    <%-- <c:if test="${!empty homePage}"><c:set var="homePage" value="<a href='"+homepageStr+"' target='_blank'>"+homepageStr+"</a>"/></c:if> --%>
    <c:set var="vDate" value="${fn:substring(vo.vDate,0,19)}"/>
    <c:set var="content" value="${fn:replace(vo.content,newLine,'<br/>')}"/>
    <table class="table table-borderless m-0 p-0">
      <tr>
        <td class="text-left pl-0">
          방문번호 : ${curScrStartNo}/[<a href="javascript:delCheck(${vo.idx});">삭제</a>]
        </td>
        <td class="text-right pr-0">방문IP : ${vo.getHostIp}</td>
      </tr>
    </table>
	  <table class="table table-bordered">
	    <tr>
	      <th width="20%">성명</th>
	      <td width="30%">${vo.name}</td>
	      <th width="20%">방문일자</th>
	      <td width="30%">${vDate}</td>
	    </tr>
	    <tr>
	      <th>전자우편</th>
	      <td colspan="3">${email}</td>
	    </tr>
	    <tr>
	      <th>홈페이지</th>
	      <td colspan="3">${homepage}</td>
	    </tr>
	    <tr>
	      <th>글내용</th>
	      <td colspan="3" style="height:200px">${content}</td>
	    </tr>
    </table>
    <br/>
    <c:set var="curScrStartNo" value="${curScrStartNo-1}"/>

  </c:forEach>
  <!-- 블록 페이징 처리 시작 -->
  <div class="text-center">
  	<%if(pag != 1) { %>
        [<a href="adGuestList.ad?pag=1">첫페이지</a>]
    <%} %>
    
    
    <%if(curBlock > 0) { %>
        [<a href="adGuestList.ad?pag=<%=(curBlock-1)*blockSize + 1%>">이전블록</a>]
    <%} %>
    <%
    	for(int i=(curBlock*blockSize)+1; i<=(curBlock*blockSize)+blockSize; i++) {
    		if(i > totPage) break;
    		if(i == pag) out.println("[<a href='adGuestList.ad?pag="+i+"'><font color='red'><b>"+i+"</b></font></a>]");
    		else out.println("[<a href='adGuestList.ad?pag="+i+"'>"+i+"</a>]");
    	}
    %>
    <%if(curBlock < lastBlock) { %>
        [<a href="adGuestList.ad?pag=<%=(curBlock+1)*blockSize + 1%>">다음블록</a>]
    <%} %>
    
    
    <%if(pag != totPage) { %>
    	[<a href="adGuestList.ad?pag=<%=totPage%>">마지막페이지</a>]
    <%} %>
  </div>
  <!-- 블록 페이징 처리 끝 -->
 
</div>
</body>
</html>
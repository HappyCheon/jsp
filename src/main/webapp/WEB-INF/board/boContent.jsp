<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boContent.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    function goodCheck() {
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/boGoodCount",
    		data  : {idx : ${vo.idx}},
    		success:function() {
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류~~");
    		}
    	});
    }
    
    function boardDelCheck() {
    	let ans = confirm("현 게시물을 삭제하시겠습니까?");
    	if(ans) {
    		location.href = "boDeleteOk.bo?idx=${vo.idx}";
    	}
    }
  </script>
  <style>
    th {
      background-color: #eee;
      text-align: center;
    }
  </style>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<p><br/></p>
<div class="container">
  <h2 class="text-center">글 내 용 보 기</h2>
  <br/>
  <table class="table table-borderless m-0">
    <tr><td class="text-right">IP : ${vo.hostIp}</td></tr>
  </table>
  <table class="table table-bordered">
    <tr>
    	<th>글쓴이</th>
    	<td>${vo.nickName}</td>
    	<th>글쓴날짜</th>
    	<td>${fn:substring(vo.wDate,0,19)}</td>  <!-- 2022.05.11 10:13:20.5 -->
    </tr>
    <tr>
    	<th>이메일</th>
    	<td>${vo.email}</td>
    	<th>조회수</th>
    	<td>${vo.readNum}</td>
    </tr>
    <tr>
    	<th>홈페이지</th>
    	<td>${vo.homePage}</td>
    	<th>좋아요</th>
    	<td><a href="javascript:goodCheck()">❤</a>(${vo.good}) / 👍 / 👎 </tr>
    <tr>
    	<th>글내용</th>
    	<td colspan="3" style="height:220px">${fn:replace(vo.content,newLine,"<br/>")}</td>
    </tr>
    <tr>
    	<td colspan="4" class="text-center">
    	  <c:if test="${flag == 's'}">
    			<input type="button" value="돌아가기" onclick="location.href='boSearch.bo?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}';" class="btn btn-secondary"/>
    		</c:if>
    	  <c:if test="${flag != 's'}">
    			<input type="button" value="돌아가기" onclick="location.href='boList.bo?pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary"/>
    		</c:if>
    		<c:if test="${sMid == vo.mid}">
	    		<input type="button" value="수정하기" onclick="location.href='boUpdate.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary"/>
	    		<input type="button" value="삭제하기" onclick="boardDelCheck()" class="btn btn-secondary"/>
    		</c:if>
    	</td>
    </tr>
  </table>

  <!-- 이전글/다음글 처리 -->
  <table class="table table-borderless">
    <tr>
      <td>
        <c:if test="${nextVo.nextIdx != 0}">
	        ☝ <a href="boContent.bo?idx=${nextVo.nextIdx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${nextVo.nextTitle}</a><br/>
        </c:if>
        <c:if test="${preVo.preIdx != 0}">
        	👇 <a href="boContent.bo?idx=${preVo.preIdx}&pag=${pag}&pageSize=${pageSize}">이전글 : ${preVo.preTitle}</a><br/>
        </c:if>
      </td>
    </tr>
  </table>

</div>
<p><br/></p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
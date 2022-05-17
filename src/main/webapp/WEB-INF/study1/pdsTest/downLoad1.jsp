<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>downLoad1.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
  	'use strict';
    function fileDelete(file) {
    	let ans = confirm("파일을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type  : "post",
    		//url   : "${ctp}/fileDelete.st",
    		url   : "${ctp}/fileDelete",
    		data  : {fName : file},
    		success:function(res) {
    			if(res = "fileDeleteOk") {
    				alert("삭제 되었습니다.");
    				location.reload();
    			}
    			else {
    				alert("삭제 실패~~~");
    			}
    		}
    	});
    }
  </script>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<p><br/></p>
<div class="container">
  <h2>파일 다운로드 테스트</h2>
  <p>(서버 파일시스템에 저장되어 있는 파일 리스트)</p>
  <p>${ctp}/data/pdsTest/*.*</p>
  <hr/>
  <table class="table table-hover text-center">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>파일명</th>
      <th>파일형식</th>
      <th>삭제</th>
    </tr>
    <c:forEach var="file" items="${files}" varStatus="st">
    	<tr>
    	  <td>${st.count}</td>
    	  <td><a href="${ctp}/data/pdsTest/${file}" download="${file}">${file}</a></td>
    	  <td>
    	    <c:set var="fNameArr" value="${fn:split(file,'.')}"/>
    	    <c:set var="extName" value="${fn:toLowerCase(fNameArr[fn:length(fNameArr)-1])}"/>
    	    <c:if test="${extName == 'jpg' || extName == 'gif' || extName == 'png'}">
    	      <img src="${ctp}/data/pdsTest/${file}" width="150px"/>
    	    </c:if>
    	    <c:if test="${extName == 'zip'}">압축파일</c:if>
    	    <c:if test="${extName == 'ppt' || extName == 'pptx'}">파워포인트파일</c:if>
    	    <c:if test="${extName != 'jpg' && extName != 'gif' && extName != 'png' && extName != 'zip' && extName != 'ppt' && extName != 'pptx'}">
    	      ${file}
    	    </c:if>
    	  </td>
    	  <td>
    	    <a href="${ctp}/fileDownLoad?file=${file}" class="btn btn-success btn-sm">다운로드</a>
    	    <a href="${ctp}/fileDelete?file=${file}" class="btn btn-danger btn-sm">삭제</a>
    	    <a href="javascript:fileDelete('${file}')" class="btn btn-danger btn-sm">삭제(aJax)</a>
    	  </td>
    	</tr>
    </c:forEach>
    <tr><td colspan="4" class="p-0"></tr>
  </table>
  <hr/>
  <div class="row">
    <div class="col"><a href="upLoad1.st" class="btn btn-info form-control">싱글파일 업로드 폼으로 돌아가기</a></div>
    <div class="col"><a href="upLoad2.st" class="btn btn-info form-control">멀티파일 업로드 폼으로 돌아가기</a></div>
  </div>
</div>
<p><br/></p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
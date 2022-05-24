<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>scMenu.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
  	'use strict';
    $(document).ready(function() {
    	$("#scheduleInputHidden").hide();
    	$(".scheduleUpdateClose").hide();
    });
    
    // 일정 등록폼 보여주기
    function scheduleInputView() {
    	let scheduleInput = '<hr/><div id="scheduleInputForm">';
    	scheduleInput += '<form name="myForm">';
    	scheduleInput += '<table class="table bordered">';
    	scheduleInput += '<tr><th>일정 분류</th><td>';
    	scheduleInput += '<div class="form-group">';
    	scheduleInput += '<select name="part" class="form-control">';
    	scheduleInput += '<option value="모임">모임</option>';
    	scheduleInput += '<option value="업무">업무</option>';
    	scheduleInput += '<option value="학습">학습</option>';
    	scheduleInput += '<option value="여행">여행</option>';
    	scheduleInput += '<option value="기타">기타</option>';
    	scheduleInput += '</select>';
    	scheduleInput += '</div>';
    	scheduleInput += '</td></tr>';
    	scheduleInput += '<tr><th>내 용</th><td>';
    	scheduleInput += '<textarea name="content" rows="4" class="form-control"></textarea>';
    	scheduleInput += '</td></tr>';
    	scheduleInput += '</table>';
    	scheduleInput += '<div>';
    	scheduleInput += '<input type="button" value="일정등록" onclick="scheduleInputOk()" class="btn btn-success form-control"/>';
    	scheduleInput += '</div>';
    	scheduleInput += '</form></div>';

    	$("#scheduleInputView").hide();
    	$("#scheduleInputHidden").show();
    	$("#demo").slideDown(500);
    	$("#demo").html(scheduleInput);
    }
    
    // 일정 등록창 닫기
    function scheduleInputHidden() {
    	$("#scheduleInputForm").slideUp(500);
    	$("#scheduleInputForm").hide();
    	$("#scheduleInputHidden").hide();
    	$("#scheduleInputView").show();
    }
    
    // 일정 등록하기(ajax처리)
    function scheduleInputOk() {
    	let part = myForm.part.value;
    	let content = myForm.content.value;
    	if(content == "") {
    		alert("일정을 입력하세요!");
    		myForm.content.focus();
    		return false;
    	}
    	let query = {
    			mid  : '${sMid}',
    			ymd  : '${ymd}',
    			part : part,
    			content : content
    	}
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/scheduleInputOk",
    		data  : query,
    		success:function(data) {
    			if(data == "scheduleInputOk") {
    				alert("일정이 등록되었습니다.");
    				location.reload();
    			}
    			else {
    				alert("일정등록 오류!!");
    			}
    		},
    		error : function() {
    			alert("전송오류!!!");
    		}
    	});
    }
    
    // 일정관리 내용보기
    function newWin(idx) {
    	let url = "scContent.sc?idx="+idx+"&ymd=${ymd}";
    	window.open(url,"newWin","width=420px,height=350px");
    }
    
    // 일정 삭제하기
    function delCheck(idx) {
    	let ans = confirm("일정을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/scheduleDeleteOk",
    		data : {idx : idx},
    		success:function(data) {
    			if(data == "scheduleDeleteOk") {
    				alert("일정이 삭제되었습니다.");
    				location.reload();
    			}
    			else {
    				alert("일정삭제 실패~~");
    			}
    		},
    		error : function() {
    			alert("전송오류!!!");
    		}
    	});
    }
    
    // 일정 수정하기
    function updateCheck(idx,part,content) {
    	let scheduleUpdate = '<div id="scheduleUpdateForm'+idx+'">';
    	scheduleUpdate += '<form name="updateForm'+idx+'">';
    	scheduleUpdate += '<table class="table bordered">';
    	scheduleUpdate += '<tr><th>일정 분류</th><td>';
    	scheduleUpdate += '<div class="form-group">';
    	scheduleUpdate += '<select name="part" id="part'+idx+'" class="form-control">';
    	scheduleUpdate += '<option value="모임">모임</option>';
    	scheduleUpdate += '<option value="업무">업무</option>';
    	scheduleUpdate += '<option value="학습">학습</option>';
    	scheduleUpdate += '<option value="여행">여행</option>';
    	scheduleUpdate += '<option value="기타">기타</option>';
    	scheduleUpdate += '<option value="'+part+'" selected>'+part+'</option>';
    	scheduleUpdate += '</select>';
    	scheduleUpdate += '</div>';
    	scheduleUpdate += '</td></tr>';
    	scheduleUpdate += '<tr><th>내 용</th><td>';
    	scheduleUpdate += '<textarea name="content" id="content'+idx+'" rows="4" class="form-control">'+content.replaceAll("<br/>","\n")+'</textarea>';
    	scheduleUpdate += '</td></tr>';
    	scheduleUpdate += '</table>';
    	scheduleUpdate += '<div>';
    	scheduleUpdate += '<input type="button" value="일정수정" onclick="scheduleUpdateOk('+idx+')" class="btn btn-success mb-2"/> &nbsp;&nbsp;';
    	scheduleUpdate += '<input type="button" value="수정창닫기" onclick="scheduleUpdateClose('+idx+')" class="btn btn-info mb-2"/>';
    	scheduleUpdate += '</div>';
    	scheduleUpdate += '</form></div>';

    	$("#scheduleUpdateOpenId"+idx).hide();
    	$("#scheduleUpdateCloseId"+idx).show();
    	$("#updateForm"+idx).html(scheduleUpdate);
    }
    
    // ajax로 수정처리하기
    function scheduleUpdateOk(idx) {
    	let part = $("#part"+idx).val();
    	let content = $("#content"+idx).val();
			let query = {
					idx : idx,
					part : part,
					content : content
			}

			$.ajax({
				type : "post",
				url  : "${ctp}/scUpdateOk.sc",
				data : query,
				success:function(data) {
					if(data == 'scheduleUpdateOk') {
						alert("수정완료!!!");
						location.reload();
					}
					else {
						alert("수정실패~~~");
					}
				},
				error : function() {
					alert("전송 실패~~");
				}
			});
    }
    
    // update(수정)창 닫기
    function scheduleUpdateClose(idx) {
    	$("#scheduleUpdateForm"+idx).slideUp(500);
    	$("#scheduleUpdateOpenId"+idx).show();
    	$("#scheduleUpdateCloseId"+idx).hide();
    }
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
  	<input type="button" value="일정등록" onclick="scheduleInputView()" id="scheduleInputView" class="btn btn-success"/>
  	<input type="button" value="등록창닫기" onclick="scheduleInputHidden()" id="scheduleInputHidden" class="btn btn-info"/>
  	<input type="button" value="돌아가기" onclick="location.href='${ctp}/schedule.sc?yy=${fn:split(ymd,'-')[0]}&mm=${fn:split(ymd,'-')[1]-1}';" id="scheduleInputHidden" class="btn btn-info"/>
  </div>
  <div id="demo"></div>
  <hr/>
  <c:if test="${scheduleCnt != 0}">
  	<table class="table table-hover text-center">
  	  <tr class="table-dark text-dark">
  	    <th>번호</th>
  	    <th>제 목</th>
  	    <th>분류</th>
  	    <th>비고</th>
  	  </tr>
  	  <c:forEach var="vo" items="${vos}" varStatus="st">
  	    <tr>
  	      <td>${st.count}</td>
  	      <td>
  	        <a href="javascript:newWin(${vo.idx})">
  	          <c:if test="${fn:indexOf(vo.content,newLine) != -1}">${fn:substring(vo.content,0,fn:indexOf(vo.content,newLine))}</c:if>
  	          <c:if test="${fn:indexOf(vo.content,newLine) == -1}">${fn:substring(vo.content,0,15)}</c:if>
  	        </a>
  	      </td>
  	      <td>${vo.part}</td>
  	      <td>
  	        <c:set var="content" value="${fn:replace(vo.content,newLine,'<br/>')}"/>
  	        <input type="button" value="수정" onclick="updateCheck('${vo.idx}','${vo.part}','${content}')" id="scheduleUpdateOpenId${vo.idx}" class="btn btn-secondary btn-sm"/>
  	        <input type="button" value="닫기" onclick="scheduleUpdateClose(${vo.idx})" id="scheduleUpdateCloseId${vo.idx}" class="btn btn-secondary btn-sm scheduleUpdateClose"/>
  	        <input type="button" value="삭제" onclick="delCheck(${vo.idx})" class="btn btn-danger btn-sm"/>
  	      </td>
  	    </tr>
  	    <tr><td colspan="4" class="p-0"><div id="updateForm${vo.idx}"></div></td></tr>
  	  </c:forEach>
  	  <tr><td colspan="4" class="p-0"></td></tr>
  	</table>
  </c:if>
	  
</div>
<p><br/></p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
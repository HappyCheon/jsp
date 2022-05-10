<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajax1.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script>
    'use strict';
    function idCheck() {
    	// let mid = document.searchForm.mid.value;
    	// let mid = document.getElementById("mid").value;
    	let mid = $("#mid").val();
    	
    	if(mid.trim() == "") {
	    	alert("아이디를 입력하세요.");
	    	$("#mid").focus();
	    	return false;
    	}
    	
    	//  여러개의 값들을 변수에 담아서 넘길경우.....
    	let query = {
    			mid : mid
    	}
    	
    	$.ajax({
    		type  : "get",	// 전송방식(get, post)
    		url   : "${ctp}/ajaxIdSearch",
    		data  : query,
    		// contextType: "application/json",
    		// charset  : "utf-8",
    		success: function(data) {
    			alert("서버에 성공적으로 다녀왔습니다. 성명은? " + data);
    		},
    		error : function() {
    			alert("전송 실패~~~");
    		}
    	});
    }
    
    function idCheck2() {
    	let mid = $("#mid").val();
    	
    	if(mid == "") {
    		alert("아이디를 입력하세요.")
    		$("#mid").focus();
    		return false;
    	}
    	
    	$.ajax({
    		type   : "post",
    		url    : "${ctp}/ajaxIdSearch2",
    		data   : {mid : mid},
    		success: function(data) {
    			alert("성공적으로 다녀왔습니다.");
    			$("#demo").html(data);
    		},
    		error  : function() {
    			alert("전송실패~~~");
    		}
    	});
    }
    
    function idCheck3() {
    	let mid = $("#mid").val();
    	
    	if(mid == "") {
    		alert("아이디를 입력하세요.")
    		$("#mid").focus();
    		return false;
    	}
    	
    	$.ajax({
    		type   : "post",
    		url    : "${ctp}/ajaxIdSearch3",
    		data   : {mid : mid},
    		success: function(data) {
    			alert("성공적으로 다녀왔습니다.");
    			$("#demo").html(data);
    			let str = data.split("/");
    			$("#userId").val(str[0]);
    			$("#userName").val(str[1]);
    			$("#userAge").val(str[2]);
    			$("#userAddress").val(str[3]);
    		},
    		error  : function() {
    			alert("전송실패~~~");
    		}
    	});
    }
    
    // 개별자료조회한 내역을 출력시켜주기
    function userSearch(mid,name,age,address) {
    	$("#userId").val(mid);
    	$("#userName").val(name);
    	$("#userAge").val(age);
    	$("#userAddress").val(address);
    }
    
    // 유저 aJax를 이용한 등록하기
    function userInput() {
    	let mid = $("#userId").val();
    	let name = $("#userName").val();
    	let age = $("#userAge").val();
    	let address = $("#userAddress").val();
    	
    	if(mid=="" || name=="" || age=="" || address=="") {
    		alert("'아이디/성명/나이/주소' 를 입력하세요.")
    		$("#userId").focus();
    		return false;
    	}
    	
    	let query = {
    			mid     : mid,
    			name    : name,
    			age     : age,
    			address : address
    	}
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/ajaxUserInput",
    		data  : query,
    		success:function(data) {
    			if(data == '1') {
    				alert('등록성공!!!');
    				location.reload();
    			}
    			else {
    				alert('등록실패(아이디를 체크하세요)~~~');
    			}
    		},
    		error  :function() {
    			alert("전송오류~~~");
    		}
    	});
    }
    
    // User삭제하기
    function userDelete(idx) {
    	let ans = confirm("현재 자료를 삭제할까요?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type   : "post",
    		url    : "${ctp}/ajaxUserDelete",
    		data   : {idx : idx},
    		success:function(data) {
    			if(data == "1") {
    				alert("자료가 삭제되었습니다.");
    				location.reload();
    			}
    			else alert("삭제 실패~~~");
    		},
    		error  :function() {
    			alert("전송오류");
    		}
    	});
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
  <h2>AJax연습</h2>
  <hr/>
  <form name="searchForm">
    <p>
	    아이디 : <input type="text" name="mid" id="mid" /> &nbsp;
	    <input type="button" value="아이디검색1" onclick="idCheck()" class="btn btn-info"/> &nbsp;
	    <input type="button" value="아이디검색2" onclick="idCheck2()" class="btn btn-success"/> &nbsp;
	    <input type="button" value="아이디검색3" onclick="idCheck3()" class="btn btn-warning"/>
    </p>
    <div>출력결과 : <span id="demo"></span></div>
  </form>
  <hr/>
  <br/>
  <form>
    <table class="table table-bordered">
      <tr>
        <th colspan="2"><h3>User 가입하기폼</h3></th>
      </tr>
      <tr>
        <th>아이디</th>
        <td><input type="text" name="userId" id="userId" class="form-control"/></td>
      </tr>
      <tr>
        <th>성명</th>
        <td><input type="text" name="userName" id="userName" class="form-control"/></td>
      </tr>
      <tr>
        <th>나이</th>
        <td><input type="text" name="userAge" id="userAge" class="form-control"/></td>
      </tr>
      <tr>
        <th>주소</th>
        <td><input type="text" name="userAddress" id="userAddress" class="form-control"/></td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="유저등록" onclick="userInput()" class="btn btn-info"/>&nbsp;
          <input type="reset" value="다시입력" class="btn btn-info"/>&nbsp;
          <input type="button" value="유저전체보기" onclick="userList()" class="btn btn-info"/>
        </td>
      </tr>
    </table>
  </form>
  <hr/>
  <br/>
  <h3>User 전체 리스트</h3>
  <br/>
  <table class="table table-hover text-center">
    <tr>
    	<th>번호</th><th>아이디</th><th>성명</th><th>나이</th><th>주소</th><th>조회</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
      <tr>
        <td>${vo.idx}</td>
        <td>${vo.mid}</td>
        <td>${vo.name}</td>
        <td>${vo.age}</td>
        <td>${vo.address}</td>
        <td>
          <a href="javascript:userSearch('${vo.mid}','${vo.name}','${vo.age}','${vo.address}')" class="btn btn-secondary btn-sm">조회</a>
          <a href="javascript:userDelete(${vo.idx})" class="btn btn-danger btn-sm">삭제</a>
        </td>
      </tr>
    </c:forEach>
  </table> 
</div>
<p><br/></p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test11.jsp</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script>
  	'use strict';
    function fCheck() {
    	let name = myForm.name.value;
    	let gender = myForm.gender.value;
    	let no = myForm.no.value;
    	let hakyun = myForm.hakyun.value;
    	let kor = myForm.kor.value;
    	let eng = myForm.eng.value;
    	let mat = myForm.mat.value;
    	
    	if(name == "") {
    		alert("성명을 입력하세요!");
    		myForm.name.focus();
    	}
    	else if(no == "") {
    		alert("학생 번호를 입력하세요!");
    		myForm.no.focus();
    	}
    	else if(hakyun == "") {
    		alert("학년을 입력하세요!");
    		myForm.hakyun.focus();
    	}
    	else {
    		myForm.submit();
    	}
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <pre>
    문제: 성적평가표 만들기
    입력사항 : 	성명(name : text), 성별(gender : radio), 학생번호(no : number), 학년(hakyun:콤보상자),
    					국어(kor:number), 영어(eng:number), 수학(mat:number), 전송버튼(button), 취소(reset)
		자바스크립트를 이용한 유효성체크(공백)
		전송받을 주소? /T11Ok (컨트롤러 어노테이션 이용)
		
		출력사항 : 입력사항 모두 + 총점/평균/학점
  </pre>
  <br/>
  <hr/>
  <h2>성적입력</h2>
	<form name="myForm" method="get" action="../T11Ok">
	  <table class="table">
	    <tr>
	      <th>성명</th>
	      <td><input type="text" name="name" class="form-control" autofocus /></td>
	    </tr>
	    <tr>
	      <td>성별</td>
	      <td>
	        <input type="radio" name="gender" value="남" checked/>남 &nbsp;&nbsp;
		      <input type="radio" name="gender" value="여">여
		    </td>
		  </tr>
		  <tr>
		    <td>학생번호</td>
		    <td><input type="number" name="no" class="form-control"/></td>
		  </tr>
		  <tr>
		    <td>학년</td>
		    <td>
		      <div class="row">
		        <div class="col">
				      <select name="hakyun" class="form-control">
								<option value="">학년을 선택하세요</option> 		
								<option value="1">1학년</option> 		
								<option value="2">2학년</option> 		
								<option value="3">3학년</option> 		
								<!-- <option value="4">4학년</option> 		
								<option value="5">5학년</option> 		
								<option value="6">6학년</option>  -->		
							</select> &nbsp;&nbsp;
						</div>
						<div class="col">
						  기타 : <input type="number" value="4" name="hakyunOption" min="4" max="6"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
			  <td>국어</td>
			  <td><input type="number" name="kor" value="0" class="form-control"/></td>
			</tr>
			<tr>
			  <td>영어</td>
			  <td><input type="number" name="eng" value="0" class="form-control"/></td>
			</tr>
			<tr>
			  <td>수학</td>
			  <td><input type="number" name="mat" value="0" class="form-control"/></td>
			</tr>
			<tr>
			  <td colspan="2">
			  	<input type="button" value="전송" onclick="fCheck()" class="btn btn-success"/>
			    <input type="reset" value="취소" class="btn btn-success"/>
			  </td>
			</tr>
	  </table>
	</form>
</div>
<p><br/></p>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memJoin.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
  	'use strict';
    // 회원가입폼 체크후 서버로 전송하기
    function fCheck() {
    	let mid = myForm.mid.value;
    	let pwd = myForm.pwd.value;
    	let nickName = myForm.nickName.value;
    	let name = myForm.name.value;
    	let email1 = myform.email1.value;
    	
    	// 사진 업로드 체크
    	let fName = myForm.fName.value;
    	let ext = fName.substring(fName.lastIndexOf(".")+1);	// 파일 확장자 발췌
    	let uExt = ext.toUpperCase();		// 확장자를 대문자로 변환
    	let maxSize = 1024 * 1024 * 2; 	// 업로드할 회원사진의 용량은 2MByte까지로 제한한다.
    	
    	if(mid == "") {
    		alert("아이디를 입력하세요");
    		myForm.mid.focus();
    	}
    	else if(pwd == "") {
    		alert("비밀번호를 입력하세요");
    		myForm.pwd.focus();
    	}
    	else if(nickName == "") {
    		alert("닉네임을 입력하세요");
    		myForm.nickName.focus();
    	}
    	else if(name == "") {
    		alert("성명을 입력하세요");
    		myForm.name.focus();
    	}
    	else if(email1 == "") {
    		alert("이메일을 입력하세요");
    		myForm.email1.focus();
    	}
    	// 기타 추가로 체크해야 할 항목들을 모두 체크하세요.....
    	else {
    		// 전송전에 주소를 하나로 묶어서 전송처리 준비한다.
    		let postcode = myForm.postcode.value + " ";
    		let roadAddress = myForm.roadAddress.value + " ";
    		let detailAddress = myForm.detailAddress.value + " ";
    		let extraAddress = myForm.extraAddress.value;
    		myForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
    		
    		// 전송전에 파일에 관한 사항체크...
    		if(fName.trim() == "") {
    			myForm.photo.value = "noimage.jpg"
    		}
    		else {
    			let fileSize = document.getElementById("file").files[0].size;
    			
    			if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG") {
    				alert("업로드 가능한 파일은 'JPG/GIF/PNG'파일 입니다.");
    				return false;
    			}
    			else if(fName.indexOf(" ") != -1) {
    				alert("업로드 파일명에 공백을 포함할 수 없습니다.");
    				return false;
    			}
    			else if(fileSize > maxSize) {
    				alert("업로드 파일의 크기는 2MByte를 초과할수 없습니다.");
    				return false;
    			}
    			myForm.submit();
    		}
    	}
    }
  </script>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<div class="container" style="padding:30px">
  <form name="myForm" method="post" action="${ctp}/memJoinOk.mem" class="was-validated" enctype="Multipart/form-data">
    <h2>회 원 가 입</h2>
    <br/>
    <div class="form-group">
      <label for="mid">아이디 : &nbsp; &nbsp;<input type="button" value="아이디 중복체크" class="btn btn-secondary" onclick="idCheck()"/></label>
      <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus/>
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 :</label>
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
    </div>
    <div class="form-group">
      <label for="nickname">닉네임 : &nbsp; &nbsp;<input type="button" value="닉네임 중복체크" class="btn btn-secondary" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요." name="nickName" required />
    </div>
    <div class="form-group">
      <label for="name">성명 :</label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
    </div>
    <div class="form-group">
      <label for="email">Email address:</label>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
				  <div class="input-group-append">
				    <select name="email2" class="custom-select">
					    <option value="naver.com" selected>naver.com</option>
					    <option value="hanmail.net">hanmail.net</option>
					    <option value="hotmail.com">hotmail.com</option>
					    <option value="gmail.com">gmail.com</option>
					    <option value="nate.com">nate.com</option>
					    <option value="yahoo.com">yahoo.com</option>
					  </select>
				  </div>
				</div>
	  </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="여자">여자
			  </label>
			</div>
    </div>
    <div class="form-group">
      <label for="birthday">생일</label>
			<input type="date" name="birthday" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
	      <div class="input-group-prepend">
	        <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
			      <select name="tel1" class="custom-select">
					    <option value="010" selected>010</option>
					    <option value="02">서울</option>
					    <option value="031">경기</option>
					    <option value="032">인천</option>
					    <option value="041">충남</option>
					    <option value="042">대전</option>
					    <option value="043">충북</option>
			        <option value="051">부산</option>
			        <option value="052">울산</option>
			        <option value="061">전북</option>
			        <option value="062">광주</option>
					  </select>-
	      </div>
	      <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>-
	      <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
	    </div> 
    </div>
    <div class="form-group">
      <label for="address">주소</label>
			<input type="hidden" name="address" id="address">
			<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호">
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소"><br>
			<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소">
			<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목">
    </div>
    <div class="form-group">
	    <label for="homepage">Homepage address:</label>
	    <input type="text" class="form-control" name="homePage" value="http://" placeholder="홈페이지를 입력하세요." id="homePage"/>
	  </div>
    <div class="form-group">
      <label for="name">직업</label>
      <select class="form-control" id="job" name="job">
        <option>학생</option>
        <option>회사원</option>
        <option>공무원</option>
        <option>군인</option>
        <option>의사</option>
        <option>법조인</option>
        <option>세무인</option>
        <option>자영업</option>
        <option>기타</option>
      </select>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">취미</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="등산" name="hobby"/>등산
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="낚시" name="hobby"/>낚시
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="수영" name="hobby"/>수영
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="독서" name="hobby"/>독서
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="영화감상" name="hobby"/>영화감상
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="바둑" name="hobby"/>바둑
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="축구" name="hobby"/>축구
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
			  </label>
			</div>
    </div>
    <div class="form-group">
      <label for="content">자기소개</label>
      <textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요."></textarea>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">정보공개</span>  &nbsp; &nbsp; 
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="공개" checked/>공개
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="비공개"/>비공개
			  </label>
			</div>
    </div>
    <div  class="form-group">
      회원 사진(파일용량:2MByte이내) :
      <input type="file" name="fName" id="file" class="form-control-file border"/>
    </div>
    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원가입</button>
    <button type="reset" class="btn btn-secondary">다시작성</button>
    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/memLogin.mem';">돌아가기</button>
    <input type="hidden" name="photo"/>
  </form>
  <p><br/></p>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
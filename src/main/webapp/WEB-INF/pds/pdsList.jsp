<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>pdsList.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    'use strict';
    
    // 부분자료 검색처리
    function partCheck() {
    	let part = partForm.part.value;
    	location.href = "${ctp}/pdsList.pds?part="+part;
    }
    
    // 모달창을 이용하여 개별내용 상세보기
    function modal_view(title,part,nickName,mid,fName,fDate,fSize,fSName) {
    	let imgs = fSName.split("/");
    	
    	$("#myModal").on("show.bs.modal", function(e) {
    		$(".modal-header #title").html(title);
    		$(".modal-header #part").html(part);
    		$(".modal-body #nickName").html(nickName);
    		$(".modal-body #mid").html(mid);
    		$(".modal-body #fName").html(fName);
    		$(".modal-body #fDate").html(fDate);
    		$(".modal-body #fSize").html(fSize);
    		$(".modal-body #fSName").html(fSName);
    		$(".modal-body #imgSrc").attr("src", 'data/pds/'+imgs[0]);
    	});
    }
    
    // 다운로드 수 증가처리
    function downNumCheck(idx) {
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/pdsDownNum.pds",
    		data : {idx : idx},
    		success:function() {
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
    
    // 파일 삭제처리하기
    function pdsDelCheck(idx,fSName) {
    	let ans = confirm("자료파일을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	let pwd = prompt("비밀번호를 입력하세요?");
    	let query = {
    			idx : idx,
    			fSName : fSName,
    			pwd : pwd
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/pdsDelete.pds",
    		data : query,
    		success:function(data) {
    			if(data == 'pdsDeleteOk') {
    				alert("삭제 되었습니다.");
    				location.reload();
    			}
    			else {
    				alert("삭제 실패~~");
    			}
    		},
    		error : function() {
    			alert("전송 오류~~");
    		}
    	});
    }
    
    // 모달창을 이용하여 비밀번호 값 전송하기
    function modalPwdView(idx, fSName) {
    	$("#myPwdModal").on("show.bs.modal", function(e) {
    		$(".modal-body #idx").val(idx);
    		$(".modal-body #fSName").val(fSName);
    	});
    }
  </script>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<p><br/></p>
<div class="container">
  <h2 class="text-center">자 료 실 리 스 트(${part})</h2>
  <br/>
  <table class="table table-borderless">
  	<tr>
  	  <td class="text-left" style="width:20%">
  	    <form name="partForm">
  	      <select name="part" onchange="partCheck()" class="form-control">
  	        <option value="전체" ${part == '전체' ? 'selected' : ''}>전체</option>
  	        <option value="학습" ${part == '학습' ? 'selected' : ''}>학습</option>
  	        <option value="여행" ${part == '여행' ? 'selected' : ''}>여행</option>
  	        <option value="음식" ${part == '음식' ? 'selected' : ''}>음식</option>
  	        <option value="기타" ${part == '기타' ? 'selected' : ''}>기타</option>
  	      </select>
  	    </form>
  	  </td>
  	  <td class="text-right"><a href="${ctp}/pdsInput.pds" class="btn btn-outline-success">자료올리기</a></td>
  	</tr>
  </table>
  <table class="table table-hover table-striped text-center">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>자료제목</th>
      <th>올린이</th>
      <th>올린날짜</th>
      <th>분류</th>
      <th>파일명(사이즈)</th>
      <th>다운수</th>
      <th>비고</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
      <tr>
        <td>${curScrStartNo}</td>
        <td>
          <c:if test="${vo.openSw == '공개' || sMid == vo.mid || sLevel == 0}">
          	<a href="${ctp}/pdsContent.pds?idx=${vo.idx}&pag=${pag}&part=${part}">${vo.title}</a><c:if test="${vo.wNdate <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
          </c:if>
          <c:if test="${vo.openSw != '공개' && sMid != vo.mid && sLevel != 0}">
          	${vo.title}<c:if test="${vo.wNdate <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
          </c:if>
        </td>
        <td>${vo.nickName}</td>
        <td>
          <c:if test="${vo.wNdate <= 24}">${fn:substring(vo.fDate,11,19)}</c:if>
          <c:if test="${vo.wNdate > 24}">${fn:substring(vo.fDate,0,10)}</c:if>
        </td>
        <td>
          <!-- modal기능을 이용한 개별정보 상세보기 -->
          <a href="#" data-toggle="modal" data-target="#myModal" onclick="modal_view('${vo.title}','${vo.part}','${vo.nickName}','${vo.mid}','${vo.fName}','${vo.fDate}','${vo.fSize}','${vo.fSName}');">${vo.part}</a>
        </td>
        <td>
          <c:if test="${vo.openSw == '공개' || sMid == vo.mid || sLevel == 0}">
            <%-- ${vo.fName}<br/> --%>
            <c:set var="fNames" value="${fn:split(vo.fName,'/')}"/>
            <c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"/>
            <c:forEach var="fName" items="${fNames}" varStatus="st">
              <a href="${ctp}/data/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>
            </c:forEach>
            
            (<fmt:formatNumber value="${vo.fSize / 1024}" pattern="#,##0"/>KByte)
          </c:if>
          <c:if test="${vo.openSw != '공개' && sMid != vo.mid && sLevel != 0}">
            비공개
          </c:if>
        </td>
        <td>${vo.downNum}</td>
        <td>
          <c:if test="${sMid == vo.mid || sLevel == 0}">
          	<a href="${ctp}/pdsTotalDown.pds?idx=${vo.idx}" class="btn btn-primary btn-sm">전체다운</a>
          	<a href="javascript:pdsDelCheck('${vo.idx}','${vo.fSName}')" class="btn btn-danger btn-sm">삭제</a>
          	<a href="#" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myPwdModal" onclick="modalPwdView('${vo.idx}','${vo.fSName}');">삭제2</a>
          </c:if>
        </td>
      </tr>
      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
  </table>
</div>

<!-- 블록 페이징 처리 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
	  <c:if test="${pag > 1}">
	    <li class="page-item"><a href="pdsList.pds?pag=1&pageSize=${pageSize}&part=${part}" class="page-link text-secondary">◁◁</a></li>
	  </c:if>
	  <c:if test="${curBlock > 0}">d
	    <li class="page-item"><a href="pdsList.pds?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&part=${part}" class="page-link text-secondary">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
	    <c:if test="${i <= totPage && i == pag}">
	      <li class="page-item active"><a href="pdsList.pds?pag=${i}&pageSize=${pageSize}&part=${part}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
	    </c:if>
	    <c:if test="${i <= totPage && i != pag}">
	      <li class="page-item"><a href='pdsList.pds?pag=${i}&pageSize=${pageSize}&part=${part}' class="page-link text-secondary">${i}</a></li>
	    </c:if>
	  </c:forEach>
	  <c:if test="${curBlock < lastBlock}">
	    <li class="page-item"><a href="pdsList.pds?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&part=${part}" class="page-link text-secondary">▶</a></li>
	  </c:if>
	  <c:if test="${pag != totPage}">
	    <li class="page-item"><a href="pdsList.pds?pag=${totPage}&pageSize=${pageSize}&part=${part}" class="page-link text-secondary">▷▷</a></li>
	  </c:if>
  </ul>
</div>
<!-- 블록 페이징 처리 끝 -->

<!-- The Modal(part를 클릭하면 content를 제외한 내용을 모달로 출력처리한다.) -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
    
      <div class="modal-header">
        <h4 class="modal-title"><span id="title"></span>(분류:<span id="part"></span>)</h4>
        <button type="button" class="close" data-dismiss="modal"><font color='red'>×</font></button>
      </div>
      
      <div class="modal-body">
        - 올린이 : <span id="nickName"></span>
        <hr/>
        - 아이디 : <span id="mid"></span><br/>
        - 파일명 : <span id="fName"></span><br/>
        - 올린날짜 : <span id="fDate"></span><br/>
        - 파일크기 : <span id="fSize"></span><br/>
        <hr/>
        - 저장파일명 : <span id="fSName"></span><br/>
        <img id="imgSrc" width="380px"/><br/> 
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
      
    </div>
  </div>
</div>

<!-- The Modal(폼태그로 비밀번호 처리) -->
<div class="modal fade" id="myPwdModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">비밀번호 조회</h4>
        <button type="button" class="close" data-dismiss="modal"><font color='red'>×</font></button>
      </div>
      <div class="modal-body">
        <form name="pwdModalForm" method="post" action="${ctp}/pdsPwdCheck.pds" class="was-validated">
          <label for="pwd">비밀번호</label>
        	<input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" class="form-control mb-2" required />
        	<input type="submit" value="비밀번호 확인" class="btn btn-success form-control"/>
        	<input type="hidden" name="idx" id="idx"/>
        	<input type="hidden" name="fSName" id="fSName"/>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<p><br/></p>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
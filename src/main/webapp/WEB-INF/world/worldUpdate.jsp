<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>worldUpdate.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
    'use strict';
    
	   let nickCheckSw = 0;
   
    function fCheck() {
    	
    	// 유효성 검사
	 		let regMid = /^[a-zA-Z0-9_]{4,20}$/;
	 		let regNickName = /^[가-힣0-9]+$/;  
	 		let regName = /^[가-힣a-zA-Z]+$/; 
	 		let regTel = /^[0-9]*$/
	 		
	 		// 
	 		let mid = myform.mid.value.trim();
	 		let nickName = myform.nickName.value;
	 		let name = myform.name.value;
	 		
	 		let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value;
    	let email = email1 + "@" + email2;
    	
    	let tel1 = myform.tel1.value;
    	let tel2 = myform.tel2.value.trim();
    	let tel3 = myform.tel3.value.trim();
    	let tel = tel1 + "-" + tel2 + "-" + tel3;
	   
    	if(!regMid.test(mid)) {
    		alert("아이디는 4~20자리의 영문 소/대문자와 숫자, 언더바(_)만 사용가능합니다.");
    		myform.mid.focus();
    		return false;
    	}
    	else if(!regNickName.test(nickName)) {
    		alert("닉네임은 한글과 숫자만 사용가능합니다.");
    		myform.nickName.focus();
    		return false;
    	}
    	else if(!regName.test(name)) {
    		alert("성명은 한글과 영문대소문자만 사용가능합니다.");
    		myform.nickName.focus();
    		return false;
    	}
    	if(tel2 != "" && tel3 !="") {
    		let imsiTel = tel2 + tel3;
    		if(!regTel.test(imsiTel)) {
    			alert("전화번호는 숫자만 입력 가능합니다...");
        	myform.tel.focus();
        	return false;
    		}
			}
			else {
				tel2 = " ";
				tel3 = " ";
				tel = tel1 + "-" + tel2 + "-" + tel3;
			}
    	
    	
	    let fName = document.getElementById("file").value;
			if(fName.trim() != "") {
				let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
				let maxSize = 1024 * 1024 * 10;
				let fileSize = document.getElementById("file").files[0].size;
				
				if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'webp'){
						alert("그림파일만 업로드 가능합니다.");
						return false;
				}
				else if(fileSize > maxSize) {
					alert("업로드할 파일의 최대용량은 10MByte입니다.");
					return false;
				}
			}
		
			
				// 아이디/닉네임 중복체크
			if(nickCheckSw == 0) {
					alert("닉네임 중복체크버튼을 눌러주세요");
					document.getElementById("nickNameBtn").focus();
			}
			else {
					myform.email.value = email;
					myform.tel.value = tel;
				
					
					myform.submit();
			}
		}

		
		// 닉네임 중복체크
		function nickCheck() {
			let nickName = myform.nickName.value;
			
			if(nickName.trim() == "") {
				alert("닉네임을 입력하세요!");
				myform.nickName.focus();
			}
			else if(nickName == '${sNickName}') {
	    	alert("현재 닉네임을 그대로 사용합니다.");
	    	nickCheckSw = 1;
	    	return false;
	    }
			else {
				nickCheckSw = 1;
				
				$.ajax({
					url  : "${ctp}/WorldNickCheck.wd",
					type : "get",
					data : {nickName : nickName},
					success:function(res) {
						if(res != '0') {
							alert("이미 사용중인 닉네임 입니다. 다시 입력하세요.");
							myform.nickName.focus();
						}
						else alert("사용 가능한 닉네임 입니다.");
					},
					error : function() {
						alert("전송 오류!");
					}
				});
			}
		}
		
		$(function(){
			$("#nickName").on("blur", () => {
				nickCheckSw = 0;
			});
		});
		
		   
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform" method="post" action="WorldUpdateOk.wd" class="was-validated">
    <h2>정 보 수 정</h2>
    <br/>
    <div>아이디 : ${sMid}</div>
    <div class="form-group">
      <label for="nickName">닉네임 : &nbsp; &nbsp;<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-secondary btn-sm" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" name="nickName" value="${vo.nickName}" required />
    </div>
    <div class="form-group">
      <label for="name">성명 :</label>
      <input type="text" class="form-control" id="name" name="name" value="${vo.name}" required />
    </div>
    <div class="form-group">
      <label for="email1">Email address:</label>
        <div class="input-group mb-3">
          <c:set var="email" value="${fn:split(vo.email,'@')}"/>
          <input type="text" class="form-control" id="email1" name="email1" value="${email[0]}" required />
          <div class="input-group-append">
            <select name="email2" class="custom-select">
              <option value="naver.com"   ${email[1] == 'naver.com' ? 'selected' : ''}>naver.com</option>
              <option value="gmail.com"   ${email[1] == 'gmail.com' ? 'selected' : ''}>gmail.com</option>
              <option value="nate.com"    ${email[1] == 'nate.com' ? 'selected' : ''}>nate.com</option>
            </select>
          </div>
        </div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="남자" <c:if test="${vo.gender == '남자'}">checked</c:if>>남자
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="여자" <c:if test="${vo.gender == '여자'}">checked</c:if>>여자
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="birthday">생일</label>
      <input type="date" name="birthday" value="${fn:substring(vo.birthday, 0, 10)}" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
            <select name="tel1" class="custom-select">
              <option value="010" ${tel1 == '010' ? 'selected' : ''}>010</option>
              <option value="02"  ${tel1 == '02'  ? 'selected' : ''}>서울</option>
              <option value="031" ${tel1 == '031' ? 'selected' : ''}>경기</option>
              <option value="032" ${tel1 == '032' ? 'selected' : ''}>인천</option>
              <option value="041" ${tel1 == '041' ? 'selected' : ''}>충남</option>
              <option value="042" ${tel1 == '042' ? 'selected' : ''}>대전</option>
              <option value="043" ${tel1 == '043' ? 'selected' : ''}>충북</option>
              <option value="051" ${tel1 == '051' ? 'selected' : ''}>부산</option>
              <option value="052" ${tel1 == '052' ? 'selected' : ''}>울산</option>
              <option value="061" ${tel1 == '061' ? 'selected' : ''}>전북</option>
              <option value="062" ${tel1 == '062' ? 'selected' : ''}>광주</option>
            </select>-
        </div>
        <input type="text" name="tel2" value="${tel2}" size=4 maxlength=4 class="form-control"/>-
        <input type="text" name="tel3" value="${tel3}" size=4 maxlength=4 class="form-control"/>
      </div>
    </div>
    <div  class="form-group">
      회원 사진(파일용량:2MByte이내) : <img src="${ctp}/images/world/${vo.photo}" width="100px"/>
      <input type="file" name="fName" id="file" class="form-control-file border"/>
    </div>
    <div class="form-group">
      <label for="content">자기소개 : </label>
      <input type="text" class="form-control" id="content" name="content" value="${vo.content}" />
    </div>
    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원정보수정</button> &nbsp;
    <button type="reset" class="btn btn-secondary">다시작성</button> &nbsp;
    <button type="button" class="btn btn-secondary" onclick="location.href='WorldMain.wd';">돌아가기</button>
    <button type="button" class="btn btn-secondary" onclick="location.href='WorldDelete.wd';">회원탈퇴</button>
    
    <input type="hidden" name="email" />
    <input type="hidden" name="tel" />
    <input type="hidden" name="mid" value="${sMid}" />
    <input type="hidden" name="photo" value="${vo.photo}" />
      <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
  </form>
</div>
<p><br/></p>
</body>
</html>
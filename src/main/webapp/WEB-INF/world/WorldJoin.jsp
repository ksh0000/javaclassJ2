<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Insert</title>
   <jsp:include page="/include/bs4.jsp"></jsp:include>
   <script>
	   'use strict';
	   
	   let idCheckSw = 0;
	   let nickCheckSw = 0;
   
    function fCheck() {
    	
    	// 유효성 검사
	 		let regMid = /^[a-zA-Z0-9_]{4,20}$/;
	 		let regPwd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
	 		let regNickName = /^[가-힣0-9]+$/;  
	 		let regName = /^[가-힣a-zA-Z]+$/; 
	 		
	 		// 
	 		let mid = myform.mid.value.trim();
 		  let pwd = myform.pwd.value.trim(); 
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
    	else if(!regPwd.test(pwd)) {
    		alert("비밀번호는 8~16자리의 영문 대/소문자와 특수문자 하나를 꼭 포함해 주세요.");
    		myform.pwd.focus();
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
			if(idCheckSw == 0) {
					alert("아이디 중복체크버튼을 눌러주세요");
					document.getElementById("midBtn").focus();
				}
			else if(nickCheckSw == 0) {
					alert("닉네임 중복체크버튼을 눌러주세요");
					document.getElementById("nickNameBtn").focus();
				}
			else {
					myform.email.value = email;
					myform.tel.value = tel;
					myform.submit();
			}
		}

		// 아이디 중복체크
		function idCheck() {
			let mid = myform.mid.value;
			
			if(mid.trim() == "") {
				alert("아이디를 입력하세요!");
				myform.mid.focus();
			}
			else {
				idCheckSw = 1;
				
				$.ajax({
					url  : "WorldIdCheck.wd",
					type : "get",
					data : {mid : mid},
					success:function(res) {
						if(res != '0') {
							alert("이미 사용중인 아이디 입니다. 다시 입력하세요.");
							myform.mid.focus();
						}
						else alert("사용 가능한 아이디 입니다.");
					},
					error : function() {
						alert("전송 오류!");
					}
				});
			}
		}
		
		// 닉네임 중복체크
		function nickCheck() {
			let nickName = myform.nickName.value;
			
			if(nickName.trim() == "") {
				alert("닉네임을 입력하세요!");
				myform.nickName.focus();
			}
			else {
				nickCheckSw = 1;
				
				$.ajax({
					url  : "WorldNickCheck.wd",
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
			$("#mid").on("blur", () => {
				idCheckSw = 0;
			});
			
			$("#nickName").on("blur", () => {
				nickCheckSw = 0;
			});
			
		});
		
		//선택된 사진 미리보기
		function imgCheck(e) {
			 if(e.files && e.files[0]) {
		 		 let reader = new FileReader();
		 		 reader.onload = function(e) {
					document.getElementById("photoDemo").src = e.target.result;
				 }
				 reader.readAsDataURL(e.files[0]);	
		 	  }	   
		 }
		   
   </script>
</head>
<body>
  <jsp:include page="/include/header.jsp"></jsp:include>
<p><br/></p>
<div class="container">
  <form name="myform" method="post" action="${ctp}/WorldJoinOk.wd" class="was-validated" enctype="multipart/form-data">
  <h2>회 원 가 입</h2>
  <br/>
  	<div class="form-group">
      <label for="mid">아이디 : &nbsp; &nbsp;<input type="button" value="아이디 중복체크" id="midBtn" class="btn btn-secondary btn-sm" onclick="idCheck()"/></label>
      <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus/>
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 :</label>
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
    </div>
    <div class="form-group">
      <label for="nickName">닉네임 : &nbsp; &nbsp;<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-secondary btn-sm" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요." name="nickName" required />
    </div>
    <div class="form-group">
      <label for="name">성명 :</label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
    </div>
     <div class="form-group">
      <label for="email1">Email address:</label>
        <div class="input-group mb-3">
          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
          <div class="input-group-append">
          	<select name="email2" class="custom-select">
            	<option value="naver.com" selected>naver.com</option>
            	<option value="gmail.com">gmail.com</option>
            	<option value="nate.com">nate.com</option>
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
	      <input type="date" name="birthday" value="<%=java.time.LocalDate.now() %>" class="form-control"/>
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
	    <div  class="form-group">
	      회원 사진(파일용량:2MByte이내) :
	      <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border"/>
	    	<div><img id="photoDemo" width="100px" /></div>
	    </div>
	    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원가입</button> &nbsp;
	    <button type="reset" class="btn btn-secondary">다시작성</button> &nbsp;
	    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/WorldLogin.wd';">돌아가기</button>
	    
	    <input type="hidden" name="email" />
	    <input type="hidden" name="tel" />
	    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
  </form>
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>
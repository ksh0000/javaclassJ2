<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>worldPwdCheck.jsp</title>
   <jsp:include page="/include/bs4.jsp"></jsp:include>
   <style>
	  body {
	    background-color: #a3a3a3;
	    background-image: url("${ctp}/images/pic/pattern.png");
	    background-size: 100px;
	  
	    position: fixed;
	    left: 0;
	    top: 0;
	    right: 0;
	    bottom: 0;
	    font-size: 16px;
	  
	    /** 기본 폰트 설정 */
	    font-family: "Noto Sans KR", sans-serif;
  	}
   </style>
   <script>
   'use strict';
   
   $(function() {
	   $("#pwdDemo").hide();
   });
   
   function pwdReCheck() {
	 	let pwd = $("#pwd").val().trim();
	 	if(pwd == "") {
	 		alert("현재 비밀번호를 입력하세요~");
	 		$("#pwd").focus();
	 		return false;
	 	}
	 	
	 	$.ajax({
	 		url : "WorldPwdCheckAjax.wd",
	 		type : "post",
	 		data : {pwd : pwd},
	 		success : function(res) {
	 			if(res != "0") $("#pwdDemo").show();
	 			else alert("비밀번호가 틀립니다. 확인해주세요");
	 		},
	 		error : function() {
	 			alert("전송오류!");
	 		}
	 	});
	 }
    
   function pwdChangeCheck() {
		 let pwdCheck = $("#pwdCheck").val();
		 let pwdCheckRe = $("#pwdCheckRe").val();
		
		 if(pwdCheck.trim() == "" || pwdCheckRe.trim() == "") {
			 alert("변경할 비밀번호를 입력하세요");
		 	 $("#pwdCheck").focus();
			 return false;
		 }
		 else if(pwdCheck.trim() != pwdCheckRe.trim()) {
			 alert("새로 입력한 비밀번호가 틀립니다. 확인하세요");
			 $("#pwdCheck").focus();
			 return false;
		 }
		 else {
			 pwdForm.submit();
		 }
	 }
   </script>
   <style>
	   	body {
				background-color: white;
				background-size: 100px;
				
				position: fixed;
				left: 0;
				top: 0;
				right: 0;
				bottom: 0;
	   	}
	   	
	   	.container {
   		background-color: #b4d1da;
   		border-radius: 9px;
   		border: 1px solid #738186;
   		
   		width: 960px;
   		height: 660px;
   		margin: 100px auto;
   		position: relative;
   	}
   	
   	.bookot{
			border: 2px dashed white;
			border-radius: 9px;
			left: 15px;
			top: 15px;
			right: 15px;
			bottom: 15px;
			position: absolute;
   	}
   	
	  </style>
</head>
<body>
<p><br/></p>
<div class="container">
	<div class="bookdot">
	  <form name="myform" method="post" action="WorldPwdCheckOk.wd">
	  	<table class="table table-bordered text-center">
	  		<tr>
	  			<td colspan="2">
	  				<h3>비밀번호 확인</h3>
	  				<div>(회원 정보 수정을 하기위해 현재 비밀번호를 확인합니다.)</div>
	  			</td>
	  		</tr>
	  		<tr>
	  			<th>비밀번호</th>
	  			<th><input type="password" name="pwd" id="pwd" class="form-control" autofocus reqiored/></th>
	  		</tr>
	  		<tr>
	  			<td colspan="2" class="text-center">
	  				<input type="button" value="비밀번호변경" onclick="pwdReCheck()" class="btn btn-success mr-2" />
	  				<input type="submit" value="회원정보변경" class="btn btn-primary br-2" />
	  				<input type="reset" value="다시입력" class="btn btn-info br-2" />
	  				<input type="button" value="돌아가기" onclick="location.href='WorldMain.wd'" class="btn btn-warning mr-2" />
	  			</td>
	  		</tr>
	  	</table>
	  	<br/>
	  </form> 
	  <div id="pwdDemo">
	  	<form name="pwdForm" method="post" action="WorldPwdChangeCheck.wd">
	  		<table>
	  			<tr>
	  				<td>변경할 비밀번호를 입력하세요</td>
	  				<td><input type="password" name="pwdCheck" id="pwdCheck" class="form-control"></td>
	  			</tr>
	  			<tr>
	  				<td>비밀번호 확인</td>
	  				<td><input type="password" name="pwdCheckRe" id="pwdCheckRe" class="form-control"></td>
	  			</tr>
	  			<tr>
	  				<td colspan="2" class="text-center">
	  					<input type="button" value="비밀번호변경하기" onclick="pwdChangeCheck()" class="btn btn-secondary" />
	  				</td>
	  			</tr>
	  		</table>
	  	</form>
	  </div>
	</div>
</div>
<p><br/></p>
</body>
</html>
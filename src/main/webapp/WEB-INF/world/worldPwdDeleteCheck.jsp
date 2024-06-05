<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>worldPwdDeleteCheck.jsp</title>
   <jsp:include page="/include/bs4.jsp"></jsp:include>
   <script>
   'use strict';
   
   function pwdDeleteCheck() {
	   let pwd = $("#pwd").val().trim();
	 	 if(pwd == "") {
	 		 alert("현재 비밀번호를 입력하세요~");
	 		 $("#pwd").focus();
	 	 }
	 	 else {
	 		 let ans = confirm("회원 탈퇴를 하시겠습니까?");
	 		 if(ans) {
	 			 ans = confirm("진짜 회원 탈퇴하시겠습니까? \n 계속 진행하시면 삭제 됩니다.??");
	 			 if(ans) myform.submit();
	 		 }
	 	 }
		 	
	 }
    
   </script>
</head>
<body>
<p><br/></p>
<h2 class="text-center">${sNickName}님의 기밀정보</h2>
<div class="container">
  <form name="myform" method="post" action="WorldDeleteCheckOk.wd">
  	<table class="table table-bordered text-center">
  		<tr>
  			<td colspan="2">
  				<h3>비밀번호 확인</h3>
  				<div>(회원 탈퇴를 하기위해 현재 비밀번호를 확인합니다.)</div>
  			</td>
  		</tr>
  		<tr>
  			<th>비밀번호</th>
  			<th><input type="password" name="pwd" id="pwd" class="form-control" autofocus reqiored/></th>
  		</tr>
  		<tr>
  			<td colspan="2" class="text-center">
  				<input type="button" value="비밀번호확인" onclick="pwdDeleteCheck()" class="btn btn-primary mr-2" />
  				<input type="reset" value="다시입력" class="btn btn-info br-2" />
  				<input type="button" value="돌아가기" onclick="location.href='WorldMain.wd'" class="btn btn-warning" />
  			</td>
  		</tr>
  	</table>
  	<br/>
  </form> 
</div>
<p><br/></p>
</body>
</html>
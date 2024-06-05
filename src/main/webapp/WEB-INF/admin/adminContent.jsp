<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>adminContent.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
</head>
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
	  
	    font-family: "Noto Sans KR", sans-serif;
  	}
</style>
<body>
<p><br/></p>
<div class="container">
  <h3>관리자 메인화면</h3>
  <hr/>
  <p>방명록 새글 : <b>${gCount}</b>건</p>
  <p>자유게시판 새글 :<b>${fCount}</b>건</p>
  <p>신고글 : <b>${cCount}</b>건</p>
  <p>신규등록회원 : <b>${mCount}</b>건</p>
</div>
<p><br/></p>
</body>
</html>
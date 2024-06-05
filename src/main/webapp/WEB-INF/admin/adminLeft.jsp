<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>adminLeft.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
</head>
<body bgcolor="#ccc">
<p><br/></p>
<div class="text-center">
  <h5><a href="AdminMain.ad" target="_top">관리자메뉴</a></h5>
  <hr/>
  <div>
    <h5>방명록</h5>
    <div><a href="WorldGuestList.wdg?flag=admin" target="adminContent">모든 회원 방명록리스트</a></div>
  </div>
  <hr/>
  <div>
    <h5>회원관리</h5>
    <div><a href="WorldList.ad" target="adminContent">회원리스트</a></div>
    <div><a href="ComplaintList.ad" target="adminContent">신고리스트</a></div>
  </div>
  <hr/>
  <div>
    <div><a href="WorldMain.wd" target="_top">집</a></div>
  </div>
</div>
<p><br/></p>
</body>
</html>
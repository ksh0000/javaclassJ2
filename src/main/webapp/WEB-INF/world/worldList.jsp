<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>memberList.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
    'use strict';
    
    $(function(){
    	$("#userDispaly").hide();
    	
    	$("#userInfor").on("click", function(){
    		if($("#userInfor").is(':checked')) {
    			$("#totalList").hide();
    			$("#userDispaly").show();
    		}
    		else {
    			$("#totalList").show();
    			$("#userDispaly").hide();
    		}
    	});
    });
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <hr/>
  <div id="totalList">
	  <h3 class="text-center">전체 회원 리스트</h3>
	  <table class="table table-hover text-center">
	    <tr class="table-dark text-dark">
	      <th>번호</th>
	      <th>아이디</th>
	      <th>닉네임</th>
	      <th>성명</th>
	      <th>생일</th>
	      <th>성별</th>
	      <th>최종방문일</th>
	      <c:if test="${sLevel == 0}">
		      <th>오늘방문횟수</th>
		      <th>활동여부</th>
	      </c:if>
	    </tr>
	    <c:forEach var="vo" items="${vos}" varStatus="st">
		      <tr>
		        <td>${vo.idx}</td>
		        <td><a href="WorldSearch.wd?mid=${vo.mid}">${vo.mid}</a></td>
		        <td>${vo.nickName}</td>
		        <td>${vo.name}</td>
		        <td>${fn:substring(vo.birthday,0,10)}</td>
		        <td>${vo.gender}</td>
		        <td>${fn:substring(vo.lastDate,0,10)}</td>
		        <c:if test="${sLevel == 0}">
			        <td>${vo.todayCnt}</td>
		        </c:if>
		      </tr>
	    </c:forEach>
	    <tr><td colspan="9" class="m-0 p-0"></td></tr>
	  </table>
  </div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
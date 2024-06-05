<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>WorldMain.jsp</title>
  <style>
    body {
      background-color: #a3a3a3;
      background-image: url("${ctp}/images/pic/pattern.png");
      background-size: 100px;
      font-family: "Noto Sans KR", sans-serif;
      font-size: 16px;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .bookcover {
      background-color: #b4d1da;
      border-radius: 9px;
      border: 1px solid #738186;
      width: 960px;
      padding: 15px;
    }

    .bookdot {
      border-radius: 9px;
      border: 2px dashed #ffffff;
      padding: 15px;
      height: 100%;
    }

    .page {
      background-color: #eeeeee;
      border-radius: 9px;
      padding: 15px;
      display: flex;
      flex-direction: column;
      height: 100%;
    }

    .content-title {
      display: flex;
      align-items: center;
      margin-bottom: 1rem;
      font-size: 1.5rem;
    }

    .box {
      background-color: white;
      flex-grow: 1;
      border-radius: 10px;
      border: 1px solid #cdcdcd;
      padding: 1rem;
      overflow: auto;
    }

    .box-title {
      font-family: "KOTRA_BOLD-Bold";
      border-bottom: 1px solid grey;
      color: #3b87ab;
      margin-bottom: 1rem;
      padding-bottom: 0.5rem;
    }

    table {
      width: 100%;
      margin-bottom: 1rem;
      border-collapse: collapse;
    }

    th, td {
      border: 1px solid #cdcdcd;
      padding: 0.5rem;
      text-align: left;
    }

    .pagination {
      list-style: none;
      padding: 0;
      display: flex;
      justify-content: center;
      gap: 0.5rem;
    }

    .pagination li {
      display: inline;
    }

    .pagination a {
      text-decoration: none;
      color: #3B87AB;
    }

    .pagination a:hover {
      text-decoration: underline;
    }

    .btn {
      display: inline-block;
      padding: 0.5rem 1rem;
      border: 1px solid #3B87AB;
      background-color: #3B87AB;
      color: white;
      text-decoration: none;
      border-radius: 5px;
    }
	    .btn:hover {
      background-color: #6B66FF;
    }

    .text-right {
      text-align: right;
    }

    .text-center {
      text-align: center;
    }

    select {
      padding: 0.25rem;
    }

    @import url("https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap");
    @font-face {
      font-family: "NeoDunggeunmo";
      src: url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.3/NeoDunggeunmo.woff") format("woff");
      font-weight: normal;
      font-style: normal;
    }
    @font-face {
      font-family: "KOTRA_BOLD-Bold";
      src: url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10-21@1.1/KOTRA_BOLD-Bold.woff") format("woff");
      font-weight: normal;
      font-style: normal;
    }
    @font-face {
      font-family: "KyoboHand";
      src: url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@1.0/KyoboHand.woff") format("woff");
      font-weight: normal;
      font-style: normal;
    }
  </style>
  <script>
    'use strict';

    function delCheck(idx) {
      let ans = confirm("현재 방문글을 삭제하시겠습니까?");
      if(ans) {
        location.href = 'WorldGuestDelete.wdg?idx=' + idx;
      }
    }

    function pageSizeCheck() {
      let pageSize = document.getElementById("pageSize").value;
      location.href="WorldGuestList.wdg?pag=${pag}&pageSize="+pageSize;
    }
  </script>
</head>
<body>
  <div class="bookcover">
    <div class="bookdot">
      <div class="page">
      <c:if test="${empty flag}">    
      	<div class="content-title">${sFriendId}의 방명록... (*ˊᵕˋo💐o</div>
	        <div class="box">
	        	<div class="box-title">방 명 록 리 스 트</div>
	         	<div class="news-flex-box">
	            <a href="WorldGuestInput.wdg" class="btn btn-info">글쓰기</a>
	            <c:if test="${fn:length(vos) == 0}">등록된 게시물이 없습니다.</c:if>
	            <c:if test="${fn:length(vos) != 0}">
			          <c:set var="curScrStartNo" value="${curScrStartNo}" />
				          <c:forEach var="vo" items="${vos}" varStatus="st">
				            <table>
				              <tr>
				                <td>번호 : ${curScrStartNo}
				                  <c:if test="${sLevel == 3 || sNickName == vo.nickName}">
				                    <a href="javascript:delCheck(${vo.idx})" class="btn btn-danger">삭제</a>
				                  </c:if>
				                </td>
				                <th>아이디 : ${vo.guestId}</th>
				              </tr>
				            </table>
				            <table>
				              <tr>
				                <th>닉네임</th>
				                <td>${sNickName}</td>
				                <th>방문일자</th>
				                <td>${fn:substring(vo.visitDate,0,19)}</td>
				              </tr>
				              <tr>
				                <th>메일주소</th>
				                <td colspan="3">
				                  <c:if test="${empty vo.email || fn:length(vo.email)<6 || fn:indexOf(vo.email,'@')==-1 || fn:indexOf(vo.email,'.')==-1}">- 없음 -</c:if>
				                  <c:if test="${!empty vo.email && fn:length(vo.email)>=6 && fn:indexOf(vo.email,'@')!=-1 && fn:indexOf(vo.email,'.')!=-1}">${vo.email}</c:if>
				                </td>
				              </tr>
				              <tr>
				                <th>방문소감</th>
				                <td colspan="3">${fn:replace(vo.content, newLine, "<br/>")}</td>
				              </tr>
				            </table>
				            <br/>
				            <c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
				          </c:forEach>
								</c:if>
			          <div class="text-center">
			            <ul class="pagination">
			              <c:if test="${pag > 1}"><li><a href="WorldGuestList.wdg?pag=1&pageSize=2">첫페이지</a></li></c:if>
			              <c:if test="${curBlock > 0}"><li><a href="WorldGuestList.wdg?pag=${(curBlock-1)*blockSize + 1}&pageSize=2">이전블록</a></li></c:if>
			              <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
			                <c:if test="${i <= totPage && i == pag}"><li class="active"><a href="WorldGuestList.wdg?pag=${i}&pageSize=2">${i}</a></li></c:if>
			                <c:if test="${i <= totPage && i != pag}"><li><a href="WorldGuestList.wdg?pag=${i}&pageSize=2">${i}</a></li></c:if>
			              </c:forEach>
			              <c:if test="${curBlock < lastBlock}"><li><a href="WorldGuestList.wdg?pag=${(curBlock+1)*blockSize+1}&pageSize=2">다음블록</a></li></c:if>
			              <c:if test="${pag < totPage}"><li><a href="WorldGuestList.wdg?pag=${totPage}&pageSize=2">마지막페이지</a></li></c:if>
			            </ul>
			          </div>
								<div class="menu-container"></div>
						<jsp:include page="/include/nav.jsp" />
	       	</div>
      	</div>
      </c:if>
      <c:if test="${!empty flag}">      
		 	 <div class="content-title">모든 회원의 방명록 보기... (*ˊᵕˋo💐o</div>
      	 <div class="box">
	         <div class="box-title">방 명 록 리 스 트</div>
	         <div class="news-flex-box">
		         <a href="WorldGuestInput.wdg" class="btn btn-info">글쓰기</a>
			         <c:if test="${fn:length(vos) == 0}">등록된 게시물이 없습니다.</c:if>
		           <c:if test="${fn:length(vos) != 0}">
				       <c:set var="curScrStartNo" value="${curScrStartNo}" />
				       <c:forEach var="vo" items="${vos}" varStatus="st">
			        	 <table>
		               <tr>
		                 <td>번호 : ${curScrStartNo}
		                   <c:if test="${sLevel == 3 || sNickName == vo.nickName}">
		                     <a href="javascript:delCheck(${vo.idx})" class="btn btn-danger">삭제</a>
		                   </c:if>
		                 </td>
		                 <th>아이디 : ${vo.guestId}</th>
		               </tr>
			        	 </table>
			        	 <table>
		               <tr>
		                 <th>닉네임</th>
		                 <td>${sNickName}</td>
		                 <th>방문일자</th>
		                 <td>${fn:substring(vo.visitDate,0,19)}</td>
		               </tr>
		               <tr>
		                 <th>메일주소</th>
		                 <td colspan="3">
		                   <c:if test="${empty vo.email || fn:length(vo.email)<6 || fn:indexOf(vo.email,'@')==-1 || fn:indexOf(vo.email,'.')==-1}">- 없음 -</c:if>
		                   <c:if test="${!empty vo.email && fn:length(vo.email)>=6 && fn:indexOf(vo.email,'@')!=-1 && fn:indexOf(vo.email,'.')!=-1}">${vo.email}</c:if>
		                 </td>
		               </tr>
		               <tr>
		                 <th>방문소감</th>
		                 <td colspan="3">${fn:replace(vo.content, newLine, "<br/>")}</td>
		               </tr>
			        	 </table>
			           <br/>
			           <c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
				       </c:forEach>
							 </c:if>
		           <div class="text-center">
		             <ul class="pagination">
		               <c:if test="${pag > 1}"><li><a href="WorldGuestList.wdg?flag=admin&pag=1&pageSize=2">첫페이지</a></li></c:if>
		               <c:if test="${curBlock > 0}"><li><a href="WorldGuestList.wdg?flag=admin&pag=${(curBlock-1)*blockSize + 1}&pageSize=2">이전블록</a></li></c:if>
		               <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
		                 <c:if test="${i <= totPage && i == pag}"><li class="active"><a href="WorldGuestList.wdg?flag=admin&pag=${i}&pageSize=2">${i}</a></li></c:if>
		                 <c:if test="${i <= totPage && i != pag}"><li><a href="WorldGuestList.wdg?flag=admin&pag=${i}&pageSize=2">${i}</a></li></c:if>
		               </c:forEach>
		               <c:if test="${curBlock < lastBlock}"><li><a href="WorldGuestList.wdg?flag=admin&pag=${(curBlock+1)*blockSize+1}&pageSize=2">다음블록</a></li></c:if>
		               <c:if test="${pag < totPage}"><li><a href="WorldGuestList.wdg?flag=admin&pag=${totPage}&pageSize=2">마지막페이지</a></li></c:if>
		             </ul>
		           </div>
						<div class="menu-container"></div>
					<jsp:include page="/include/nav.jsp" />
      	</div>
		 	</div>
     </c:if>
  	</div>
	</div>
</div>
</body>
</html>

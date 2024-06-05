<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>boardList.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
    'use strict';
    
    function pageSizeCheck() {
    	let pageSize = $("#pageSize").val();
    	location.href = "FreeList.fr?pageSize="+pageSize;
    }
    
  	function modalCheck(idx, mid, nickName) {
  		$("#myModal #modalMid").text(mid);
  		$("#myModal #modalNickName").text(nickName);
  		$("#myModal #modalIdx").text(idx);
  	}
  </script>
  <style>
@charset "UTF-8";
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
  
  .bookcover {
    background-color: #b4d1da;
    border-radius: 9px;
    border: 1px solid #738186;
    width: 960px;
    height: 660px;
    margin: 100px auto;
    position: relative;
  }
  
  .bookdot {
    border-radius: 9px;
    border: 2px dashed #ffffff;
    padding: 15px;
    position: absolute;
    top: 15px;
    left: 15px;
    right: 15px;
    bottom: 15px;
  }
  
  .page {
    background-color: #eeeeee;
    border-radius: 9px;
    position: absolute;
    top: 10px;
    left: 10px;
    right: 10px;
    bottom: 10px;
    display: flex;
    padding: 15px;
  }
  
  .profile-container {
    flex: 0.4;
    margin-right: 1.5rem;
  
    display: flex;
    flex-direction: column;
  }
  
  .content-container {
    flex: 1;
    display: flex;
    flex-direction: column;
  }
  
  .menu-container {
    flex: 0.15;
  }
  
  .header {
    flex: 0.1;
  }
  
  .box {
    background-color: white;
    flex: 3;
    border-radius: 10px;
    border: 1px solid #cdcdcd;
  }
  
  .content-title {
    display: flex;
    align-items: center;
  }
  
  .content-title-name {
    flex: 1;
  }
  
  .content-title-url {
    flex: 1;
    font-size: 0.5rem; 
    text-align: end; 
  }
  
  .profile-title {
    font-size: 0.8rem;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .color-red {
    color: red;
  }
  
  .profile-box {
    display: flex;
    flex-direction: column;
    padding: 2rem;
  }
  
  .profile-image {
    flex: none;
  }
  
  .profile-image-img {
    width: 100%;
    height: 100%;
  }
  
  .profile-text {
    margin-top: 1.5rem;
    font-size: 0.75rem;
    line-height: 1.7;
    flex: 1;
    font-size: 12x;
  }
  
  .profile-username {
    flex: 0;
  }

  .content-box{
    display: flex;
    flex-direction: column;
    padding: 1rem;
    overflow: auto;
  }
  
  .menu-button button{
    width: 80px;
    text-align: left;
    margin-bottom: 0.9rem;
    font-size: 1rem;
    font-family: "NeoDunggeunmo";
    padding: 0.4rem;
    background-color: #3B87AB;
    color: white;
    border-radius: 0 5px 5px 0;
    border: 1px solid grey;
    cursor: pointer;
  }

  .menu-button:first-child{
    margin-top: 3rem;
  }

  a button:hover {
    background-color: #6B66FF;
    color: white;
  }

  .profile-dropdown{
    flex: 0;
    border: 1px solid #c9d4da;
    padding: 5px;
    margin-top: 10px;
    font-size: 0.8rem;
    position: relative;
  }

  .triangle-down{
    width: 0;
    height: 0;
    border-left: 4.5px solid transparent;
    border-right: 4.5px solid transparent;
    border-top: 5px solid #838383;
  }

  .dropdown-button{
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .dropdown-content{
    display: none;
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
  }

  .profile-dropdown:hover > .dropdown-content{
    display: block;
  }

  .dropdown-content > a{
    display: block;
    background-color: #f9f9f9;
    box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
    width: 100%;
    padding: 6px;
    color: black;
    text-decoration: none;
  }

  .dropdown-content > a:hover{
    background-color: #f1f1f1;
  }
  @import url("https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap");

@font-face {
  font-family: "NeoDunggeunmo";
  src: url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.3/NeoDunggeunmo.woff")
    format("woff");
  font-weight: normal;
  font-style: normal;
}

@font-face {
  font-family: "KOTRA_BOLD-Bold";
  src: url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10-21@1.1/KOTRA_BOLD-Bold.woff")
    format("woff");
  font-weight: normal;
  font-style: normal;
}

@font-face {
  font-family: "KyoboHand";
  src: url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@1.0/KyoboHand.woff")
    format("woff");
  font-weight: normal;
  font-style: normal;
}

.font-kotra {
  font-family: "KOTRA_BOLD-Bold";
}

.font-kyobohand {
  font-family: "KyoboHand";
}

.font-neo {
  font-family: "NeoDunggeunmo";
}

  </style>
</head>
<body>
<div class="bookcover">
  <div class="bookdot">
    <div class="page">
			<div class="container">
			  <table class="table table-borderless m-0 p-0">
			    <tr>
			      <td colspan="2"><h2 class="text-center">자 유 게 시 판 리 스 트</h2></td>
			    </tr>
			    <tr>
			      <td><a href="FreeInput.fr" class="btn btn-success btn-sm">글쓰기</a></td>
			      <td class="text-right">
			        <select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
			          <option ${pageSize==5  ? "selected" : ""}>5</option>
			          <option ${pageSize==10 ? "selected" : ""}>10</option>
			          <option ${pageSize==15 ? "selected" : ""}>15</option>
			          <option ${pageSize==20 ? "selected" : ""}>20</option>
			          <option ${pageSize==30 ? "selected" : ""}>30</option>
			        </select>
			      </td>
			    </tr>
			  </table>
			  <table class="table table-hover m-0 p-0 text-center">
			    <tr class="table-dark text-dark">
			      <th>글번호</th>
			      <th>글제목</th>
			      <th>글쓴이</th>
			      <th>글쓴날짜</th>
			      <th>조회수(좋아요)</th>
			    </tr>
			    <c:set var="curScrStartNo" value="${curScrStartNo}" />
			    <c:forEach var="vo" items="${vos}" varStatus="st">
						    <tr>
						      <td>${curScrStartNo}</td>
						      <td class="text-left">
						        <a href="FreeContent.fr?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">${vo.title}</a>
						        <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>  
						        <c:if test="${vo.replyCnt != 0}">(${vo.replyCnt})</c:if>
						      </td>
						      <td>
						        ${vo.nickName}
						        <c:if test="${sLevel == 0}">
						          <a href="#" onclick="modalCheck('${vo.idx}','${vo.mid}','${vo.nickName}')" data-toggle="modal" data-target="#myModal" class="badge badge-success">모달</a>
						        </c:if>
						      </td>
						      <td>
						        ${vo.date_diff == 0 ? fn:substring(vo.wDate,11,19) : fn:substring(vo.wDate,0,10)}
						      </td>
						      <td>${vo.readNum}(${vo.good})</td>
						    </tr>
				    <c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
				  </c:forEach>
				  <tr><td colspan="5" class="m-0 p-0"></td></tr>
			  </table>
			  			<br/>
				<div class="text-center">
				  <ul class="pagination justify-content-center">
					  <c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/FreeList.fr?pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
					  <c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/FreeList.fr?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}">이전블록</a></li></c:if>
					  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
					    <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/FreeList.fr?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
					    <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/FreeList.fr?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
					  </c:forEach>
					  <c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/FreeList.fr?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}">다음블록</a></li></c:if>
					  <c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/FreeList.fr?pag=${totPage}&pageSize=${pageSize}">마지막페이지</a></li></c:if>
				  </ul>
				</div>
				<br/>
				<div class="container text-center">
				  <form name="searchForm" method="post" action="FreeSearchList.fr">
				    <b>검색 : </b>
				    <select name="search" id="search">
				      <option value="title">글제목</option>
				      <option value="nickName">글쓴이</option>
				      <option value="content">글내용</option>
				    </select>
				    <input type="text" name="searchString" id="searchString" required />
				    <input type="submit" value="검색" class="btn btn-secondary btn-sm"/>
				  </form>
				</div>
			</div>
			<p><br/></p>
			  <div class="modal fade" id="myModal">
			    <div class="modal-dialog modal-dialog-centered">
			      <div class="modal-content">
			        <div class="modal-header">
			          <h4 class="modal-title">Modal Heading</h4>
			          <button type="button" class="close" data-dismiss="modal">&times;</button>
			        </div>
			        <div class="modal-body">
			          고유번호 : <span id="modalIdx"></span><br/>
			          아이디 : <span id="modalMid"></span><br/>
			          닉네임 : <span id="modalNickName"></span><br/>
			        </div>
			        <div class="modal-footer">
			        	<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        </div>
			      </div>
			    </div>
			  </div>
  		<jsp:include page="/include/nav.jsp" />
  	</div>
	</div>
</div>
</body>
</html>
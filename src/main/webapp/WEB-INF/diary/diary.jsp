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
</head>
<body>
<div class="bookcover">
  <div class="bookdot">
    <div class="page">
    	<div class="box">
	    <div class="box-title">${sFriendId}의 다이어리... (*ˊᵕˋo💐o</div>
				<div class="text-center">
			    <button type="button" onclick="location.href='Diary.da?yy=${yy-1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="이전년도">◁</button>
			    <button type="button" onclick="location.href='Diary.da?yy=${yy}&mm=${mm-1}';" class="btn btn-secondary btn-sm" title="이전월">◀</button>
			    <font size="5">${yy}년 ${mm+1}월</font>
			    <button type="button" onclick="location.href='Diary.da?yy=${yy}&mm=${mm+1}';" class="btn btn-secondary btn-sm" title="다음월">▶</button>
			    <button type="button" onclick="location.href='Diary.da?yy=${yy+1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="다음년도">▷</button>
			    <button type="button" onclick="location.href='Diary.da';" class="btn btn-secondary btn-sm" title="오늘날짜">♥</button>
		  	</div>
				<br/>
				<div class="text-center">
		    	<table class="table table-bordered" style="height:450px">
		      	<tr class="table-dark text-dark">
		        	<th style="width:14%; color:red; vertical-align:middle;">일</th>
		        	<th style="width:14%; vertical-align:middle;">월</th>
		        	<th style="width:14%; vertical-align:middle;">화</th>
		        	<th style="width:14%; vertical-align:middle;">수</th>
		        	<th style="width:14%; vertical-align:middle;">목</th>
		        	<th style="width:14%; vertical-align:middle;">금</th>
		        	<th style="width:14%; vertical-align:middle; color:blue;">토</th>
		      	</tr>
		      	<tr>
		        <c:forEach var="prevDay" begin="${prevLastDay - (startWeek - 2)}" end="${prevLastDay}">
		          <td style="font-size:0.7em;color:#ccc;text-align:left;">${prevYear}-${prevMonth+1}-${prevDay}</td>
		        </c:forEach>
		        <c:set var="cell" value="${startWeek}" />
		        <c:forEach begin="1" end="${lastDay}" varStatus="st" >
		          <c:set var="todaySw" value="${toYear==yy && toMonth==mm && toDay==st.count ? 1 : 0}"/>
		          <td id="td${cell}" ${todaySw==1 ? 'class=today' : ''} style="text-align:left; vertical-align:top; height:90px">
								<c:set var="ymd" value="${yy}-${mm+1}-${st.count}" />
		          	<a href="DiaryMenu.da?ymd=${ymd}">
		          		${st.count}
		          		<c:forEach var="vo" items="${vos}">
		          			<c:if test="${fn:substring(vo.sDate,8,10)==st.count}">
		          		 		- ${vo.part}(${vo.partCnt})<br/>
		          		 	</c:if>
		          		</c:forEach>
		          	</a>
		          </td>
		          <c:if test="${cell % 7 == 0}"><tr></tr></c:if>
		          <c:set var="cell" value="${cell + 1}" />
		        </c:forEach>
		        <c:if test="${(cell - 1) % 7 != 0}">
		          <c:forEach begin="${nextStartWeek}" end="7" varStatus="st">
		            <td style="font-size:0.7em;color:#ccc;text-align:left;">${nextYear}-${nextMonth+1}-${st.count}</td>
		          </c:forEach>
		        </c:if>
		      	</tr>
		    	</table>
			    <div>
						<input type="button" value="돌아가기" onclick="location.href='WorldMain.wd'" class="btn btn-warning " />
				  </div>
				</div>
    	</div>
		</div>
	</div>
</div>
</body>
</html>

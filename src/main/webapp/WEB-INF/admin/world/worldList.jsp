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

    // 전체선택
    function allCheck() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = true;
      }
    }

    // 전체취소
    function allReset() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = false;
      }
    }

    // 선택반전
    function reverseCheck() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = !myform.idxFlag[i].checked;
      }
    }
    
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <hr/>
  <div id="totalList">
	  <h3 class="text-center">전체 회원 리스트</h3>
	  <div class="row">
	    <div class="col input-group">
	      <input type="button" value="전체선택" onclick="allCheck()" class="btn btn-success btn-sm mr-1"/>
	      <input type="button" value="전체취소" onclick="allReset()" class="btn btn-primary btn-sm mr-1"/>
	      <input type="button" value="선택반전" onclick="reverseCheck()" class="btn btn-info btn-sm mr-1"/>
		    <div class="input-group-append">
		    </div>
	    </div>
	    <div class="col text-right">
  	    <c:if test="${pag > 1}">
  	    	<a href="${ctp}/WorldList.ad?pag=1&pageSize=${pageSize}" title="첫페이지">◁◁</a>
  	    	<a href="${ctp}/WorldList.ad?pag=${pag-1}&pageSize=${pageSize}" title="이전페이지">◀</a>
  	    </c:if>
  	    ${pag}/${totPage}
  	    <c:if test="${pag < totPage}">
  	    	<a href="${ctp}/WorldList.ad?pag=${pag+1}&pageSize=${pageSize}" title="다음페이지">▶</a>
  	    	<a href="${ctp}/WorldList.ad?pag=${totPage}&pageSize=${pageSize}" title="마지막페이지">▷▷</a>
  	    </c:if>
	    </div>
    </div>
    <form name="myform">
		  <table class="table table-hover text-center mt-1">
		    <tr class="table-dark text-dark">
		      <th>번호</th>
		      <th>아이디</th>
		      <th>닉네임</th>
		      <th>성명</th>
		      <th>생일</th>
		      <th>성별</th>
		      <th>최종방문일</th>
		      <th>오늘방문횟수</th>
		      <th>등급상황</th>
		    </tr>
		    <c:forEach var="vo" items="${vos}" varStatus="st">
			      <tr>
			        <td>
			          <c:if test="${vo.level != 3}"><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}"/></c:if>
			          <c:if test="${vo.level == 3}"><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}" disabled /></c:if>
			          ${vo.idx}
			        </td>
			        <td><a href="WorldSearch.wd?mid=${vo.mid}">${vo.mid}</a></td>
			        <td>${vo.nickName}</td>
			        <td>${vo.name}</td>
			        <td>${fn:substring(vo.birthday,0,10)}</td>
			        <td>${vo.gender}</td>
			        <td>${fn:substring(vo.lastDate,0,10)}</td>
			        <td>${vo.todayCnt}</td>
			        <td>
		            <c:if test="${vo.level != 3}" >
			          	<c:if test="${vo.level == 2}">로그인</c:if>
		          	</c:if>
		            <c:if test="${vo.level != 2}" >
			          	<c:if test="${vo.level == 3}">관리자</c:if>
			          </c:if>
			        </td>
			      </tr>
		    </c:forEach>
		    <tr><td colspan="9" class="m-0 p-0"></td></tr>
		  </table>
    </form>
  </div>
  <br/>
	<div class="text-center">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/WorldList.ad?pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
	  	<c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/WorldList.ad?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}">이전블록</a></li></c:if>
	  	<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
		    <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/WorldList.ad?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
		    <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/WorldList.ad?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
	  	</c:forEach>
	  	<c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/WorldList.ad?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}">다음블록</a></li></c:if>
	  	<c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/WorldList.ad?pag=${totPage}&pageSize=${pageSize}">마지막페이지</a></li></c:if>
	  </ul>
	</div>
</div>
<p><br/></p>
</body>
</html>
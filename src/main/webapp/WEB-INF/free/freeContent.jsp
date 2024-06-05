<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>boardContent.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
    
  </style>
  <script>
    'use strict';
    
    function freeDelete() {
    	let ans = confirm("현재 게시글을 삭제 하시겠습니까?");
    	if(ans) location.href = "FreeDelete.fr?idx=${vo.idx}";
    }
    
    
    // 좋아요 처리(중복불허)
		function goodCheck() {
    	$.ajax({
    		url  : "FreeGoodCheck.fr",
    		type : "post",
    		data : {idx : ${vo.idx}},
    		success:function(res) {
    			if(res != "0") location.reload();
    			else alert("이미 좋아요 버튼을 클릭하셨습니다.");
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
    
    // 좋아요(따봉)수 증가 처리(중복허용)
    function goodCheckPlus() {
    	$.ajax({
    		url  : "FreeGoodCheckPlusMinus.fr",
    		type : "post",
    		data : {
    			idx : ${vo.idx},
    			goodCnt : +1
    		},
    		success:function(res) {
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
     }
    
    // 좋아요(따봉)수 감소 처리(중복허용)
    function goodCheckMinus() {
    	$.ajax({
    		url  : "FreeGoodCheckPlusMinus.fr",
    		type : "post",
    		data : {
    			idx : ${vo.idx},
    			goodCnt : -1
    		},
    		success:function(res) {
    			if(res != "0") location.reload();
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
     }
    
    // 신고시 '기타'항목 선택시에 textarea 보여주기
    function etcShow() {
    	$("#complaintTxt").show();
    }
    
    // 신고화면 선택후 신고사항 전송하기
    function complaintCheck() {
    	if (!$("input[type=radio][name=complaint]:checked").is(':checked')) {
    		alert("신고항목을 선택하세요");
    		return false;
    	}
    	if($("input[type=radio]:checked").val() == '기타' && $("#complaintTxt").val() == "") {
    		alert("기타 사유를 입력해 주세요.");
    		return false;
    	}
    	
    	let cpContent = modalForm.complaint.value;
    	if(cpContent == '기타') cpContent += '/' + $("#complaintTxt").val();
    	
    	let query = {
    			part   : 'free',
    			partIdx: ${vo.idx},
    			cpMid  : '${sMid}',
    			cpContent : cpContent
    	}
    	
    	$.ajax({
    		url  : "FreeComplaintInput.ad",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("신고 되었습니다.");
    				location.reload();
    			}
    			else alert("신고 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
   		});
    }
    
    // 댓글달기
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요");
    		return false;
    	}
    	let query = {
    			freeIdx 	: ${vo.idx},
    			mid				: '${sMid}',
    			nickName	: '${sNickName}',
    			content		: content
    	}
    	
    	$.ajax({
    		url  : "FreeReplyInput.fr",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("댓글이 입력되었습니다.");
    				location.reload();
    			}
    			else alert("댓글 입력 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
    function replyDelete(idx) {
			let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				url : "FreeReplyDelete.fr",
				type : "post",
				data : {idx : idx},
				success : function(res) {
					if(res != "0") {
						alert("댓글이 삭제되었습니다.");
						location.reload();
					}
					else alert("삭제실패!");
				},
				error : function() {
					slert("전송오류!!");
				}
			});
		}
  </script>
  
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-4">글 내 용 보 기</h2>
  <table class="table table-bordered">
    <tr>
      <th>글쓴이</th>
      <td>${vo.nickName}</td>
      <th>글쓴날짜</th>
      <td>${fn:substring(vo.wDate, 0, 16)}</td>
    </tr>
    <tr>
      <th>글조회수</th>
      <td>${vo.readNum}</td>
    </tr>
    <tr>
      <th>글제목</th>
      <td colspan="3">
        ${vo.title} 
        <a href="javascript:goodCheckPlus()">👍</a> &nbsp;
        <a href="javascript:goodCheckMinus()">👎</a> /
        (<a href="javascript:goodCheck()"><font color="blue" size="5">♥</font></a> : ${vo.good})
      </td>
    </tr>
    <tr>
      <th>글내용</th>
      <td colspan="3" style="height:220px">${fn:replace(vo.content, newLine, "<br/>")}</td>
    </tr>
    <tr>
      <td colspan="4">
        <div class="row">
	        <div class="col">
	        	<c:if test="${empty flag}"><input type="button" value="돌아가기" onclick="location.href='FreeList.fr?pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning" /></c:if>
	        	<c:if test="${!empty flag}"><input type="button" value="돌아가기" onclick="location.href='FreeSearchList.fr?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}';" class="btn btn-warning" /></c:if>
	        </div>
	        	<%-- 	<c:if test="${vo.complaint == 'OK'}"><font color='red'><b>현재 이글은 신고중입니다.</b></font></c:if> --%>
	        <c:if test="${sNickName == vo.nickName || sLevel == 3}">
		        <div class="col text-right">
			        <input type="button" value="수정" onclick="location.href='FreeUpdate.fr?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary" />
			        <input type="button" value="삭제" onclick="freeDelete()" class="btn btn-danger text-right" />
		        </div>
	        </c:if>
	        <c:if test="${sNickName != vo.nickName}">
		        <div class="col text-right">
		          <c:if test="${vo.complaint == 'OK'}">
		          	<c:if test="${sLevel != 3}">
		          		<font color='red'><b>현재 이글은 신고중입니다.</b></font>
		          	</c:if>
		          </c:if>
			        <c:if test="${vo.complaint != 'OK'}"><input type="button" value="신고하기" data-toggle="modal" data-target="#myModal" class="btn btn-danger text-right" /></c:if>
		        </div>
	        </c:if>
        </div>
      </td>
    </tr>
  </table>
  <hr/>
  <!-- 이전글/ 다음글 출력하기 -->
  <table class="table table-borderless">
    <tr>
      <td>
        <c:if test="${!empty nextVo.title}">
          ☝ <a href="FreeContent.fr?idx=${nextVo.idx}&pag=${pag}&pageSize=${pageSize}&sFriend=${sFriend}">다음글 : ${nextVo.title}</a><br/>
        </c:if>
        <c:if test="${!empty preVo.title}">
        	👇 <a href="FreeContent.fr?idx=${preVo.idx}&pag=${pag}&pageSize=${pageSize}&sFriend=${sFriend}">이전글 : ${preVo.title}</a><br/>
        </c:if>
      </td>
    </tr>
  </table>
</div>
<p><br/></p>

<div class="container">
	<table class="table table-hover text-center">
	  <tr>
	    <th>작성자</th>
	    <th>댓글내용</th>
	    <th>댓글일자</th>
	  </tr>
	  <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
	    <tr>
	      <td>${replyVo.nickName}
	        <c:if test="${sMid == replyVo.mid || sLevel == 3}">
	          (<a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제">x</a>)
	        </c:if>
	      </td>
	      <td class="text-left">${fn:replace(replyVo.content, newLine, "<br/>")}</td>
	      <td>${fn:substring(replyVo.wDate, 0, 10)}</td>
	    </tr>
	  </c:forEach>
	  <tr><td colspan="3" class='m-0 p-0'></td></tr>
	</table>
	<form name="replyForm">
	  <table class="table table-center">
	    <tr>
	      <td style="width:85%" class="text-left">
	        글내용 :
	        <textarea rows="4" name="content" id="content" class="form-control"></textarea>
	      </td>
	      <td style="width:15%">
	        <br/>
	        <p>작성자 : ${sNickName}</p>
	        <p><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-info btn-sm"/></p>
	      </td>
	    </tr>
	  </table>
	</form>
	<br/>
</div>
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">현재 게시글을 신고합니다.</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body">
          <b>신고사유 선택</b>
          <hr/>
          <form name="modalForm">
            <div><input type="radio" name="complaint" id="complaint1" value="광고,홍보,영리목적"/> 광고,홍보,영리목적</div>
            <div><input type="radio" name="complaint" id="complaint2" value="욕설,비방,차별,혐오"/> 욕설,비방,차별,혐오</div>
            <div><input type="radio" name="complaint" id="complaint3" value="불법정보"/> 불법정보</div>
            <div><input type="radio" name="complaint" id="complaint4" value="음란,청소년유해"/> 음란,청소년유해</div>
            <div><input type="radio" name="complaint" id="complaint5" value="개인정보노출,유포,거래"/> 개인정보노출,유포,거래</div>
            <div><input type="radio" name="complaint" id="complaint6" value="도배,스팸"/> 도배,스팸</div>
            <div><input type="radio" name="complaint" id="complaint7" value="기타" onclick="etcShow()"/> 기타</div>
            <div id="etc"><textarea rows="2" id="complaintTxt" class="form-control" style="display:none"></textarea></div>
            <hr/>
            <input type="button" value="확인" onclick="complaintCheck()" class="btn btn-success form-control" />
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
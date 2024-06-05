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
  <jsp:include page="/include/bs4.jsp"></jsp:include>
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
    
    $(function() {
    	$("#diaryInputClose").hide();
    });
    
    function diaryInputView() {
    	let str = '<div id="diaryInputForm">';
    	str += '<form name="diaryForm">';
    	str += '<table class="table table-bordered">';
    	str += '<tr>';
    	str += '<th>일정분류</th><td>';
    	str += '<select name="part" class="form-control">';
    	str += '<option>모임</option>';
    	str += '<option>학습</option>';
    	str += '<option>약속</option>';
    	str += '<option>여행</option>';
    	str += '<option>기타</option>';
    	str += '</select>';
    	str += '</td></tr>';
    	str += '<tr><th>내역</th><td>';
    	str += '<textarea name="content" rows="4" class="form-control"></textarea>';
    	str += '</td></tr>';
    	str += '<tr><td colspan="2" class="text-center">';
    	str += '<input type="button" value="일정등록" onclick="diaryInputOk()" class="btn btn-success form-control"/>';
    	str += '</td></tr>';
    	str += '</table>';
    	str += '</form>';
    	str += '</div>';
    	
    	$("#diaryInputView").hide();
    	$("#diaryInputClose").show();
    	
    	$("#demo").html(str);
    }
    
    function diaryInputClose() {
    	$("#diaryInputView").show();
    	$("#diaryInputClose").hide();
    	$("#diaryInputForm").hide();
    }
    
    // 일정 등록하기
    function diaryInputOk() {
    	let part = diaryForm.part.value;
    	let content = diaryForm.content.value;
    	if(content.trim() == "") {
    		alert("일정을 입력하세요");
    		diaryForm.content.focus();
    		return false;
    	}
    	let query = {
    			mid  : '${sMid}',
    			sDate: '${ymd}',
    			part : part,
    			content:content
    	}
    	
    	$.ajax({
    		url  : "DiaryInputOk.da",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("일정이 등록되었습니다.");
    				location.reload();
    			}
    			else alert("일정 등록 실패~");
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
    
    // 일정 삭제하기
    function diaryDeleteCheck(idx) {
    	let ans = confirm("선택된 일정을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "DiaryDeleteOk.da",
    		type : "post",
    		data : {idx : idx},
    		success:function(res) {
    			if(res != "0") {
    				alert("일정이 삭제되었습니다.");
    				location.reload();
    			}
    			else alert("일정 삭제 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
    
    // 일정관리 수정창 보기
    function diaryUpdateView(idx, part, content) {
    	let str = '<div id="diaryUpdateForm'+idx+'">';
  		str += '<form name="diaryUpdateForm">';
    	str += '<table class="table table-bordered">';
    	str += '<tr>';
    	str += '<th>일정분류</th><td>';
    	str += '<select name="part" id="part'+idx+'" class="form-control">';
    	str += '<option>모임</option>';
    	str += '<option>학습</option>';
    	str += '<option>약속</option>';
    	str += '<option>여행</option>';
    	str += '<option>기타</option>';
    	str += '<option value="'+part+'" selected>'+part+'</option>';
    	str += '</select>';
    	str += '</td></tr>';
    	str += '<tr><th>내역</th><td>';
    	str += '<textarea name="content" id="content'+idx+'" rows="4" class="form-control">'+content.replaceAll("<br/>","\n")+'</textarea>';
    	str += '</td></tr>';
    	str += '<tr><td colspan="2" class="text-center">';
    	str += '<input type="button" value="일정수정" onclick="diaryUpdateOk('+idx+')" class="btn btn-success mr-3"/>';
    	str += '<input type="button" value="수정창닫기" onclick="diaryUpdateClose('+idx+')" class="btn btn-warning"/>';
    	str += '</td></tr>';
    	str += '</table>';
    	str += '</form>';
    	str += '</div>';
    	
    	$("#diaryUpdateViewBtn"+idx).hide();
    	$("#updateDemo"+idx).html(str);
    }
    
    function diaryUpdateClose(idx) {
    	$("#diaryUpdateForm"+idx).hide();
    	$("#diaryUpdateViewBtn"+idx).show();
    }
    
    // 일정관리 수정하기
    function diaryUpdateOk(idx) {
    	let part = $("#part"+idx).val();
    	let content = $("#content"+idx).val();
    	let query = {
    			idx  : idx,
    			part : part,
    			content:content
    	}
    	
    	$.ajax({
    		url  : "DiaryUpdateOk.da",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("일정이 수정되었습니다.");
    				location.reload();
    			}
    			else alert("일정 수정 실패~");
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
    
    // 모달창에 상세내역 뿌리기
    function modalView(part, content) {
    	$("#myModal #part").html(part);
    	$("#myModal #content").html(content);
    }

  </script>
</head>
<body>
  <div class="bookcover">
    <div class="bookdot">
      <div class="page">
        <div class="box">
          <div class="box-title">${sNickName}의 다이어리... (*ˊᵕˋo💐o</div>
           <div class="news-flex-box">
					  <h4>${ymd}의 일정입니다.</h4>
					  <p>오늘의 일정은 총 ${diaryCnt}건이 있습니다.</p>
					  <hr/>
					  <div>
					    <input type="button" value="일정등록" onclick="diaryInputView()" id="diaryInputView" class="btn btn-success mb-2"/>
					    <input type="button" value="일정닫기" onclick="diaryInputClose()" id="diaryInputClose" class="btn btn-success mb-2"/>
					    <c:set var="ymds" value="${fn:split(ymd, '-')}"/>
					    <input type="button" value="돌아가기" onclick="location.href='Diary.da?yy=${ymds[0]}&mm=${ymds[1]-1}';" class="btn btn-warning mb-2"/>
					  </div>
					  <div id="demo"></div>
					  <hr/>
					  <c:if test="${diaryCnt != 0}">
					    <table class="table table-hover text-center">
					      <tr class="table-dark text-dark">
					        <th>번호</th>
					        <th>분류</th>
					        <th>내역</th>
					        <th>비고</th>
					      </tr>
					      <c:forEach var="vo" items="${vos}" varStatus="st">
					        <tr>
					          <td>${st.count}</td>
					          <td>${vo.part}</td>
					          <td class="text-left">
					            <a href="#" onclick="modalView('${vo.part}','${fn:replace(vo.content,newLine,'<br/>')}')" data-toggle="modal" data-target="#myModal">
					            	<c:if test="${fn:indexOf(vo.content, newLine) != -1}">${fn:replace(vo.content,newLine,'<br/>')}</c:if>
					            	<c:if test="${fn:indexOf(vo.content, newLine) == -1}">
						            	<c:if test="${fn:length(vo.content) >= 15}">${fn:substring(vo.content,0,16)}...</c:if>
						            	<c:if test="${fn:length(vo.content) < 15}">${vo.content}</c:if>
					            	</c:if>
					            </a>
					          </td>
					          <td>
					             <input type="button" value="수정" id="diaryUpdateViewBtn${vo.idx}" onclick="diaryUpdateView('${vo.idx}','${vo.part}','${fn:replace(vo.content,newLine,'<br/>')}')" class="btn btn-primary btn-sm"/>
					            <input type="button" value="삭제" onclick="diaryDeleteCheck(${vo.idx})" class="btn btn-danger btn-sm"/>
					          </td>
					        </tr>
						      <tr><td colspan="4" class="m-0 p-0"><div id="updateDemo${vo.idx}"></div></td></tr>
					      </c:forEach>
					      <tr><td colspan="4" class="m-0 p-0"></td></tr>
					    </table>
					  </c:if>
					</div>
				<p><br/></p>
				<!-- 일정 상세내역출력을 위한 모달처리 -->
				  <div class="modal fade" id="myModal">
				    <div class="modal-dialog modal-dialog-centered">
				      <div class="modal-content">
				        <!-- Modal Header -->
				        <div class="modal-header">
				          <h4 class="modal-title">>> <b>${ymd}</b></h4>
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				        </div>
				        <!-- Modal body -->
				        <div class="modal-body">
				          <table class="table table-bordered">
				            <tr><th>분류</th><td><span id="part"></span></td>
				            <tr><th>내용</th><td><span id="content"></span></td>
				          </table>
				        </div>
				        <!-- Modal footer -->
				        <div class="modal-footer">
				          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				        </div>
				      </div>
				    </div>
				  </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>

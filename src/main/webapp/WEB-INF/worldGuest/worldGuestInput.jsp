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

    .form-group {
      margin-bottom: 1rem;
    }

    .form-group label {
      display: block;
      margin-bottom: 0.5rem;
    }

    .form-group input, .form-group textarea {
      width: 100%;
      padding: 0.5rem;
      border: 1px solid #cdcdcd;
      border-radius: 5px;
    }

    .form-group .valid-feedback, .form-group .invalid-feedback {
      display: none;
      font-size: 0.875rem;
      color: #28a745;
    }

    .form-group input:invalid ~ .invalid-feedback, .form-group textarea:invalid ~ .invalid-feedback {
      display: block;
      color: #dc3545;
    }

    .form-group input:valid ~ .valid-feedback, .form-group textarea:valid ~ .valid-feedback {
      display: block;
    }

    .text-center {
      text-align: center;
    }

    .btn {
      display: inline-block;
      padding: 0.5rem 1rem;
      border: 1px solid #3B87AB;
      background-color: #3B87AB;
      color: white;
      text-decoration: none;
      border-radius: 5px;
      margin-right: 0.5rem;
    }

    .btn:hover {
      background-color: #6B66FF;
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
        <div class="box">
          <div class="box-title">방 명 록 글 쓰 기</div>
          <form name="myform" method="post" action="WorldGuestInputOk.wdg" class="was-validated">
            <div class="form-group">
              <label for="name"> 닉네임</label>
              <input type="text" class="form-control" id="nickName" value="${sNickName}" placeholder="Enter username" name="nickName" readonly />
              <div class="valid-feedback">Ok!!!</div>
              <div class="invalid-feedback">닉네임을 입력해 주세요.</div>
            </div>
            <div class="form-group">
              <label for="mid">아이디</label>
              <input type="text" class="form-control" name="guestId" id="guestId" value="${sMid}" placeholder="Enter username" readonly />
              <div class="valid-feedback">Ok!!!</div>
              <div class="invalid-feedback">아이디를 입력해 주세요.</div>
            </div>
            <div class="form-group">
              <label for="email">E-mail</label>
              <input type="text" class="form-control" id="email" placeholder="Enter email" name="email" />
            </div>
            <div class="form-group">
              <label for="content">방문소감</label>
              <textarea rows="5" name="content" id="content" required class="form-control"></textarea>
              <div class="valid-feedback">Ok!!!</div>
              <div class="invalid-feedback">방문소감을 입력해 주세요.</div>
            </div>
            <div class="form-group text-center">
              <button type="submit" class="btn btn-primary">방명록 등록</button>
              <button type="reset" class="btn btn-warning">방명록 다시입력</button>
              <button type="button" onclick="location.href='${ctp}/WorldGuestList.wdg'" class="btn btn-danger">돌아가기</button>
            </div>
            <input type="hidden" name="masterId" value="${sFriendId}" />
          </form>
        </div>
      </div>
    </div>
  </div>
</body>
</html>

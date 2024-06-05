<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<style>
	.news-flex-box {
    flex: 0 0 auto;
    margin-bottom: 2rem;
    display: flex;
    font-size: 0.8rem;
  }
  
  .news-box {
    flex: 1;
  }
  
  .update-box {
    flex: 1;
  }
  
  .miniroom {
    flex: 1;
    display: flex;
    flex-direction: column;
  }
  
  .box-title {
    font-family: "KOTRA_BOLD-Bold";
    border-bottom: 1px solid grey;
    color: #3b87ab;
  }
  
  .news-row {
    display: flex;
    font-size: 0.85rem;
    margin: 3px 0;
  }
  
  .news-category {
    padding: 0 6px;
    margin-right: 6px;
    color: white;
    border-radius: 3px;
  }
  
  .category-pic {
    background-color: #f15f5f;
  }
  
  .category-post {
    background-color: #617dc1;
  }
  
  .menu-row {
    display: flex;
    border-bottom: 1px dashed grey;
    margin: 3px 0;
  }
  
  .menu-item {
    flex: 1;
    text-align:right;
  }
  
  .menu-num {
    font-family: "NeoDunggeunmo";
    padding-left: 6px;
    color: #003399;
  }
  
  .miniroom-gif-box {
    border: 1px solid #808080;
    flex: 1;
    display: flex;
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
  
    /** 기본 폰트 설정 */
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
</style>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>WorldMain.jsp</title>
</head>
<body>
<div class="bookcover">
	<div class="bookdot">
  	<div class="page">
      <div class="profile-container">
        <div class="header profile-title font-neo">
          TODAY<span class="color-red"> ${vo.todayCnt}</span> | TOTAL ${vo.visitCnt}
        </div>
        <div class="box profile-box">
          <div class="profile-image">
            <img
              class="profile-image-img"
              src="${ctp}/images/world/${vo.photo}"  
              alt="프로필 이미지"
            />
          </div>
          <div class="profile-text font-kyobohand">
            ${vo.content}
          </div>
          <div class="profile-username font-kyobohand">
            <span style="color: #0f1b5c">${vo.nickName}</span> (♪♬)
          </div>
        </div>
      </div>
      <div class="content-container">
	    	<div class="header content-title">
	      	<div class="content-title-name">${vo.nickName}님의 추억 상ㅈr... (*ˊᵕˋo💐o</div>
	      </div>
	      <div class="box content-box">
	      	<div class="box-title">Updated news</div>
	        <div class="news-flex-box">
	        	<div class="news-box">
	          	<div class="news-row">
	              <div class="news-category category-pic">다이어리</div>
	              <div class="news-title">일상...🍕</div>
	          	</div>
              <div class="news-row">
                <div class="news-category category-post">자유게시판</div>
                <div class="news-title">웹코딩...🍔</div>
              </div>
	            <div class="news-row">
	            <div class="news-category category-post">방명록</div>
	            <div class="news-title">삶...🍿</div>
	            	<div class="update-box">
	              	<div class="menu-row">
	                	<div class="menu-item">다이어리<span class="menu-num">0/25</span></div>
	              	</div>
	              	<div class="menu-row">
	                 	<div class="menu-item text-right">자유게시판<span class="menu-num">0/25</span></div>
	              	</div>
	              	<div class="menu-row">
	               	 <div class="menu-item">방명록<span class="menu-num">0/25</span></div>
	              	</div>
	            	</div>
	            </div>
	          	<div class="miniroom">
	            <div class="box-title">Miniroom</div>
	            <div class="miniroom-gif-box">
	             	<img src="${ctp}/images/good.png" alt="${vo.nickName}의 미니룸" />
	            </div>
	           </div>
	        	</div>
	    	 		<div class="menu-container"></div>
						<jsp:include page="/include/nav.jsp" />
	        </div>
	      </div>
      </div>
  	</div>
	</div>
</div>
</body>
</html>

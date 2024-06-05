<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<style>
		.main-container {
   		display: flex;
   		justify-content: center;
   		align-items: center;
   		height: 100vh;
   		width: 100vw;
   	}

   	.menu-container{
   		flex: 0.15;
   		display: flex;
   		flex-direction: column;
   		justify-content: center;
   		margin-right: 20px;
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
    } 
    
    
    .menu-button:first-child{
    	margin-top: 3rem;
    }
    
    a button:hover {
    	background-color: #6B66FF;
    	color: white;
    }
</style>
<div class="menu-container">
	<div class="menu-button">
		<a href="WorldMain.wd"><button>홈</button></a>
		<a href="Diary.da"><button>다이어리</button></a>
		<a href="FreeList.fr"><button>자유게시판</button></a>
		<a href="WorldGuestList.wdg"><button>방명록</button></a>
		<a href="WorldPwdCheck.wd"><button>내정보</button></a>
		<a href="WorldLogout.wd"><button>로그아웃</button></a>
		<c:if test="${sLevel == 3}"><a href="AdminMain.ad"><button>관리자</button></a></c:if>
		</div>
	</div>
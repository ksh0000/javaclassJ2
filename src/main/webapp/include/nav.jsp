<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<jsp:include page="/include/bs4.jsp"></jsp:include>
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
		<c:if test="${sMid == sFriendId}">
			<a href="Diary.da"><button>다이어리</button></a>
		</c:if>
		<a href="FreeList.fr"><button>자유게시판</button></a>
		<a href="WorldGuestList.wdg"><button>방명록</button></a>
		<c:if test="${sMid == sFriendId}">
			<a href="WorldPwdCheck.wd"><button>내정보</button></a>
			<a href="WorldLogout.wd"><button>로그아웃</button></a>
		</c:if>
			<a href="#" id="jusorokBtn" class="btn btn-info" data-toggle="modal" data-target="#myModal">친구리스트</a>
		<c:if test="${sMid == sFriendId}">
			<c:if test="${sLevel == 3}"><a href="AdminMain.ad"><button>관리자</button></a></c:if>
		</c:if>
		</div>
	</div>
	
<!-- 회원 주소록을 모달로 처리 -->
  <div class="modal" id="myModal">
    <div class="modal-dialog modal-dialog-scrollable">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <!-- <div class="modal-header"> -->
        <div class="m-3">
          <div class="row">
            <!-- <div class="col"><h3 class="modal-title">회원 주소록</h3></div> -->
            <div class="col"><h4>회원 주소록</h4></div>
            <div class="col text-right"><input type="button" value="아이디검색" onclick="idSearchView()" id="idSearchShowBtn" class="btn btn-success btn-sm text-right"/></div>
          </div>
          <div class="row" id="idSearch"></div>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <table class="table table-hover">
            <tr class="table-dark text-dark">
              <th>번호</th>
              <th>아이디</th>
              <th>닉네임</th>
            </tr>
            <c:forEach var="vo" items="${wVos}" varStatus="st">
              <tr>
                <td>${st.count}</td>
                <td><a href="WorldMain.wd?friendId=${vo.mid}">${vo.mid}</a></td>
                <td>${vo.nickName}</td>
              </tr>
            </c:forEach>
            <tr><td colspan="3" class="m-0 p-0"></td></tr>
          </table>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  
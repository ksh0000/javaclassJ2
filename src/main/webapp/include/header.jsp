<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />

<div id="header" class="jumbotron text-center" style="margin-bottom:0; background : url('${pageContext.request.contextPath}/images/back2.jpg') no-repeat center center / cover;">

  <%-- <p>(완공 D-${dday})</p>  --%>
  <p id="completion"></p> 
  
  
</div>
<script>
/*   $(function() {
	  $("#header").on("click",function(){
		  location.href = "http://192.168.50.52:9090/javaclassJ2/WorldLogin";
	  });
  });
   */
  
  $(document).ready(function() {
 	 	var currentDate = new Date();
		currentDate.setDate(currentDate.getDate() - 89);
		
		function updateDate() {
			currentDate.setDate(currentDate.getDate() + 1);
			$("#completion").text("완공 D-" + (89 - Math.floor((new Date() - currentDate) / (1000 * 60 * 60 *24))) + "일" + currentDate.toDateString());
		}
	  
		setInterval(updateDate, 1000 * 60 * 60 * 24);
  });
</script>
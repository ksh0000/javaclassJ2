<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- certification.jsp -->
<%
	String mid = session.getAttribute("sMid")==null ? "" : (String) session.getAttribute("sMid");
	if(mid.equals("")) {
		out.println("<script>");
		out.println("alert('로그인후 사용하세요');");
		out.println("location.href='"+request.getContextPath()+"/study/0428_Login/login.jsp';");
		out.println("</script>");
	}
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
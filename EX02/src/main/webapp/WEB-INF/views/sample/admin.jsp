<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Admin</h1>
	
	<!-- login 정보를 principal로 저장함. -->
	<p>principal : <sec:authentication property="principal"/></p>
	<p>MemberVO : <sec:authentication property="principal.member"/></p>
	<p>UserName : <sec:authentication property="principal.member.userName"/></p>
	<p>UserID : <sec:authentication property="principal.username"/></p>
	<p>Authorities : <sec:authentication property="principal.member.authList"/></p>
	
	
	<a href="/customLogout">Logout</a>
</body>
</html>
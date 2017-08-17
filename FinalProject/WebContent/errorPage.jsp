<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="menu.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오류 페이지</title>
<style type="text/css">
#errorImg{
	position: fixed;
	left: 15%;
	top: 25%;
}
#homeBtn{
	position: fixed;
	left: 24%;
	top: 40%;
}
</style>
</head>
<body>
<img id="errorImg" src="images/error.gif" alt="에러페이지" >

<button id="homeBtn" class="btn btn-sm btn-info"><a href="index.jsp">홈페이지 가기</a></button>
</body>
</html>
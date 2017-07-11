<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>리스트 도착 </h3><br>
<table>
<tr>
<th>id</th>
<th>name</th>
<th>grade</th>
</tr>
<c:forEach items="${list}" var="member">
<tr>
<td>${member.id}</td>
<td>${member.name}</td>
<td>${member.grade}</td>
</tr>
</c:forEach>
</table>

</body>
</html>
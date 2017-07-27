<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="../menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
.item{
	width: 200px;
	height: 400px;
	position: relative;
	float: left;
	
}

</style>
<body>
<div id="fh5co-main">
	<div class="container">
	

		<h4>찜목록을 보여주자</h4>
		<table>
		<tr>
		<td>카테고리1</td><td>카테고리2</td><td>카테고리3</td><td>어쩌구</td><td>저쩌구</td>
		</tr>
		</table>
		<div class="container">
		<div class="row">

        	<div id="fh5co-board"  class="normal" data-columns>
        	
        		<c:forEach items="${dipsList}" var="dips">
		        	<div class="item">
		        		<div class="animate-box">
			        		<a href="detailOneBoard.do?no=${dips.no}" 
			        		   title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?">
			        		   <img src='<c:url value="/user/board/${dips.no}"/>/${dips.file_name1}' alt="Free HTML5 Bootstrap template"></a>
		        		</div>
		        		<div class="fh5co-desc">${dips.title}</div>
		        	</div>
	        	</c:forEach>
	        	
			</div>
		</div>
		</div>
	</div>
</div>
</body>
</html>
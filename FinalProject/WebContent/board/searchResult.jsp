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
	
		<h4>판매자 검색결과</h4>
		<div class="container">
		<div class="row">
        	<div id="fh5co-board"  class="normal" data-columns>
        	
        		<c:forEach items="${boardSearchList}" var="board">
		        	<div class="item">
		        		<div class="animate-box">
			        		<a href="detailOneBoard.do?no=${board.no}" 
			        		   title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?">
			        		   <img src='<c:url value="/user/board/${board.no}"/>/${board.file_name1}' alt="Free HTML5 Bootstrap template"></a>
		        		</div>
		        		<div class="fh5co-desc">${board.title}</div>
		        	</div>
	        	</c:forEach>
	        	
			</div>
		</div>
		</div>
	

		<h4>제목 + 내용 검색결과</h4>
		<div class="container">
		<div class="row">
        	<div id="fh5co-board"  class="normal" data-columns>
        	
        		<c:forEach items="${boardSearchList}" var="board">
		        	<div class="item">
		        		<div class="animate-box">
			        		<a href="detailOneBoard.do?no=${board.no}" 
			        		   title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?">
			        		   <img src='<c:url value="/user/board/${board.no}"/>/${board.file_name1}' alt="Free HTML5 Bootstrap template"></a>
		        		</div>
		        		<div class="fh5co-desc">${board.title}</div>
		        	</div>
	        	</c:forEach>
	        	
			</div>
		</div>
		</div>
	</div>
</div>
</body>
</html>
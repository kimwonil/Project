<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="fh5co-main">
		<div class="container">

<h3>여기부터 프리미엄</h3>
				<div class="row">
					<div id="fh5co-board" data-columns class="premium">
					
					
						<c:forEach items="${list}" var="item">
						<div class="column size-1of4">
							<div class="item">
								<div class="animate-box">
									<a href="images/img_1.jpg" class="image-popup fh5co-board-img"
										title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img
										src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
								</div>
								<div class="fh5co-desc">${item.title}</div>
							</div>
						
							</div>
						</c:forEach>
						
					</div>
				</div>
			</div>


</body>
</html>
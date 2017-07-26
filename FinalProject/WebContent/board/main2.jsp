<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="../menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <link rel="stylesheet" type="text/css" href="css/slideStyle.css" />
		<script type="text/javascript" src="js/modernizr.custom.04022.js"></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
	.item{
		width: 275px;
		height: 570px;
		position: relative;
		float: left;
		
	}
</style>

<body>
<div id="fh5co-main">
	<div class="container">
	<div>
		<h3>여기부터 프리미엄</h3>
		<div class="row">
			<div id="fh5co-board" data-columns>
			<div class="sp-slideshow">
			<input id="button-1" type="radio" name="radio-set" class="sp-selector-1" checked="checked" />
				<label for="button-1" class="button-label-1"></label>
				
				<input id="button-2" type="radio" name="radio-set" class="sp-selector-2" />
				<label for="button-2" class="button-label-2"></label>
				
				<input id="button-3" type="radio" name="radio-set" class="sp-selector-3" />
				<label for="button-3" class="button-label-3"></label>
				
				<input id="button-4" type="radio" name="radio-set" class="sp-selector-4" />
				<label for="button-4" class="button-label-4"></label>
				
				<input id="button-5" type="radio" name="radio-set" class="sp-selector-5" />
				<label for="button-5" class="button-label-5"></label>
				
				<label for="button-1" class="sp-arrow sp-a1"></label>
				<label for="button-2" class="sp-arrow sp-a2"></label>
				<label for="button-3" class="sp-arrow sp-a3"></label>
				<label for="button-4" class="sp-arrow sp-a4"></label>
				<label for="button-5" class="sp-arrow sp-a5"></label>
				
				<div class="sp-content">
					<div class="sp-parallax-bg"></div>
					<ul class="sp-slider clearfix">
			
				<c:forEach items="${list}" var="item" varStatus="status">
					<c:if test="${status.count%4 eq 1}">
					<li>
					</c:if>
						<div class="column size-1of4">
							<div class="item">
								<div class="animate-box">
									<a href="detailOneBoard.do?no=${item.no}" 
										title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img
										src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
								</div>
								<div class="fh5co-desc">${item.title}</div>
							</div>
						</div>
						<c:if test="${status.count%4 eq 0}">
					</li>
					</c:if>
				</c:forEach>
				</ul>
				</div><!-- sp-content -->
				
			</div><!-- sp-slideshow -->
			</div>
				
			</div>
		</div>
			
			
			
			
		
		
		<h3>이 아래로 일반글</h3>
		<div class="row">

        	<div id="fh5co-board" data-columns>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	
	        	
			</div>
			</div>
		</div>
		
	</div>
</div>
	
	


</body>
</html>
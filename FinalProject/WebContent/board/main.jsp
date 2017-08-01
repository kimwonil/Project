<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="../menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <link rel="stylesheet" type="text/css" href="css/slideStyle.css" />
		<script type="text/javascript" src="js/modernizr.custom.04022.js"></script>
<link rel="stylesheet" href="css/starStyle.css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
	.normal>.item{
		width: 200px;
		height: 300px;
		position: relative;
		float: left;
		
	}
	.fh5co-desc {
		color: #444;
		padding-left: 8px;
		padding-right: 8px;
	}
	.infoTable{
		width: 100%;
	}
	.star-ratings-css{
		font-size: 15px;
	}
	#fh5co-board .item .fh5co-desc{
	padding-left: 13px;
	padding-right: 13px;
	}
	#paddingTop{
	padding-bottom: 0px;
	}
</style>

<script type="text/javascript">
$(document).ready(function(){
	$('#searchInput').on('keydown', function(key){
		if(key.keyCode == 13){
// 			$.ajax({
// 				url : "search.do",
// 				type : "post",
// 				data : {word : $('#searchInput').val()},
// 				success : function(){
// 					alert("성공");
// 				},error : function(){
// 					alert("실패");
// 				}
// 			});//ajax 끝
			
			$('#searchInput').parent().submit();
			
			
			
		};//keyCode == 13일때
	});
	
});
</script>

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
			
				<c:forEach items="${premiumList}" var="premium" varStatus="status">
					<c:if test="${status.count%4 eq 1}">
					<li>
					</c:if>
						<div class="column size-1of4">
							<div class="item">
								<div class="animate-box">
									<a href="detailOneBoard.do?no=${premium.no}" 
										title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?">
									<img src='<c:url value="/user/board/${premium.no}"/>/${premium.file_name1}' alt="Free HTML5 Bootstrap template"></a>
								</div>
								<div class="fh5co-desc" id="paddingTop">${premium.title}</div>
								<div class="fh5co-desc">
									<table class="infoTable">
										<tr>
										<td >${premium.writer }</td>
										<td>
										<div class="star-ratings-css">
										  <div class="star-ratings-css-top" id="starPercent" style="width:${premium.ratingForMain}%"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
										  <div class="star-ratings-css-bottom"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
										</div>
										</td>
										<td>(${premium.num_evaluator })</td>
										</tr>
									</table>
								</div>
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

        	<div id="fh5co-board"  class="normal" data-columns>
        	
        		<c:forEach items="${normalList}" var="normal">
		        	<div class="item">
		        		<div class="animate-box">
			        		<a href="detailOneBoard.do?no=${normal.no}" 
			        		   title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?">
			        		   <img src='<c:url value="/user/board/${normal.no}"/>/${normal.file_name1}' alt="Free HTML5 Bootstrap template"></a>
		        		</div>
		        		<div class="fh5co-desc" id="paddingTop">${normal.title}</div>
		        		<div class="fh5co-desc">
							<table class="infoTable">
								<tr >
								<td>${normal.writer }</td>
								<td>
								<div class="star-ratings-css">
								  <div class="star-ratings-css-top" id="starPercent" style="width:${normal.ratingForMain}%"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
								  <div class="star-ratings-css-bottom"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
								</div>
								</td>
								<td>(${normal.num_evaluator })</td>
								</tr>
							</table>
						</div>
		        	</div>
	        	</c:forEach>
	        	
			</div>
			</div>
			
			<div>
				<div class="fh5co-spacer fh5co-spacer-sm"></div>
<!-- 				페이징 -->
				<div>
				<center>
					<c:if test="${paging.currentPage > 1}">
						<a href="load.do?currentPage=1">[처음]</a>
						<a href="load.do?currentPage=${paging.currentPage-1}">[이전]</a>
					</c:if>
					
					<c:forEach begin="${paging.startPage }" end="${paging.endPage>paging.lastPage? paging.lastPage:paging.endPage }" var="i">
						<c:if test="${i eq paging.currentPage}">
							<b>${i }</b>
						</c:if>
						<c:if test="${i ne paging.currentPage }">
							<a href="load.do?currentPage=${i}">[${i}]</a>
						</c:if>
					</c:forEach>
					
					<c:if test="${paging.currentPage != paging.lastPage && paging.endPage ne 0}">
						<a href="load.do?currentPage=${paging.currentPage+1 }">[다음]</a>
						<a href="load.do?currentPage=${paging.lastPage }">[마지막]</a>
					</c:if>
				</center>
				</div>
<!-- 				페이징 끝 -->
					
				<div class="fh5co-spacer fh5co-spacer-sm"></div>
			</div>
		</div>
		
	</div>
	
	


</body>
</html>
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
/* slide관련 */
.sp-slideshow{
	width: 100%;
}
/* slide관련 끝 */
.normal>.item{
	width: 200px;
	height: 350px;
	position: relative;
	float: left;
}
/* .normal>.item{ */
/* 	height: 200px; */
/* } */
.row{
	margin: 0px auto;
}
.fh5co-desc {
	color: #444;
	padding-left: 8px;
	padding-right: 8px;
	width: 100%;
}
.infoTable{
	width: 100%;
}
.star-ratings-css{
	font-size: 15px;
	text-align: right;
}
.star-ratings-css-bottom{
	float: left;
}
#fh5co-board .item .fh5co-desc{
	padding-left: 13px;
	padding-right: 13px;
}
#fh5co-board .item .fh5co-desc {
	padding-top: 10px;
	padding-bottom: 10px;
}
.writer{
	overflow: hidden; 
	text-overflow: ellipsis;
	white-space: nowrap; 
	width: 65px;
	height: 20px;
	display: block;
}

.price{
	height: 45px;
	font-size: 1.4em;
	color: #ff0000;
	font-weight: bolder;
	text-align: left;
}
.read_count{
	text-align : right;
	padding-right : 3px;
	font-size : 13px;
}
.titleHeight{
	height: 60px;
	text-align: left;
}
#fh5co-board .item{
	margin: 14px;
}
img{
	width: 200px;
	height: 200px;
}
#fh5co-board .item img{
	width: 200px;
	height: 200px;
	padding: 0px;
}
#orderTable{
	height: 40px;
	float: right;
	
}
#orderTable div{
	background-color: white;
	line-height: 40px;
	height: 40px;
}
h3{
display: inline;
}
.rowClear{
	clear: both;
}
</style>

<body>
<div id="fh5co-main">
	<div class="container">
	<div>
		<h3>프리미엄</h3>
		<div class="row">
			<div id="fh5co-board" class="premium" data-columns>
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
									<a href="detailOneBoard.do?no=${premium.no}">
									<c:choose>
										<c:when test="${premium.file_name1 eq ''}">
											<img src='<c:url value="/user/board/nothumbnail"/>/noimage.jpg' >
										</c:when>
										<c:when test="${premium.file_name1 eq null}">
											<img src='<c:url value="/user/board/nothumbnail"/>/noimage.jpg' >
										</c:when>
										<c:otherwise >
											<img src='<c:url value="/user/board/${premium.no}"/>/${premium.file_name1}' >
										</c:otherwise>
									</c:choose>
									</a>
								</div>
								<div class="fh5co-desc">
									<table class="infoTable">
										<tr>
											<td colspan="4" class="titleHeight">${premium.title}</td>
										</tr>
										
										<tr>
											<td colspan="3" width="90%" height="20%" class="price">${premium.price}</td>
											<td width="10%" class="read_count">조회수${premium.read_count}회</td>
										</tr>
										
										<tr>
											<td id="writer" colspan="2" width="60%" class="writer">${premium.writer }</td>
											<td colspan="3" width="40%">
												<div class="star-ratings-css">
												  <div class="star-ratings-css-top starPercent" style="width:${premium.ratingForMain}%"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
												  <div class="star-ratings-css-bottom"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
												  <div>(${premium.num_evaluator})</div>
												</div>
											</td>
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
			
		<div class="fh5co-spacer fh5co-spacer-sm"></div>
			
		<h3>일반글</h3>
		<span>
			<table id="orderTable">
			<tr>
			<td><button onclick="location.href='latest.do'" class="btn-sm">최신순</button></td>
			<td><button onclick="location.href='panmaesun.do'" class="btn-sm">판매순</button></td>
			<td><button onclick="location.href='gageocksun.do'" class="btn-sm">낮은가격순</button></td>
			</tr>
			</table>
		</span>
		<div class="row rowClear">

        	<div id="fh5co-board"  class="normal" data-columns>
        	
        		<c:forEach items="${normalList}" var="normal">
		        	<div class="item">
		        		<div class="animate-box">
			        		<a href="detailOneBoard.do?no=${normal.no}">
									
								<c:choose>
								<c:when test="${normal.file_name1 eq ''}">
									<img src='<c:url value="/user/board/nothumbnail"/>/noimage.jpg' >
								</c:when>
								<c:when test="${normal.file_name1 eq null}">
									<img src='<c:url value="/user/board/nothumbnail"/>/noimage.jpg' >
								</c:when>
								<c:otherwise >
									<img src='<c:url value="/user/board/${normal.no}"/>/${normal.file_name1}' >
								</c:otherwise>
								</c:choose>
		        		   
			        		   </a>
		        				
		        		</div>
		        		<div class="fh5co-desc">
							<table class="infoTable">
								<tr>
									<td colspan="4" class="titleHeight">${normal.title}</td>
								</tr>
								
								<tr>
									<td colspan="3" width="90%" height="20%" class="price">${normal.price}</td>
									<td width="10%" class="read_count">조회수${normal.read_count}회</td>
								</tr>
								
								<tr>
									<td class="writer" colspan="2" width="60%">${normal.writer }</td>
									<td colspan="3" width="40%">
										<div class="star-ratings-css">
										  <div class="star-ratings-css-top starPercent" style="width:${normal.ratingForMain}%"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
										  <div class="star-ratings-css-bottom"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
										  <div>(${normal.num_evaluator})</div>
										</div>
									</td>
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
						<a href="${pageName}?currentPage=1">[처음]</a>
						<a href="${pageName}?currentPage=${paging.currentPage-1}">[이전]</a>
					</c:if>
					
					<c:forEach begin="${paging.startPage }" end="${paging.endPage>paging.lastPage? paging.lastPage:paging.endPage }" var="i">
						<c:if test="${i eq paging.currentPage}">
							<b>${i }</b>
						</c:if>
						<c:if test="${i ne paging.currentPage }">
							<a href="${pageName}?currentPage=${i}">[${i}]</a>
						</c:if>
					</c:forEach>
					
					<c:if test="${paging.currentPage != paging.lastPage && paging.endPage ne 0}">
						<a href="${pageName}?currentPage=${paging.currentPage+1 }">[다음]</a>
						<a href="${pageName}?currentPage=${paging.lastPage }">[마지막]</a>
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
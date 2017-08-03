<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="../menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/starStyle.css">
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
h3{
text-align: center;
}
</style>
<body>
<input type="hidden" id="hiddenMajor" value="${major}">
<div id="fh5co-main">
	<div class="container">
		<h4>검색결과</h4>
			<div class="row">
	        	<div id="fh5co-board"  class="normal" data-columns>
	        	
        			<c:if test="${boardSearchList eq '[]'}">
		        	<h3>검색결과가 없습니다</h3>
		        	</c:if>
	        	
<!-- 	        		검색결과 글 뿌리기 -->
	        		<c:forEach items="${boardSearchList}" var="board">
	        			
	        		
	        		
			        	<div class="item">
			        		<div class="animate-box">
				        		<a href="detailOneBoard.do?no=${board.no}">
				        			<c:choose>
										<c:when test="${board.file_name1 eq ''}">
											<img src='<c:url value="/user/board/nothumbnail"/>/noimage.jpg' >
										</c:when>
										<c:when test="${board.file_name1 eq null}">
											<img src='<c:url value="/user/board/nothumbnail"/>/noimage.jpg' >
										</c:when>
										<c:otherwise >
											<img src='<c:url value="/user/board/${board.no}"/>/${board.file_name1}' >
										</c:otherwise>
									</c:choose>
				        		 </a>
			        				
			        		</div>
			        		<div class="fh5co-desc">
								<table class="infoTable">
									<tr>
										<td colspan="4" class="titleHeight">${board.title}</td>
									</tr>
									
									<tr>
										<td colspan="3" width="90%" height="20%" class="price">${board.price}</td>
										<td width="10%" class="read_count">조회수${board.read_count}회</td>
									</tr>
									
									<tr>
										<td class="writer" colspan="2" width="60%">${board.writer }</td>
										<td colspan="3" width="40%">
											<div class="star-ratings-css">
											  <div class="star-ratings-css-top starPercent" style="width:${board.ratingForMain}%"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
											  <div class="star-ratings-css-bottom"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
											  <div>(${board.num_evaluator})</div>
											</div>
										</td>
									</tr>
								</table>
							</div>
			        	</div>
		        	</c:forEach>
<!-- 		        	검색결과 글뿌리기 끝 -->
		        	
				</div>
			</div>
		
		<div>
				<div class="fh5co-spacer fh5co-spacer-sm"></div>
<!-- 				페이징 -->
				<div>
				<center>
					<c:if test="${paging.currentPage > 1}">
						<a href="${pageName}?currentPage=1&word=${word}&major=${major}">[처음]</a>
						<a href="${pageName}?currentPage=${paging.currentPage-1}&word=${word}&major=${major}">[이전]</a>
					</c:if>
					
					<c:forEach begin="${paging.startPage }" end="${paging.endPage>paging.lastPage? paging.lastPage:paging.endPage }" var="i">
						<c:if test="${i eq paging.currentPage}">
							<b>${i }</b>
						</c:if>
						<c:if test="${i ne paging.currentPage }">
							<a href="${pageName}?currentPage=${i}&word=${word}&major=${major}">[${i}]</a>
						</c:if>
					</c:forEach>
					
					<c:if test="${paging.currentPage != paging.lastPage && paging.endPage ne 0}">
						<a href="${pageName}?currentPage=${paging.currentPage+1}&word=${word}&major=${major}">[다음]</a>
						<a href="${pageName}?currentPage=${paging.lastPage }&word=${word}&major=${major}">[마지막]</a>
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



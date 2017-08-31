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
	height: 350px;
	position: relative;
	float: left;
}
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
	width: 91%;
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
.item img{
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
#orderTable{
width: 220px;
}
.titlecut{
	overflow: hidden; 
	text-overflow: ellipsis;
	white-space: nowrap; 
	display:block;
	width: 170px;
	height: 20px;
}

.item{
	background-color: white;
	width: 200px;
}
/* ////////////////////////////////////////////////// */


/* Slideshow container */
.slideshow-container {
  max-width: 1140px;
  position: relative;
  margin: auto;
}



/* The dots/bullets/indicators */
.dot, .noticeDot {
  height: 13px;
  width: 13px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 2s ease;
}
.noticeDot{
	display: none;
}

.active {
  background-color: #717171;
}

.notice-container{
	width:1100px;
	overflow: hidden;
	font-size: 20px;
}

.noticeLink{
	cursor: pointer;
}
#noticeContent{
	resize:none;
}

/* Fading animation */
.fadeitem {
  -webkit-animation-name: fadeitem;
  -webkit-animation-duration: 5s;
  animation-name: fadeitem;
  animation-duration: 5s;
}

.noticefade {
  position:relative;
  -webkit-animation-name: noticefade;
  -webkit-animation-duration: 5s;
  animation-name: noticefade;
  animation-duration: 5s;
}

@-webkit-keyframes noticefade {
  0% {top:40px;opacity: .5}
  50% {top:0px;opacity: 1}
  100%  {top:-40px;opacity: .5}
}

@keyframes noticefade {
  0% {top:40px;opacity: .5}
  50% {top:0px;opacity: 1}
  100%  {top:-40px;opacity: .5}
}


@-webkit-keyframes fadeitem {
  from {opacity: .8} 
  to {opacity: 1}
}

@keyframes fadeitem {
  from {opacity: .8} 
  to {opacity: 1}
}


/* //////////////////////////////////////////////////// */

</style>

<script type="text/javascript">

$(document).ready(function(){
	var category = $('#currentMajor').val();
	if(category != ''){
		$.ajax({
			url:"currentCategoryName.do",
			type:"POST",
			data:{
				currentMajor:$('#currentMajor').val(),
				currentMinor:$('#currentMinor').val()
			},
			dataType:"text",
			success:function(data){
				$('#currentCategoryName').text(data);
			},
			error:function(){
				alert("카테고리 실패");
			}
		});
	}
	
	
});


$(document).on('click', '#latest', function(){
	location.href='latest.do';
});
$(document).on('click', '#panmaesun', function(){
	location.href='panmaesun.do';
});
$(document).on('click', '#gageocksun', function(){
	location.href='gageocksun.do';
});

$(document).on('click', '.noticeLink', function(){
	var noticeNo = $(this).siblings('input').val();
	$.ajax({
		url:"mainNotice.do",
		type:"POST",
		data:{
			no : noticeNo
		},
		dataType:"json",
		success:function(data){
			$('#noticeTitle').text(data.title);
			$('#noticeWriter').text(data.writer);
			$('#noticeContent').val(data.content);
			$("#noticeModal").modal({backdrop: false});
		},
		error:function(){
			alert("실패");
		}
	});
});

</script>

<body>

<!-- ////////////////////////////////////////////////////////////////// -->
<div id="fh5co-main">
	<div class="container">
	<div> 
		<h3>공지사항</h3>  
		<p> 
		<div class="slideshow-container notice-container">
			<c:forEach items="${noticeList}" var="notice">
				<div class="noticeSlides noticefade">
					<a class="noticeLink">${notice.title}</a>
					<input type="hidden" value="${notice.no}">
				</div>
			</c:forEach>	
		</div>
		<div style="text-align:center">
			<c:forEach items="${noticeList}" var="notice">
					<span class="noticeDot"></span>
			</c:forEach>
		</div>
	</div>
	</div>
</div>
<!-- ///////////////////////////////////////////////////////////////// -->
<div id="fh5co-main">
	<div class="container">
	<div>
		<h3>프리미엄</h3>
		<div>&nbsp;</div>
		<div class="row">
	<div class="slideshow-container" >
		<c:forEach items="${premiumList}" var="premium" varStatus="status">
			<c:if test="${status.count%5 eq 1}">
				<div class="mySlides fadeitem">
			</c:if>
	
						<div class="column size-1of4">
							<div class="item">
								<div class="animate-box">
									<a href="detailOneBoard.do?no=${premium.no}">
									<c:choose>
										<c:when test="${premium.file_name1 eq ''}">
											<img src='<c:url value="/images"/>/noimage.jpg' >
										</c:when>
										<c:when test="${premium.file_name1 eq null}">
											<img src='<c:url value="/images"/>/noimage.jpg' >
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
											<td colspan="4" class="titleHeight"><span class="titlecut">${premium.title}</span></td>
										</tr>
										
										<tr>
											<td colspan="3" width="90%" height="20%" class="price"><fmt:formatNumber value="${premium.price}" groupingUsed="true"/></td>
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
					<c:if test="${status.count%5 eq 0}">
						</div>
					</c:if>
		</c:forEach>
	</div>
<div class="fh5co-spacer fh5co-spacer-lg"></div>
<div style="text-align:center">
<c:forEach items="${premiumList}" var="premium" varStatus="status">
	<c:if test="${status.count%5 eq 1}">
	  <span class="dot"></span>
	</c:if>
</c:forEach>
</div>
</div>
</div>

<script>
var slideIndex = 0;
var noticeIndex = 0;

showSlides();
function showSlides() {
    var i;
    var slides = document.getElementsByClassName("mySlides");
    var dots = document.getElementsByClassName("dot");
    
    for (i = 0; i < slides.length; i++) {
       slides[i].style.display = "none";  
    }
    slideIndex++;
    if (slideIndex> slides.length) {slideIndex = 1} 
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }
    slides[slideIndex-1].style.display = "block";  
    dots[slideIndex-1].className += " active";
    setTimeout(showSlides, 5000); // Change image every 2 seconds
}

noticeSlides();
function noticeSlides() {
    var i;
    var slides2 = document.getElementsByClassName("noticeSlides");
    var dots2 = document.getElementsByClassName("noticeDot");
    for (i = 0; i < slides2.length; i++) {
       slides2[i].style.display = "none";  
    }
    noticeIndex++;
    if (noticeIndex> slides2.length) {noticeIndex = 1}    
    for (i = 0; i < dots2.length; i++) {
        dots2[i].className = dots2[i].className.replace(" active", "");
    }
    slides2[noticeIndex-1].style.display = "block";  
    dots2[noticeIndex-1].className += " active";
    setTimeout(noticeSlides, 3000); // Change image every 2 seconds
}




</script>

<!-- ///////////////////////////////////////////////////////////////// -->



			
		<div class="fh5co-spacer fh5co-spacer-sm"></div>
			
		<input type="hidden" id="currentMajor" name="currentMajor" value="${currentMajor}">
		<input type="hidden" id="currentMinor" name="currentMinor" value="${currentMinor}">	
		<h3>일반글</h3>&nbsp;&nbsp;&nbsp;&nbsp;<label id="currentCategoryName"></label>
		
		<span>
			<table id="orderTable">
			<tr>
			<td><button id="latest" class="btn-sm btn-primary">최신순</button></td>
			<td><button id="panmaesun" class="btn-sm btn-primary">판매순</button></td>
			<td><button id="gageocksun" class="btn-sm btn-primary">낮은가격순</button></td>
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
									<img src='<c:url value="/images"/>/noimage.jpg' >
								</c:when>
								<c:when test="${normal.file_name1 eq null}">
									<img src='<c:url value="/images"/>/noimage.jpg' >
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
									<td colspan="4" class="titleHeight"><span class="titlecut">${normal.title}</span></td>
								</tr>
								
								<tr>
									<td colspan="3" class="price"><fmt:formatNumber value="${normal.price}"/></td>
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
					
<%-- 					<c:if test="${paging.currentPage != paging.lastPage && paging.endPage ne 0}"> --%>
					<c:if test="${paging.currentPage < paging.lastPage}">
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
	
	
	
	
	<!-- Modal -->
  <div class="modal fade" id="noticeModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">공지사항</h4>
        </div>
        <div class="modal-body">
          <table>
          	<tr>
          		<td width="10%">제&nbsp;&nbsp;&nbsp;&nbsp;목 :</td>
          		<td width="90%"><label id="noticeTitle"></label></td>
          	</tr>
          	<tr>
          		<td>작성자 :</td>
          		<td><label id="noticeWriter"></label></td>
          	</tr>
          	<tr>
          		<td colspan="2"> <textarea id="noticeContent" cols="78" rows="10"></textarea></td>
          	</tr>
          </table>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-info btn-sm" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
	
</body>
</html>
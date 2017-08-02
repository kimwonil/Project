<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="../menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/starStyle.css">
<title>Insert title here</title>
<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"64087",secure:"64096"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>
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
</style>
<body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-6" data-genuitec-path="/FinalProject/WebContent/board/searchResult.jsp">
<div id="fh5co-main" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-6" data-genuitec-path="/FinalProject/WebContent/board/searchResult.jsp">
	<div class="container">
		<h4>검색결과</h4>
		<div class="container">
			<div class="row">
	        	<div id="fh5co-board"  class="normal" data-columns>
	        		<c:forEach items="${boardSearchList}" var="board">
			        	<div class="item">
			        		<div class="animate-box">
				        		<a href="detailOneBoard.do?no=${board.no}">
				        		   <c:if test="${board.file_name1 eq null}">
										<img src='<c:url value="/user/board/nothumbnail"/>/noimage.jpg' >
									</c:if>
									<c:if test="${board.file_name1 ne null}">
									<img src='<c:url value="/user/board/${board.no}"/>/${board.file_name1}' >
									</c:if>
			        		   
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
		        	
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>



<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="../menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"64087",secure:"64096"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>
<style>
.item{
	width: 200px;
	height: 400px;
	position: relative;
	float: left;
	
}

</style>
<body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-3" data-genuitec-path="/FinalProject/WebContent/board/dipsList.jsp">
<div id="fh5co-main" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-3" data-genuitec-path="/FinalProject/WebContent/board/dipsList.jsp">
	<div class="container">
	

		<h4>찜목록을 보여주자</h4>
		<table border="1">
		<tr>
		<c:forEach items="${category}" var="major">
		<td height="50px"><a href="dipsCategory.do?category_no=${major.no}"><div style="line-height: 50px">${major.category_name}</div></a></td>
		</c:forEach>
		</tr>
		</table>
		<div class="container">
		<div class="row">

        	<div id="fh5co-board"  class="normal" data-columns>
        	
        		<c:forEach items="${dipsList}" var="board">
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
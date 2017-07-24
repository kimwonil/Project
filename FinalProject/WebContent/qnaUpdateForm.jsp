<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="menu.jsp" %>
    <%@ include file="miniProfile.jsp"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=A5owm24oXM2NprihulHy&submodules=geocoder"></script>

</head>
<style>

#bckground{
width: 655px;
text-align: right;
}

#mapContent{
position: absolute;
display : none;
right: 15%;
top: 10%;
border: 1px solid red;
}
</style>

<script type="text/javascript">

    

	
	
});//document.ready
</script>



<body>
	
	<!-- 	<div id="fh5co-main"> -->
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<h2>질문 수정</h2>
					<div class="fh5co-spacer fh5co-spacer-sm"></div>
					<div class="row">
						
						<div class="col-md-4">
							<div class="fh5co-pricing-table" id="bckground">
							<form id="detailInfo" action="QnAUpdate.do" method="post">
								<table class="table">
									<tr><th>카테고리 </th><th>
									<select name="major">
									<option>대분류</option>
									<option value="1" <c:if test="${qna.category_no/10 < 2}">selected</c:if>>카테고리1</option>
									<option value="2" <c:if test="${qna.category_no/10>= 2 && qna.category_no/10 < 3}">selected</c:if>>카테고리2</option>
									<option value="3" <c:if test="${qna.category_no/10>= 3}">selected</c:if>>카테고리3</option>
									</select> 
									<select name="minor">
									<option>소분류</option>
									<option value="1" <c:if test="${qna.category_no%10== 1}">selected</c:if>>카테고리1</option>
									<option value="2" <c:if test="${qna.category_no%10== 2}">selected</c:if>>카테고리2</option>
									<option value="3" <c:if test="${qna.category_no%10== 3}">selected</c:if>>카테고리3</option>
									</select>
									</th></tr>
									<tr><th>글제목</th><th> <input type="text" name="title" value="${qna.title }"> </th></tr>	
									<tr><th>상세내용</th><th> <textarea rows="10" cols="50" name="content">${qna.content }</textarea> </th></tr>
									<input type="hidden" name="no" value="${qna.no }">
								</table>
								<div class="fh5co-spacer fh5co-spacer-sm"></div>
								<input type="submit" class="btn btn-sm btn-primary" id="go" value="수정">
								<input type="button" class="btn btn-sm btn-primary" value="돌아가기" onclick="location.href='qnaContent.do?no=${qna.no }'">
							</form>
							</div>
						</div>
					
					</div>

					
				</div>
        	</div>
       </div>


</body>
</html>
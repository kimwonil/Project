<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="menu.jsp"%>
<%@ include file="miniProfile.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		$("#tabs").tabs();
	});
</script>
<style type="text/css">

#tabs tr,#tabs td,#tabs th{
border: 1px solid black;
}

</style>
</head>
<body>

	<div id="fh5co-main">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<h2>판매관리</h2>
					<div id="tabs">
						<ul>
							<li><a href="#tabs-1">등록한 재능글</a></li>
							<li><a href="#tabs-2">진행중 거래</a></li>
							<li><a href="#tabs-3">완료된 거래</a></li>
							<li><a href="#tabs-4">취소된 거래</a></li>
						</ul>
						<div id="tabs-1" >
							<table>
								<tr><th>등록일</th><th>글제목</th><th>구매자</th><th>가격(수량)</th><th>진행상황</th><th>비고</th></tr>
								<tr><td>2017.07.07</td><td>칼 갈아드립니다</td><td>칼갈이</td><td>3000/1</td><td>진행중</td><td>버튼만들어야해</td></tr>
							</table>
						</div>
						<div id="tabs-2">
							<table>
								<tr><th>등록일</th><th>글제목</th><th>구매자</th><th>가격(수량)</th><th>진행상황</th><th>비고</th></tr>
								<tr><td>2017.07.07</td><td>칼 갈아드립니다</td><td>칼갈이</td><td>3000/1</td><td>진행중</td><td>버튼만들어야해</td></tr>
							</table>
						</div>
						<div id="tabs-3">
							<table>
								<tr><th>등록일</th><th>글제목</th><th>구매자</th><th>가격(수량)</th><th>진행상황</th><th>비고</th></tr>
								<tr><td>2017.07.07</td><td>칼 갈아드립니다</td><td>칼갈이</td><td>3000/1</td><td>진행중</td><td>버튼만들어야해</td></tr>
							</table>
						</div>
						<div id="tabs-4">
							<table>
								<tr><th>등록일</th><th>글제목</th><th>구매자</th><th>가격(수량)</th><th>진행상황</th><th>비고</th></tr>
								<tr><td>2017.07.07</td><td>칼 갈아드립니다</td><td>칼갈이</td><td>3000/1</td><td>진행중</td><td>버튼만들어야해</td></tr>
							</table>
						</div>
						<div class="form-group">
							<form action="boardForm.jsp">
								<input type="submit" class="btn btn-primary" value="글 작성하기" style="width: 120px; height: 40px;">
							</form>
						</div>
					</div>
					

					
				</div>
			</div>
		</div>
	</div>
</body>
</html>
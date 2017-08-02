<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="menu.jsp"%>
<%@ include file="miniProfile.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
			<h2>고객센터</h2>
					<div id="tabs">
						<ul>
							<li><a href="#tabs-1">공지사항</a></li>
							<li><a href="#tabs-2">Q&A</a></li>
							<li><a href="#tabs-3">1:1문의</a></li>
							<li><a href="#tabs-4">신고하기</a></li>
						</ul>	
						
							<div id="tabs-1">
								<table id="noticeList">
									<tr>
										<td width="20%">등록일</td>
										<td width="50%">글제목</td>
										<td width="20%">작성자</td>
										<td width="15%">조회수</td>
									</tr>
									
									<tr>
										<td>2017-07-13</td>
										<td>공지사항 글제목</td>
										<td>운영자</td>
										<td>조회수(예정)</td>
									</tr>
							
								</table>
									<button type="button" id="writeNotice" class="btn btn-writeN" data-toggle="modal"
										data-target="#refillModal">공지사항 작성</button>
								
							</div>						
							
						<div id="tabs-2">
								<table id="qnaList">
									<tr>
										<td width="20%">등록일</td>
										<td width="20%">분류</td>
										<td width="40%">글제목</td>
										<td width="20%">답변상태</td>
										<td width="20%">조회수</td>
									</tr>
								<tr>
									<td>2017-07-13</td>
									<td>카테고리 공간</td>
									<td>QNA 질문글 제목</td>
									<td>미답변</td>
									<td>123456</td>
							</tr>
								</table>
									<button type="button" id="writeQnA" class="btn btn-writeQ" data-toggle="modal"
										data-target="#refillModal">Q&A 작성</button>

						</div>
						
						<div id="tabs-3">
								<table id="onenoneList">
									<tr>
										<td width="20%">등록일</td>
										<td width="20%">분류</td>
										<td width="40%">글제목</td>
										<td width="20%">답변상태</td>
										<td width="20%">조회수</td>
									</tr>
								<tr>
									<td>2017-07-13</td>
									<td>카테고리 공간</td>
									<td>1:1문의글 제목</td>
									<td>미답변</td>
									<td>123456</td>
							</tr>
								</table>
									<button type="button" id="writeOnenone" class="btn btn-writeO" data-toggle="modal"
										data-target="#refillModal">1:1문의 작성</button>

						</div>				
												
						<div id="tabs-4">
								<table id="reportList">
									<tr>
										<td width="20%">등록일</td>
										<td width="20%">분류</td>
										<td width="40%">글제목</td>
										<td width="20%">처리상태</td>
										<td width="20%">조회수</td>
									</tr>
								<tr>
									<td>2017-07-13</td>
									<td>카테고리 공간</td>
									<td>신고글 제목</td>
									<td>미답변</td>
									<td>123456</td>
							</tr>
								</table>
									<button type="button" id="writeReport" class="btn btn-writeR" data-toggle="modal"
										data-target="#refillModal">신고 접수하기</button>

						</div>
												
						
						
					</div>





	</div>
	</div>
	</div>
</div>


</body>
</html>
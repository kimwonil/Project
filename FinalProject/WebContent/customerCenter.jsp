<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
#tabs tr, #tabs td, #tabs th {
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
							<li><a href="#tabs-2">Q & A</a></li>
							<li><a href="#tabs-3">신 고</a></li>

						</ul>
						<div align="center">
							<select>
								<option>검색조건</option>
								<option>닉네임</option>
								<option>글제목</option>
								<option>날짜</option>
							</select> <input type="text">
							<button>검색</button>
						</div>
						<div class="fh5co-spacer fh5co-spacer-sm"></div>
						<div id="tabs-1">
							<table style="width: 100%;">
								<tr>
									<th>등록일</th>
									<th>글번호</th>
									<th>분류</th>
									<th>글제목</th>
									<th>작성자</th>
									<th>조회수</th>

								</tr>
								<c:forEach var="notice" items="${ noticeList }">
									<tr>
										<td><fmt:formatDate value="${notice.date }"
												pattern="yyyy-MM-dd" /></td>
										<td>${notice.no }</td>
										<td>${notice.category_no }</td>
										<td><a href="NoticeContent.do?no=${notice.no }">${notice.title }</a></td>
										<td>${notice.writer }</td>
										<td>${notice.read_count }</td>
									</tr>
								</c:forEach>

							</table>
							<c:choose>

								<c:when test="${member.admin==1}">
									<br>
									<div class="form-group" style="text-align: right;">
										<form action="noticeForm.jsp">
											<input type="submit" class="btn btn-primary btn-sm"
												value="공지사항등록" style="width: 145px; height: 40px;">
										</form>
									</div>
								</c:when>
							</c:choose>
						</div>
						<div id="tabs-2">
							<table style="width: 100%;">
								<tr>
									<th>등록일</th>
									<th>글번호</th>
									<th>분류</th>
									<th>글제목</th>
									<th>작성자</th>
									<th>답변상태</th>
									<th>조회수</th>

								</tr>
								<c:forEach var="qna" items="${ qnaList }">
									<tr>
										<td><fmt:formatDate value="${qna.date }"
												pattern="yyyy-MM-dd" /></td>
										<td>${qna.no }</td>
										<td>${qna.category_no }</td>
										<td>
										<c:choose>
										<c:when test="${qna.open==0}">
										<a href="qnaContent.do?no=${qna.no }">${qna.title }</a>
										</c:when>
										<c:when test="${qna.open==1}">
											<c:choose>
												<c:when test="${member.admin==1 }">
												<a href="qnaContent.do?no=${qna.no }">비공개</a>
												</c:when>
												<c:when test="${member.id==qna.writer }">
												<a href="qnaContent.do?no=${qna.no }">비공개</a>
												</c:when>
												<c:otherwise>
												비공개
												</c:otherwise>
											</c:choose>
										</c:when>
										</c:choose>
										</td>
										<td><c:choose><c:when test="${qna.open==0}">${qna.writer }</c:when><c:when test="${qna.open==1}">비공개</c:when></c:choose></td>
										<td><c:choose><c:when test="${qna.state==0}">미답변</c:when><c:when test="${qna.state==1}">답변완료</c:when></c:choose></td>
										<td>${qna.read_count }</td>
									</tr>
								</c:forEach>

							</table>
							<br>
							<div class="form-group" style="text-align: right;">
								<button type="button" class="btn btn-info btn-lg"
									data-toggle="modal" data-target="#myModal">Q & A 등록</button>
							</div>
							<!-- Modal -->
							<div class="modal fade" id="myModal" role="dialog">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">Q & A 등록</h4>
										</div>
										<div class="modal-body">


										
													<form id="detailInfo" action="insertQuestion.do"
														method="post">
														<table class="table">
															<tr>
																<th>카테고리</th>
																<th><select name="major"><option>대분류</option>
																		<option value="1">카테고리1</option>
																		<option value="2">카테고리2</option>
																		<option value="3">카테고리3</option></select> 
																		<select name="minor"><option>소분류</option>
																		<option value="1">카테고리1</option>
																		<option value="2">카테고리2</option>
																		<option value="3">카테고리3</option></select></th>
															</tr>
															<tr>
																<th>질문 제목</th>
																<th><input type="text" name="title"></th>
															</tr>
															<tr>
																<th>질문 내용</th>
																<th><textarea rows="10" cols="50" name="content"></textarea>
																</th>
															</tr>
															<tr>															
																<th>공개/비공개</th>
																<th>
																<input type="checkbox" name="open" value="0">공개
																<input type="checkbox" name="open" value="1">비공개
																</th>
															</tr>
														</table>
														<div class="fh5co-spacer fh5co-spacer-sm"></div>
														<input type="submit" class="btn btn-sm btn-primary"
															id="go" value="질문하기">
														<button type="button" class="btn btn-primary btn-sm"
															data-dismiss="modal">취소하기</button>
													</form>
											



										</div>

									</div>
								</div>
							</div>
						</div>
						<div id="tabs-3">
							<table style="width: 100%;">
								<tr>
									<th>등록일</th>
									<th>글번호</th>
									<th>분류</th>
									<th>글제목</th>
									<th>작성자</th>
									<th>처리상태</th>
									<th>조회수</th>
								</tr>
								<c:forEach var="report" items="${ reportList }">
									<tr>
										<td><fmt:formatDate value="${report.date }"
												pattern="yyyy-MM-dd" /></td>
										<td>${report.no }</td>
										<td>${report.category_no }</td>
										<td><a href="ReportContent.do?no=${report.no }">${report.title }</a></td>
										<td>${report.writer }</td>
										<td><c:choose><c:when test="${report.state==0}">미처리</c:when><c:when test="${report.state==1}">처리완료</c:when></c:choose></td>
										<td>${report.read_count }</td>
									</tr>
								</c:forEach>
							</table>
														<br>
							<div class="form-group" style="text-align: right;">
								<button type="button" class="btn btn-info btn-lg"
									data-toggle="modal" data-target="#myModal2">신고 등록</button>
							</div>
							<!-- Modal -->
							<div class="modal fade" id="myModal2" role="dialog">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">신고 등록</h4>
										</div>
										<div class="modal-body">


										
													<form id="detailInfo" action="insertReport.do"
														method="post">
														<table class="table">
															<tr>
																<th>카테고리</th>
																<th><select name="major"><option>대분류</option>
																		<option value="1">카테고리1</option>
																		<option value="2">카테고리2</option>
																		<option value="3">카테고리3</option></select> 
																		<select name="minor"><option>소분류</option>
																		<option value="1">카테고리1</option>
																		<option value="2">카테고리2</option>
																		<option value="3">카테고리3</option></select></th>
															</tr>
															<tr>
																<th>신고 제목</th>
																<th><input type="text" name="title"></th>
															</tr>
															<tr>
																<th>신고 내용</th>
																<th><textarea rows="10" cols="50" name="content"></textarea>
																</th>
															</tr>
																
														</table>
														<div class="fh5co-spacer fh5co-spacer-sm"></div>
														<input type="submit" class="btn btn-sm btn-primary"
															id="go" value="신고하기">
														<button type="button" class="btn btn-primary btn-sm"
															data-dismiss="modal">취소하기</button>
													</form>
											



										</div>

									</div>
								</div>
							</div>
						</div>


						<div class="fh5co-spacer fh5co-spacer-sm"></div>

						<%-- 						<c:choose> --%>
						<%-- 							<c:when test="${member.admin==1}"> --%>
						<!-- 								<div class="form-group" style="text-align: right;"> -->
						<!-- 									<form action="noticeForm.jsp"> -->
						<!-- 										<input type="submit" class="btn btn-primary btn-sm" -->
						<!-- 											value="공지사항등록" style="width: 145px; height: 40px;"> -->
						<!-- 									</form> -->
						<!-- 								</div> -->
						<%-- 							</c:when> --%>
						<%-- 						</c:choose> --%>

					</div>



				</div>
			</div>
		</div>
	</div>
</body>
</html>
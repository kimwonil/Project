<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="menu.jsp"%>
<%@ include file="miniProfile.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<h2>질문 상세</h2>
					<div class="fh5co-spacer fh5co-spacer-sm"></div>
						<div class="row">

							<div class="col-md-4">
								<div class="form-group">
									<input type="text" class="form-control"
										value="글번호 : ${qna.no }" readonly>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<textarea name="date" id="date" cols="10" class="form-control"
										rows="1" readonly>등록일 : <fmt:formatDate
											value="${qna.date }" pattern="yyyy-MM-dd" /></textarea>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<input type="text" class="form-control"
										value="작성자 : ${qna.writer }" readonly>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<input type="text" class="form-control" value="질문 제목 : ${qna.title }"
										readonly>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<textarea name="content" id="content" cols="30"
										class="form-control" rows="5" readonly>질문 내용 : ${qna.content }</textarea>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<textarea name="content" id="content" cols="30"
										class="form-control" rows="5" readonly>답변 : ${answer.content }</textarea>
								</div>
							</div>
							<c:choose>
								<c:when test="${member.admin==1}">
									<div class="col-md-12">
										<div class="form-group">
											<input type="button" class="btn btn-primary" value="돌아가기"
												" onclick="location.href='customerCenterCall.do'"> <input
												type="button" class="btn btn-primary" value="질문 수정"
												onclick="location.href='QnAUpdateForm.do?no=${qna.no }'">
											<input type="button" class="btn btn-primary" value="질문 삭제"
												onclick="location.href='deleteQnA.do?no=${qna.no }'">
		
										</div>

									</div>
								</c:when>
							</c:choose>
						</div>
						<c:choose>
								<c:when test="${answer.content == null }">
						<div class="form-group" style="text-align: right;">
							
								<button type="button" class="btn btn-info btn-lg"
									data-toggle="modal" data-target="#myModal">답변 등록</button>
							</div>
							<!-- Modal -->
							<div class="modal fade" id="myModal" role="dialog">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">답변 등록</h4>
										</div>
										<div class="modal-body">


										
													<form id="detailInfo" action="insertAnswer.do"
														method="post">
														<table class="table">
													
															<input type="hidden" name="qna_no" value="${qna.no }">
															
															<tr>
																<th>답변 내용</th>
																<th><textarea rows="10" cols="50" name="content"></textarea>
																</th>
															</tr>
														</table>
														<div class="fh5co-spacer fh5co-spacer-sm"></div>
														<input type="submit" class="btn btn-sm btn-primary"
															id="go" value="답변달기">
														<button type="button" class="btn btn-primary btn-sm"
															data-dismiss="modal">취소하기</button>
													</form>
											



										</div>

									</div>
								</div>
							</div>
							</c:when>
							<c:when test="${answer.content != null }">
								<div class="form-group" style="text-align: right;">
							
								<button type="button" class="btn btn-info btn-lg"
									data-toggle="modal" data-target="#myModal">답변 수정</button>
							</div>
							<!-- Modal -->
							<div class="modal fade" id="myModal" role="dialog">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">답변 등록</h4>
										</div>
										<div class="modal-body">


										
													<form id="detailInfo" action="updateAnswer.do"
														method="post">
														<table class="table">
													
															<input type="hidden" name="qna_no" value="${qna.no }">
															
															<tr>
																<th>답변 내용</th>
																<th><textarea rows="10" cols="50" name="content"></textarea>
																</th>
															</tr>
														</table>
														<div class="fh5co-spacer fh5co-spacer-sm"></div>
														<input type="submit" class="btn btn-sm btn-primary"
															id="go" value="답변수정">
														<button type="button" class="btn btn-primary btn-sm"
															data-dismiss="modal">취소하기</button>
													</form>
											



										</div>

									</div>
								</div>
							</div>
							</c:when>
							</c:choose>
				</div>

			</div>
		</div>
	</div>
</body>
</html>
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
					<h2>공지 상세</h2>
					<div class="fh5co-spacer fh5co-spacer-sm"></div>
					<form action="#">
						<div class="row">

							<div class="col-md-4">
								<div class="form-group">
									<input type="text" class="form-control"
										value="글번호 : ${notice.no }" readonly>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<textarea name="date" id="date" cols="10" class="form-control"
										rows="1" readonly>등록일 : <fmt:formatDate
											value="${notice.date }" pattern="yyyy-MM-dd" /></textarea>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<input type="text" class="form-control"
										value="작성자 : ${notice.writer }" readonly>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<input type="text" class="form-control"
										value="${notice.title }" readonly>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<textarea name="content" id="content" cols="30"
										class="form-control" rows="10" readonly>${notice.content }</textarea>
								</div>
							</div>
							<c:choose>
								<c:when test="${member.admin==1}">
									<div class="col-md-12">
										<div class="form-group">
											<input type="button" class="btn btn-primary" value="돌아가기"
												" onclick="location.href='customerCenterCall.do'"> <input
												type="button" class="btn btn-primary" value="공지 수정"
												onclick="location.href='NoticeUpdateForm.do?no=${notice.no }'">
											<input type="button" class="btn btn-primary" value="공지 삭제"
												onclick="location.href='deleteNotice.do?no=${notice.no }'">
										</div>
									</div>
								</c:when>
							</c:choose>
						</div>
					</form>

				</div>

			</div>
		</div>
	</div>
</body>
</html>
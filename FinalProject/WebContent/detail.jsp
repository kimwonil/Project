<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
.deal-info {
	position: absolute;
	right: 13%;
	left: 64%;
	width: 357px;
	height: 564px;
	top:25%;
}

.deal-position {
	position: absolute;
	left: 13%;
	top:25%;
}

.deal-detail {
	position: absolute;
	left: 13%;
	right: 13%;
	top: 100%;
}
</style>
<body>
	<div id="fh5co-main">
		<div class="container">
			<div class="row">

				<div class="col-md-offset-2">

					<div id="fh5co-board" data-columns>
						<div class="item deal-position">
							<div class="animate-box">
								<a href="images/img_1.jpg" class="image-popup fh5co-board-img"
									title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?">
									<img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"	style="width: 800px; height: 500px;">
									</a>
							</div>
							<div class="fh5co-desc">글제목</div>
						</div>

						<div class="item deal-info">
							<p>
								판매자 닉네임
								<button>판매자 프로필</button>
							</p>

							<p>가격</p>
							<p>옵션추가</p>

							<p>날짜</p>
							<p>장소</p>
							<p>인원</p>
							<button>구매하기</button>
							<button>찜하기</button>
						</div>

					</div>
				</div>
			</div>
			<div class="row">
				<div id="fh5co-board" data-columns>
					<div class="item deal-detail">
						<h4 align="center">여기다가 상세 내용 쓸거야</h4>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
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
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		$("#tabs").tabs();
	});
</script>
<style type="text/css">
	#cashList{
		width: 700px;
		height: 100px;
		text-align: center;
	}
	#refillCash{
		margin-top: 20px;
	}
	#balanceTD{
		border:1px solid black;
		border-radius:20px;
		height: 80px;
		width: 200px;
		line-height: 80px;
		margin-left: 70px;
	}

</style>
</head>
<body>

	<div id="fh5co-main">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<h2>캐시관리</h2>
					<div id="tabs">
						<ul>
							<li><a href="#tabs-1">충전</a></li>
							<li><a href="#tabs-2">거래내역</a></li>
							<li><a href="#tabs-3">정산신청</a></li>
							<li><a href="#tabs-4">환전신청</a></li>
						</ul>
						<div id="tabs-1">
							<p>
							<table id="cashList">
								<tr>
									<td>
									<div  id="balanceTD">
									잔액 200원
									</div>
									</td>
									<td>
										<button type="button" id="refillCash" class="btn btn-info" data-toggle="modal"
											data-target="#refillModal">충전소 가기</button>
									</td>
								</tr>
							</table>
							</p>
						</div>
						<div id="tabs-2">
							<p>2번</p>
						</div>
						<div id="tabs-3">
							<p>3번</p>
						</div>
						<div id="tabs-4">
							<p>4번</p>
						</div>
					</div>
					

					<!-- 충전소  Modal -->
					<div class="modal fade" id="refillModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">재능 신청</h4>
								</div>
								<div class="modal-body">
									<table id="talentTable">
										<tr>
											<td>신청 재능</td>
											<td><select>
													<option>디자인/그래픽</option>
													<option>컴퓨터/개발</option>
													<option>음악/영상</option>
													<option>생활/대행/상담</option>
													<option>노하우/여행</option>
											</select></td>
										</tr>
										<tr>
											<td colspan="2"><b>관련 자료</b></td>
										</tr>
										<tr>
											<td colspan="2"><input type="file"></td>
										</tr>
										<tr>
											<td colspan="2"><input type="file"></td>
										</tr>
										<tr>
											<td colspan="2"><input type="file"></td>
										</tr>
									</table>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-info" data-dismiss="modal">닫기</button>
								</div>
							</div>

						</div>
					</div>
					<!-- Modal -->

				</div>
			</div>
		</div>
	</div>
</body>
</html>
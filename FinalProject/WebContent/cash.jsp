<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="menu.jsp" %>
    <%@ include file="miniProfile.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>
<title>Insert title here</title>
<script>
	$(function() {
		$("#tabs").tabs();
	});
	var IMP = window.IMP;
	IMP.init('imp11518283');
	$(document).ready(function(){
		$('#payCash').click(function(){
			var amount = document.getElementsByName("amount");
			var size = amount.length;
			var cash = 0;
			for(var i=0; i<size;i++){
				if(amount[i].checked){
					cash = amount[i].value;
					break;					
				}
			}
			
			
			IMP.request_pay({
				pg : 'html5_inicis',
			    pay_method : 'card',
			    merchant_uid : 'merchant_' + new Date().getTime(),
			    name : '캐시 충전',
			    amount : cash,
			    buyer_email : 'iamport@siot.do',
			    buyer_name : '구매자이름',
			    m_redirect_url:'http://192.168.0.3:8080/Pay_practice/mobile.cash'
			}, function(rsp) {
				if ( rsp.success ) {
			    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
			    	console.log(rsp);
//	 		    	var msg = '결제가 완료되었습니다.';
//	     			msg += '\n고유ID : ' + rsp.imp_uid;
//	     			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
//	     			msg += '\결제 금액 : ' + rsp.paid_amount;
//	     			msg += '카드 승인번호 : ' + rsp.apply_num;

//	     			alert(msg);
			    	$.ajax({
			    		url: "complete.cash", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
			    		type: 'POST',
			    		dataType: 'json',
			    		data: 
			    		{
				    		imp_uid : rsp.imp_uid,
				    		merchant_uid : rsp.merchant_uid,
				    		amount : rsp.paid_amount
			    		}
			    	});
			    } else {
			        var msg = '결제에 실패하였습니다.';
			        msg += '에러내용 : ' + rsp.error_msg;

			        alert(msg);
			    }
			});
		});
		
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
	#refillTable{
		border:1px solid black;
		width:500px;
		text-align:center;
		margin: 0 auto;
	}
	#tradeList, #completeList, #exchangeList{
		width:700px;
		text-align: center;
		margin: 0 auto;
	}
	#tradeList td, #completeList td, #exchangeList td{
		
		border:1px solid black;
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
							<li><a href="#tabs-5">환전신청내역</a></li>
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
							<table id="tradeList">
								<tr>
									<td width="15%">처리일</td>
									<td width="60%">제목</td>
									<td width="15%">판매/구매</td>
									<td width="10%">상태</td>
								</tr>
								<tr>
									<td>2017-07-12</td>
									<td>임시 배치용 글</td>
									<td>판매</td>
									<td>완료</td>
								</tr>
							</table>
						</div>
						<div id="tabs-3">
							<table id="completeList">
								<tr>
									<td width="15%">처리일</td>
									<td width="50%">제목</td>
									<td width="15%">구매자</td>
									<td width="10%">금액</td>
									<td width="10%">상태</td>
								</tr>
								<tr>
									<td>2017-07-12</td>
									<td>임시 배치용 글</td>
									<td>구매자ID</td>
									<td>10,000</td>
									<td>정산완료</td>
								</tr>
							</table>
						</div>
						<div id="tabs-4">
							<table>
								<tr>
									<td width="35%">현재 포인트 : <label>10,500</label></td>
								</tr>
								<tr>
									<td width="15%">신청 포인트 : <input type="text"></td>
								</tr>
								<tr>
									<td width="35%">환전 후 포인트 : <label>6,500</label></td>
								</tr>
								<tr>
									<td width="15%"><button class="btn btn-sm btn-info">환전</button></td>
								</tr>
							</table>
						</div>
						<div id="tabs-5">
							<table id="exchangeList">
								<tr>
									<td width="15%">처리일</td>
									<td width="35%">신청 포인트</td>
									<td width="35%">환전 후 포인트</td>
									<td width="15%">상태</td>
								</tr>
								<tr>
									<td>2017-07-12</td>
									<td>5,000</td>
									<td>6,500</td>
									<td>승인대기</td>
								</tr>
							</table>
						</div>
					</div>
					

					<!-- 충전소  Modal -->
					<div class="modal fade" id="refillModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">캐시 충전소</h4>
								</div>
								<div class="modal-body">
									<table id="refillTable">
										<tr>
											<td><b>충전 금액</b></td>
										</tr>
										<tr>
											<td>
												<table style="width:400px;margin: 0 auto;">
													<tr>
														<td><div class="radio"><label><input type="radio" value="1000" name="amount">&nbsp;&nbsp;1,000원</label></div></td>
														<td><div class="radio"><label><input type="radio" value="3000" name="amount">&nbsp;&nbsp;3,000원</label></div></td>
													</tr>
													<tr>
														<td><div class="radio"><label><input type="radio" value="5000" name="amount">&nbsp;&nbsp;5,000원</label></div></td>
														<td><div class="radio"><label><input type="radio" value="10000" name="amount">10,000원</label></div></td>
													</tr>
													<tr>
														<td><div class="radio"><label><input type="radio" value="30000" name="amount">30,000원</label></div></td>
														<td><div class="radio"><label><input type="radio" value="50000" name="amount">50,000원</label></div></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td><button type="button" class="btn btn-info" id="payCash">충전하기</button></td>
										</tr>	
									</table>
									
									
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
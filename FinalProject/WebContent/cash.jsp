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
			    buyer_email : $('#memberId').val(),
			    buyer_name : $('#memberNickName').val(),
			    m_redirect_url:'http://192.168.0.3:8080/Pay_practice/mobile.cash'
			}, function(rsp) {
				if ( rsp.success ) {
			    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
// 			    	console.log(rsp);
	 		    	var msg = '결제가 완료되었습니다.';
// 	     			msg += '\n고유ID : ' + rsp.imp_uid;
// 	     			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	     			msg += '\n결제 금액 : ' + rsp.paid_amount;
	     			msg += '\n카드 승인번호 : ' + rsp.apply_num;

	     			alert(msg);
	     			
			    	$.ajax({
			    		url: "cash.do", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
			    		type: 'POST',
			    		dataType: 'json',
			    		data: 
			    		{
				    		imp_uid : rsp.imp_uid,
				    		merchant_uid : rsp.merchant_uid,
				    		refillCash : rsp.paid_amount
			    		},
			    		success:function(data){
			    			$('#refillModal').modal("hide");
			    			
// 			    			console.log(data);
							if(data.result){
								$('.balance').text(data.cash);
							}
			    		},
			    		error:function(jqXHR, textStatus, errorThrown){
			    			alert(textStatus);     //응답상태
			    			alert(errorThrown);     //응답에 대한 메세지
			    		}
			    	});
			    } else {
			        var msg = '결제에 실패하였습니다.';
			        msg += '에러내용 : ' + rsp.error_msg;

			        alert(msg);
			    }
			});
		});//PayCash 결제
		
		$('#cashList').click(function(){
			$.ajax({
				url:"cashList.do",
				type:"POST",
				dataType:"json",
				success:function(data){
// 					console.log(data);
					$('#tradeTable tr:gt(0)').remove();
					for(var i=0;i<data.length;i++){
					$('#tradeTable').append("<tr><td>"+data[i].date+"</td><td>"
													+data[i].amount+"</td><td>"
													+data[i].balance+"</td><td>"
													+data[i].code+"</td><td>"
													+(data[i].state==1?"충전":data[i].state==2?"구매":data[i].state==3?"환불":data[i].state==4?"정산대기":"정산완료")+"</td></tr>");
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
					console.log(textStatus);
					console.log(errorThrown);
					
				}
			});
			
			
		});//cashList 캐시 내역
		
		$('#exchangeAmount').keyup(function(){
			var current = $('#currentBalance').val();
			var amount = $('#exchangeAmount').val();
			
			var after = current - amount;
			if(after<0){
				alert("포인트가 부족합니다.");
				$('#exchangeAmount').val("");
				$('#afterBalance').text(Number(current).toLocaleString());
			}else{
				$('#afterBalance').text(Number(after).toLocaleString());
			}
		});//환전 금액 입력
		
		
		$('#exchange').click(function(){
			$.ajax({
				url:"exchange.do",
				type:"POST",
				data:{amount:$('#exchangeAmount').val()},
				dataType:"json",
				success:function(data){
					console.log(data);
					alert("환전 신청 되었습니다.");
					$('#exchangeAmount').val("");
					$('.balance').text(data.cash);
				},
				error:function(jqXHR, textStatus, errorThrown){
					console.log(textStatus);
					console.log(errorThrown);
				}
			});
		});//환전 클릭
		
		
		$('#exchangeList').click(function(){
			$.ajax({
				url:"exchangeList.do",
				type:"POST",
				data:{id:$('#memberId').val()},
				dataType:"json",
				success:function(data){
// 					console.log(data);
					$('#exchangeTable tr:gt(0)').remove();
					for(var i=0;i<data.length;i++){
					$('#exchangeTable').append("<tr><td>"+data[i].date+"</td><td>"
													+data[i].request+"</td><td>"
													+data[i].balance+"</td><td>"
													+(data[i].state==1?"환전대기":data[i].state==2?"환전완료":"환전취소")+"</td></tr>");
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
					console.log(textStatus);
					console.log(errorThrown);
					
				}
			});
			
		});//환전 리스트 클릭
		
		
	});	//document
	
	
	
</script>
<style type="text/css">
	#cashTable{
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
	#tradeTable, #exchangeTable{
		width:700px;
		text-align: center;
		margin: 0 auto;
	}
	#tradeTable td, #exchangeTable td{
		
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
							<li><a href="#tabs-2" id="cashList">캐시 내역</a></li>
							<li><a href="#tabs-3">환전 신청</a></li>
							<li><a href="#tabs-4" id="exchangeList">환전 신청 내역</a></li>
						</ul>
						<div id="tabs-1">
							<p>
							<table id="cashTable">
								<tr>
									<td>
									<div  id="balanceTD">
									
									잔액 : <label class="balance"><fmt:formatNumber value="${member.balance}" type="number"/> </label>원
									<input type="hidden" value="${member.id}" id="memberId">
									<input type="hidden" value="${member.nickName}" id="memberNickName">
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
							<table id="tradeTable">
								<tr>
									<td width="15%">처리일</td>
									<td width="15%">충전금액</td>
									<td width="15%">잔액</td>
									<td width="15%">전표코드</td>
									<td width="10%">상태</td>
								</tr>
								
							</table>
						</div>
						<div id="tabs-3">
							<table>
								<tr>
									<td width="35%">현재 포인트 : <label class="balance"><fmt:formatNumber value="${member.balance}" type="number"/> </label></td>
								</tr>
								<tr>
									<td width="15%">신청 포인트 : <input type="text" id="exchangeAmount">
															  <input type="hidden" value="${member.balance}" id="currentBalance">
									</td>
								</tr>
								<tr>
									<td width="35%">환전 후 포인트 : <label class="balance" id="afterBalance"><fmt:formatNumber value="${member.balance}" type="number"/> </label></td>
								</tr>
								<tr>
									<td width="15%"><button class="btn btn-sm btn-info" id="exchange">환전</button></td>
								</tr>
							</table>
						</div>
						<div id="tabs-4">
							<table id="exchangeTable">
								<tr>
									<td width="30%">처리일</td>
									<td width="30%">요청금액</td>
									<td width="30%">잔액</td>
									<td width="10%">상태</td>
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
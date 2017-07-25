<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../menu.jsp" %>
    <%@ include file="../miniProfile.jsp"%>
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
	
	function cashListManager(){
		$.ajax({
			url:"cashList.do",
			type:"POST",
			dataType:"json",
			success:function(data){
					console.log(data);
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
	}
	
	function exchangeListManager(){
		$.ajax({
			url:"exchangeList.do",
			type:"POST",
			data:{id:$('#memberId').val()},
			dataType:"json",
			success:function(data){
//					console.log(data);
				$('#exchangeTable tr:gt(0)').remove();
				for(var i=0;i<data.length;i++){
				$('#exchangeTable').append("<tr><td>"+data[i].date+"</td><td>"
												+data[i].id+"</td><td>"
												+data[i].request+"</td><td>"
												+data[i].balance+"</td><td>"
												+(data[i].state==1?"<button class='approvalBtn btn btn-info' value='"+data[i].no+"'>승인</button><button class='cancelBtn btn btn-info' value='"+data[i].no+"'>취소</button>":data[i].state==2?"환전완료":"환전취소")+"</td></tr>");
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
				
			}
		});
	}
	
	
	$(document).ready(function(){
		
		
		
		cashListManager();
		
		$('#cashList').click(function(){
			
			cashListManager();
			
		});//cashList 캐시 내역
		
		
		
		
		$('#exchangeList').click(function(){
			
			exchangeListManager();
			
		});//환전 리스트 클릭
		
		
		$(document).on('click','.approvalBtn',function(){
			alert("승인 : "+$(this).val());
			var no = $(this).val();
			$.ajax({
				url:"exchangeManager.do",
				type:"POST",
				data:{no:no, state:2},
				dataType:"json",
				success:function(data){
					console.log(data);
					exchangeListManager();
				},
				error:function(jqXHR, textStatus, errorThrown){
					console.log(textStatus);
					console.log(errorThrown);
				}
			});
		});//환전 승인 버튼
		
		
		$(document).on('click','.cancelBtn',function(){
			alert("취소 : "+$(this).val());
			var no = $(this).val();
			$.ajax({
				url:"exchangeManager.do",
				type:"POST",
				data:{no:no, state:3},
				dataType:"json",
				success:function(data){
					console.log(data);
					exchangeListManager();
				},
				error:function(jqXHR, textStatus, errorThrown){
					console.log(textStatus);
					console.log(errorThrown);
				}
			});
		});//환전 취소 버튼
		
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
	.btn{
		line-height:15px;
		margin: 10px 10px;
		padding: 3px;
	}

</style>
</head>
<body>

	
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
			<div class="col-md-8 col-md-offset-2">
			<h2>캐시관리(관리자)</h2>
					<div id="tabs">
						<ul>
							<li><a href="#tabs-1" id="cashList">캐시 내역</a></li>
							<li><a href="#tabs-2" id="exchangeList">환전 신청 내역</a></li>
						</ul>
						<div id="tabs-1">
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
						<div id="tabs-2">
							<table id="exchangeTable">
								<tr>
									<td width="15%">처리일</td>
									<td width="35%">아이디</td>
									<td width="15%">요청금액</td>
									<td width="15%">잔액</td>
									<td width="20%">상태</td>
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
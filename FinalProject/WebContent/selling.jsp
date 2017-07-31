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
	


	
	
	function sellingList(page){
		$.ajax({
			url:"sellingList.do",
			type:"POST",
			data:{
				page:page
			},
			dataType:"json",
			success:function(data){
				console.log(data);
				
				$('#tabs-1 > table tr:gt(0)').remove();
				if(data == ""){
					$('#tabs-1 > table').append(
							'<tr><td colspan="5">내역이 없습니다.</td></tr>'		
						);
				}else{
					$.each(data, function(index, value){
						$('#tabs-1 > table').append(
							'<tr><td>' + value.date + '</td><td>' + value.title + '</td><td>' +
							value.count + ' / ' + value.quantity + '</td><td>'+(value.state==0?"대기중":value.state==1?"인원마감":"마감일 초과")+'</td><td>'+
							'<button class="btn-sm btn-info continueBtn" value="'+value.no+'">진행</button> <button class="btn-sm btn-info stopBtn" value="'+value.no+'">중단</button></td></tr>'		
						);
					});
				}
							
			},
			error:function(){
				alert("실패");
			}
		})
	}
	
	
	function ongoingList(){
		$.ajax({
			url:"ongoing.do",
			type:"POST",
			dataType:"json",
			success:function(data){
//					alert("성공");
				console.log(data);
				
				$('#tabs-2 > table tr:gt(0)').remove();
				if(data == ""){
					$('#tabs-2 > table').append(
							'<tr><td colspan="6">내역이 없습니다.</td></tr>'		
						);
				}else{
					$.each(data, function(index, value){
						$.each(value, function(index2, value2){
							
							var total = 0;
							
							$.each(value2.optionList, function(index3, option){
								total += option.price * option.amount;
							});
							
							$('#tabs-2 > table').append(
									'<tr><td>' + value2.date + '</td><td>' + value2.boardTitle + '</td><td>' +
									value2.purchaser + '</td><td><a href="#" class="optionList">'+total+'</a><input type="hidden" value="'+value2.purchase_no+'"></td><td>진행중</td><td>'+
									'<button class="btn-sm btn-info completeBtn" value="'+value2.purchase_no+'">완료</button> <button class="btn-sm btn-info stopBtn" value="'+value.no+'">중단</button></td></tr>'		
							);								
						});
					});
				}
				
				
			},
			error:function(){
				alert("실패");
			}
		});
		
	}
	
	
	function completionList(){
		$.ajax({
			url:"completion.do",
			type:"POST",
			dataType:"json",
			success:function(data){
//					alert("성공");
				console.log(data);
				
				$('#tabs-3 > table tr:gt(0)').remove();
				if(data == ""){
					$('#tabs-3 > table').append(
							'<tr><td colspan="6">내역이 없습니다.</td></tr>'		
					);
				}else{
					$.each(data, function(index, value){
						$.each(value, function(index2, value2){
							
							var total = 0;
							
							$.each(value2.optionList, function(index3, option){
								total += option.price * option.amount;
							});
							
							$('#tabs-3 > table').append(
									'<tr><td>' + value2.date + '</td><td>' + value2.boardTitle + '</td><td>' +
									value2.purchaser + '</td><td><a href="#" class="optionList">'+total+'</a><input type="hidden" value="'+value2.purchase_no+'"></td><td>'+
									(value2.state==11?"완료 대기":value2.state==20?"정산 대기":"정산 완료")+'</td><td>'+
									(value2.state==11?"":value2.state==20?'<button class="btn-sm btn-info calculateBtn" value="'+value2.purchase_no+'">정산</button> ':"")+' <button class="btn-sm btn-info stopBtn" value="'+value.no+'">중단</button></td></tr>'		
							);								
						});
					});
				}
				
				
			},
			error:function(){
				alert("실패");
			}
		});
		
	}
	
	
	
	$(document).ready(function(){
		sellingList(0);
		
		
		$(document).on('click','.continueBtn', function(){
			$.ajax({
				url:"purchaseList.do",
				type:"POST",
				data:{no:$(this).val()},
				dataType:"json",
				success:function(data){
					console.log(data);
					$('#purchaseTable tr:gt(0)').remove();
					if(data == ""){
						$('#purchaseTable').append(
								'<tr>'+
									'<td colspan="6">현재 구매자가 없습니다.</td>'+
								'</tr>'
						);
					}else{
						$.each(data, function(index, value){
							var optionStr="";
							var optionPrice="";
							var optionAmount="";
							var total = 0;
							
							$.each(value.optionList, function(index, option){
								optionStr += option.kind + "<br>";
								optionPrice += option.price + "<br>";
								optionAmount += option.amount +"<br>";
								total += option.price * option.amount;
							});
							
							$('#purchaseTable').append(
									'<tr>'+
										'<td><input type="checkbox" name="purchaseCheck" value="'+value.purchase_no+'"></td>'+
										'<td>'+value.purchaser+'</td>'+
										'<td>'+optionStr+'</td>'+
										'<td>'+optionAmount+'</td>'+
										'<td>'+optionPrice+'</td>'+
										'<td>'+total+'</td>'+
									'</tr>'
									
									
							);
						});
					}
				},
				error:function(){
					alert("실패");
				}
			});
			
			
			
			$('#continueModal').modal('show');
			
			
		});
		
		$(document).on('click','.stopBtn', function(){
			alert($(this).val());
		});
		
		$(document).on('click', '#submitBtn', function(){
			var Arr = new Array();
			$($('input[name=purchaseCheck]:checked')).each(function(){
				Arr.push($(this).val());
			});
			console.log(Arr);
			jQuery.ajaxSettings.traditional = true;

			$.ajax({
				url:"progress.do",
				type:"POST",
				data:{
					list:Arr,
					state:10
				},
// 				dataType:"json",
				success:function(data){
					alert("성공");
					$('#continueModal').modal('hide');
					sellingList();
				},
				error:function(){
					alert("실패");
				}
			});
			
		})
		
		$(document).on('click', '#closeBtn', function(){
			alert("닫기")
			$('#continueModal').modal('hide');
		});
		
		
		
		
		
// 		탭 기능
		
		$('#registrationList').click(function(){
			sellingList();
		});
		
		$('#ongoing').click(function(){
			ongoingList();
		});
		
		
		$(document).on('click', '.completeBtn', function(){
// 			alert("완료");
			$.ajax({
				url:"progress.do",
				type:"POST",
				data:{
					no:$(this).val(),
					state:11
				},
				success:function(){
					alert("성공");
					ongoingList();
				},
				error:function(){
					alert("실패");
				}
			});
			
			
		});
		
		
		
		
		
		
		
		$('#completion').click(function(){
			completionList();
		});
		
		$('#canceled').click(function(){
			alert("취소된");
		});
		
		
		
		
		
		$(document).on({
			mouseover : function(event){
				
				$.ajax({
					url:"purchaseOption.do",
					type:"POST",
					data:{no:$(this).siblings('input[type=hidden]').val()},
					dataType:"json",
					success:function(data){
						var optionStr="";
						var optionPrice=""; 
						
						var optionAmount="";
						var total = 0;
						
						$.each(data, function(index, option){
							optionStr += option.kind + "<br>";
							optionPrice += option.price + "<br>";
							optionAmount += option.amount +"<br>";
							total += option.price * option.amount;
						});
						
						$('.popupLayer').html(
								'<table><tr><td>옵션</td><td>수량</td><td>금액</td><td>총액</td></tr>'+
								'<tr><td>'+optionStr+'</td><td>'+optionAmount+'</td><td>'+optionPrice+'</td><td>'+total+'</td></tr></table>'
						);
					},
					error:function(){
						alert("실패");
					}
				});
				
				var Wwidth = window.innerWidth;
				var Wheight = window.innerHeight;
				var popWidth = $('.popupLayer').width();
				var popHeight = $('.popupLayer').height();
				var mouseX=event.pageX;
				var mouseY=event.pageY;
				
				if(Wwidth < popWidth + event.pageX){
					mouseX -= popWidth;
				}
				
				if(Wheight < popHeight + event.pageY){
					mouseY -= popHeight;
				}
				
				
	 			$('.popupLayer').css({
	 				"top": mouseY,
	 				"left": mouseX,
	 				"visibility":"visible"
	 			});
				
				
				
			},
			mouseout : function(event){
				$('.popupLayer').css({
	 				"visibility":"hidden"
	 			});
			}
		}, '.optionList');
		
		
		
	});
	
</script>
<style type="text/css">

#tabs tr,#tabs td,#tabs th,#purchaseTable td{
	border: 1px solid black;
	text-align: center;
}
table{
	width: 100%;
	
}
.popupLayer {
	position: absolute;
/* 	display: none; */
	background-color: #ffffff;
	border: solid 2px #d0d0d0;
	width: 350px;
	height: 150px;
	padding: 10px;
	visibility: hidden;
	z-index: 5;
}
.popupLayer>table td{
	border: 1px solid black;
	text-align: center;
}
.popupLayer>table{
	width: 100%;
}

	#tabs-1 div, #tabs-2 div{
		text-align:center;
		position: absolute;
		top: 90%;
		left: 40%;
	}
	#tabs-1, #tabs-2{
		height: 400px;
	}
	.col-md-8{
		position: relative;
		left: 10%;
	}


</style>
</head>
<body>
	<div class="popupLayer">
	
	</div>

	<div id="fh5co-main">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<h2>판매관리</h2>
					<div id="tabs">
						<ul>
							<li><a href="#tabs-1" id="registrationList">등록한 재능글</a></li>
							<li><a href="#tabs-2" id="ongoing">진행중 거래</a></li>
							<li><a href="#tabs-3" id="completion">완료된 거래</a></li>
							<li><a href="#tabs-4" id="canceled">취소된 거래</a></li>
						</ul>
						<div align="center">
							<select>
								<option>검색조건</option>
								<option>닉네임</option>
								<option>글제목</option>
								<option>날짜</option>
							</select>
							<input type="text">
							<button>검색</button>
						</div>
						
						<div id="tabs-1" >
							<table>
								<tr><th width="15%">등록일</th><th width="40%">글제목</th><th width="15%">구매자</th><th width="10%">상태</th><th width="20%">비고</th></tr>
							</table>
							<div>
								<button class="btn-sm btn-info prev" value="">이전</button>&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn-sm btn-info next" value="">다음</button>
							</div>
						</div>
						<div id="tabs-2">
							<table>
								<tr><th>등록일</th><th>글제목</th><th>구매자</th><th>총액</th><th>상태</th><th>비고</th></tr>
							</table>
							
						</div>
						<div id="tabs-3">
							<table>
								<tr><th>등록일</th><th>글제목</th><th>구매자</th><th>총액</th><th>상태</th><th>비고</th></tr>
							</table>
						</div>
						<div id="tabs-4">
							<table>
								<tr><th>등록일</th><th>글제목</th><th>구매자</th><th>총액</th><th>상태</th><th>비고</th></tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
				<!-- 진행  Modal -->
					<div class="modal fade" id="continueModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">구매자 현황</h4>
								</div>
								<div class="modal-body">
									<table id="purchaseTable">
										<tr>
											<td>선택</td>
											<td>구매자</td>
											<td>옵션</td>
											<td>수량</td>
											<td>금액</td>
											<td>총액</td>
										</tr>
									</table>
									
									<button id="submitBtn" class="btn-sm btn-info">확인</button><button id="closeBtn" class="btn-sm btn-info">닫기</button>
									
								</div>
							</div>

						</div>
					</div>
					<!-- Modal -->
	
	
	
	
</body>
</html>
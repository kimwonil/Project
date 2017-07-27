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
	
	function purchase(){
		$.ajax({
			url:"purchase.do",
			type:"POST",
			dataType:"json",
			success:function(data){
				console.log(data);
				
				$('#tabs-1 > table tr:gt(0)').remove();
				if(data == ""){
					$('#tabs-1 > table').append(
							'<tr><td colspan="8">내역이 없습니다.</td></tr>'		
					);
				}else{
					$.each(data, function(index, value){
						var total = 0;
						
						$.each(value.optionList, function(index, option){
							total += option.price * option.amount;
						});
						
						
						$('#tabs-1 > table').append(
							'<tr><td>' + value.date + '</td><td>' + value.boardTitle + '</td><td>' +
							value.seller + '</td><td><a href="#" class="optionList">' + total + '</a><input type="hidden" value="'+value.no+'"></td><td>' + 
							(value.state==0?"대기중":value.state==10?"진행중":value.state==11?'</td><td><button class="btn-sm btn-info" value="'+value.purchase_no+'">완료</button>':"완료") + 
							'</td><td><button class="btn-sm btn-info" value="'+value.purchase_no+'">취소</button></td></tr>'		
						);
					});
				}
							
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
		})
	}
	
	
	$(document).ready(function(){
		purchase();
		
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

#tabs tr,#tabs td,#tabs th{
	border: 1px solid black;
	text-align: center;
}
#tabs table{
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
</style>
</head>
<body>
	<div class="popupLayer">
	
	</div>


	<div id="fh5co-main">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<h2>구매관리</h2>
					<div id="tabs">
						<ul>
							<li><a href="#tabs-1">진행중 거래</a></li>
							<li><a href="#tabs-2">완료된 거래</a></li>
							<li><a href="#tabs-3">취소된 거래</a></li>
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
								<tr><th width="15%">등록일</th><th width="40%">글제목</th><th width="15%">판매자</th><th width="10%">총액</th><th width="10%">상태</th><th width="10%">비고</th></tr>
							</table>
						</div>
						<div id="tabs-2">
							<table>
								<tr><th>등록일</th><th>글제목</th><th>판매자</th><th>가격(수량)</th></tr>
								<tr><td>2017.07.07</td><td>칼 갈아드립니다</td><td>칼갈이</td><td>3000/1</td></tr>
							</table>
						</div>
						<div id="tabs-3">
							<table>
								<tr><th>등록일</th><th>글제목</th><th>판매자</th><th>가격(수량)</th></tr>
								<tr><td>2017.07.07</td><td>칼 갈아드립니다</td><td>칼갈이</td><td>3000/1</td></tr>
							</table>
						</div>
					
					</div>
					

					
				</div>
			</div>
		</div>
	</div>
</body>
</html>
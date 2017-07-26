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
						
						$('#tabs-1 > table').append(
							'<tr><td>' + value.date + '</td><td>' + value.boardTitle + '</td><td>' +
							value.seller + '</td><td>' + optionStr + '</td><td>' + optionAmount + '</td><td>' +
							optionPrice + '</td><td>' + total + '</td><td>'+
							'<button class="btn-sm btn-info" value="'+value.no+'">취소</button></td></tr>'		
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
	});
	
</script>
<style type="text/css">

#tabs tr,#tabs td,#tabs th{
border: 1px solid black;
text-align: center;
}

</style>
</head>
<body>

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
							<table style="width: 100%;">
								<tr><th>등록일</th><th>글제목</th><th>판매자</th><th>옵션</th><th>수량</th><th>금액</th><th>총액</th><th>비고</th></tr>
							</table>
						</div>
						<div id="tabs-2">
							<table style="width: 100%;">
								<tr><th>등록일</th><th>글제목</th><th>판매자</th><th>가격(수량)</th></tr>
								<tr><td>2017.07.07</td><td>칼 갈아드립니다</td><td>칼갈이</td><td>3000/1</td></tr>
							</table>
						</div>
						<div id="tabs-3">
							<table style="width: 100%;">
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>
</head>
<script type="text/javascript">
$(document).ready(function(){
	var optionNum = 0;
	var priceNum = 0;
	var option = new Array();
	var optionPrice = new Array();
	$('#btn').click(function(){
		optionNum++;
		priceNum++;
		$('#tableOption').append(
			'<tr>'+
				'<td>종류</td>'+
				'<td><input type="text" id="option'+optionNum+'"></td>'+
				'<td>가격</td>'+
				'<td><input type="text" id="optionPrice'+priceNum+'"></td>'+
				'<td><button class="delete">삭제</button></td>'+
			'</tr>'
		);
	});

	$('#submit').click(function(){
		option = [];
		optionPrice = [];
		for(var i=0;i<=optionNum;i++){
			if($('#option'+i).val() != undefined){
				option.push($('#option'+i).val());
			}
			if($('#optionPrice'+i).val() != undefined){
				optionPrice.push($('#optionPrice'+i).val());
			}
		}
				console.log(option);
				console.log(optionPrice);
				$.ajax({
					url : "price.do",
					type : "post",
					data : {opt : option, optPrice : optionPrice},
					success : function(){
						alert('성공');
					}
				})
	});
	
	$(document).on('click', '.delete', function(){
		$(this).parent().parent().remove();	
	})
	
});

</script>
<body>
<button id="btn">추가</button>
<button id="submit">확인</button>

<table id="tableOption">
	<tr>
		<td>종류</td>
		<td><input type="text" id="option0"></td>
		<td>가격</td>
		<td><input type="text" id="optionPrice0"></td>
		<td><button class="delete">삭제</button></td>
	</tr>

</table>
</body>
</html>
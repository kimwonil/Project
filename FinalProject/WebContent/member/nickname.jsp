<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>


<script type="text/javascript">
$(document).on('keyup', '#nickname', function(){
	var nicknameCheck = $(this).val();
	var check = /^[가-힣a-zA-Z0-9]{2,10}$/;
	if(check.test(nicknameCheck)){
		$.ajax({
			url:"nickname.do",
			type:"POST",
			data:{
				nickname:$(this).val()
			},
			dataType:"json",
			success:function(data){
				console.log(data.result);
				$('#duplicate').val(data.result);
				
				if(data.result){
					$('#inputDiv').removeClass("has-error");
					$('#inputDiv').addClass("has-success");
					$('#resultSpan').removeClass("glyphicon-remove");
					$('#resultSpan').addClass("glyphicon-ok");
					$('#result').text("사용 가능합니다.");
				}else{
					$('#inputDiv').removeClass("has-success");
					$('#inputDiv').addClass("has-error");
					$('#resultSpan').removeClass("glyphicon-ok");
					$('#resultSpan').addClass("glyphicon-remove");
					$('#result').text("중복입니다.");
				}
			},
			error:function(){
				alert("실패");
			}
		});
	}else{
		$('#duplicate').val(false);
		$('#inputDiv').removeClass("has-success");
		$('#inputDiv').addClass("has-error");
		$('#resultSpan').removeClass("glyphicon-ok");
		$('#resultSpan').addClass("glyphicon-remove");
		$('#result').text("사용 불가합니다.");
	}
});

$(document).on('click', '#submitBtn', function(){
	var duplicate = $('#duplicate').val();
	if(duplicate=='true'){
		$('#insertForm').submit();
	}else{
		alert("닉네임을 다시 확인하세요.");
		$('#nickname').focus();
	}
});

</script>
<style type="text/css">
#nickname {
	width: 200px;
	height: 30px;
	display: inline;
}

.container {
	position: absolute;
	left: 40%;
	top: 30%;
}

table {
	text-align: center;
	height: 150px;
}
.wrapperTd{
	text-align: left;
	padding-left: 100px;
} 
</style>

</head>
<body>
<input type="hidden" id="duplicate" value="false">
	<div class="container">
		<table>
			<tr>
				<td colspan="2">${email}님닉네임을 입력하세요.</td>
				<td></td>
			</tr>
			<tr>
				<td width="15%">닉네임 :</td>
				<td width="45%">
					<form id="insertForm" action="memberInsert.do" method="post" class="form-inline">
						<div id="inputDiv" class="form-group has-success has-feedback">
							<div class="col-sm-10">
							<input type="text" class="form-control" pattern="[가-힣a-zA-Z0-9]{1,10}" title="닉네임은 10자 이하로 입력하세요(특수문자불가)" name="nickname" id="nickname">
								 <span id="resultSpan"
									class="glyphicon glyphicon-ok form-control-feedback"></span>
							</div>
						</div>
					</form>
				</td>
				<td width="40%"><span id="result"></span></td>
			</tr>
			<tr>
				<td colspan="2" height="100">
					<button id="submitBtn" class="btn btn-sm btn-info">확인</button> <input
					type="reset" class="btn btn-sm btn-info" value="취소">
				</td>
				<td></td>
			</tr>
			<tr>
				<td colspan="2" height="100" align="left">
					<ul>
						<li>영문, 한글, 숫자 조합 가능</li>
						<li>최소 2글자, 최대 10글자 사용</li>
						<li>특수문자 사용 불가</li>
						<li>한글은 자음 또는 모음만 사용 불가</li>
					</ul>
				</td>
				<td></td>
			</tr>
		</table>
	</div>

</body>
</html>
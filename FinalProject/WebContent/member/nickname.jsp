<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>
<title>Insert title here</title>

<script type="text/javascript">
$(document).on('keyup', '#nickname', function(){
	$.ajax({
		url:"nickname.do",
		type:"POST",
		data:{
			nickname:$(this).val()
		},
		dataType:"text",
		success:function(data){
			$('#result').text(data);
		},
		error:function(){
			alert("실패");
		}
	});
});

</script>

</head>
<body>
<form action="memberInsert.do" method="post">
	${email}님 닉네임을 입력하세요.<p>
	닉네임 : <input id="nickname" type="text" name="nickname"><span id="result"></span>
	<input type="submit" value="확인"> 
	<input type="reset" value="취소"> 
</form>
</body>
</html>
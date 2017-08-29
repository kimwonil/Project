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
	<script src="jquery.number.js"></script>
<script type="text/javascript">
$(document).on('click', '#numberinput', function(){
	var num = $('#numberInput').val()
	console.log(num);
});

$(document).on('blur', '#amount', function(){


	   // take US format text into std number format


	   var number = $(this).parseNumber({format:"#,###.00", locale:"kr"}, false);


	   // write the number out


	   $("#salaryUnformatted").val(number);


	});

</script>
</head>
<body>
<input type="number" step="100" id="numberInput" lang="en-150">
<input type="text" id="amount" name="amount" numberOnly placeholder="0" />
</body>
</html>
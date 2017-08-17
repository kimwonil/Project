<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>
<script type="text/javascript">
$(document).on('click','#btn',function(){
	var val = $('#value').val();
	var result = val;
	if(val.length > 30){
		var check = valueCut(val);
		result = val.substring(0,check)+"<br>"+val.substring(check);
	}
	$('#result').html(result);
});
function valueCut(str){
	var index=0;
	
	for(var i=1;i<=4;i++){
		index = str.indexOf(" ", index+1);
	}
	return index;
}
</script>

<body>
값:<input type="text" id="value" value="Thu Aug 17 18:18:49 KST 2017 WARN: Establishing SSL connection without server"><br>
결과:<div id="result"></div>
<button id="btn">버튼</button>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">


</script>
<style type="text/css">
	#miniProfile{
		background-color:lightgray;
		border-radius:10px;
		position: absolute;
		top:37%;
		left:10%;
		text-align: center;
		width:200px;
	}
	.miniImg{
		width: 100px;
		height: 100px;
		
		position: absolute;
		left: 14%;
		top: 30%;
		
		z-index:4;
	}
	#imgSpace{
		height: 50px;
	}
	.btn{
		margin: 10px 0px 20px 0px;
	}
</style>
</head>
<body>
<div>
<img src="images/img_1.jpg" class="img-circle miniImg">
<table id="miniProfile">
	<tr>
		<td id="imgSpace"></td>
	</tr>

	<tr>
		<td>${member.nickname }</td>
	</tr>
	<tr>
		<td><label class="balance"><fmt:formatNumber value="${member.balance}" type="number"/></label>원</td>
	</tr>
	<tr>
		<td><input type="button" value="충전" class="btn btn-sm btn-info"></td>
	</tr>
	<tr>
		<td>나의 재능 : <a href="profile.do">0건</a></td>
	</tr>
	<tr>
		<td>판매중인 재능 : <a href="selling.do">0건</a></td>
	</tr>
	<tr>
		<td>구매중인 재능 : <a href="purchasing.do">0건</a></td>
	</tr>
	<tr>
		<td>관심 재능 : <a href="dipsList.do?id=${member.id}">0건</a></td>
	</tr>
	<tr>
		<td>쪽지 : <a href="message.do">0건</a></td>
	</tr>
</table>
</div>
</body>
</html>
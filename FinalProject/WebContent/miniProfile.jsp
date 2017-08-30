<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function profileContent(){
	$.ajax({
		url:"miniProfile.do",
		type:"POST",
		dataType:"json",
		success:function(data){
			console.log(data);
			$('#profileNum').text(data.authority);
			$('#sellingNum').text(data.selling);
			$('#purchasingNum').text(data.purchase);
			$('#dipsListNum').text(data.dipsList);
			$('#messageNum').text(data.message);
		},
		error:function(jqXHR, textStatus, errorThrown){
			alert(textStatus+"여기2?");     //응답상태
			alert(errorThrown);     //응답에 대한 메세지
		}
	});
	
}
$(document).ready(function(){
	profileContent();
	
	$('#chargeCash').click(function(){
		location.href="cashPage.do";
	});
});


</script>
<style type="text/css">
	#miniProfile{
		background-color:#60ccbd;
		border-radius:10px;
		position: fixed;
		top:400px;
		left:10%;
		width:200px;
		font-weight: bold;
		color:white;
	}
	.miniImg{
		width: 100px;
		height: 100px;
		position: absolute;
		left:25%;
		top:-20%;
		z-index:4;
	}
	#imgSpace{
		height: 50px;
	}
	.btn{
		margin: 10px 0px 20px 0px;
	}
	#miniProfile div{
		display: inline;
	}
	#miniProfileDiv{
		position: absolute;
		left: 10%;
		top: 40%;
	}
	.miniAlign{
		text-align: center;
	}
	.minipadding{
		padding-left: 10px;
	}
</style>
</head>
<body>
<div id="miniProfileDiv">

<table id="miniProfile">
	<tr class="miniAlign">
		<td id="imgSpace" colspan="2">
			<c:if test="${member.photo eq null}">
				<img class="img-circle miniImg" src="<c:url value="/images"/>/noimage.jpg">
			</c:if>
			<c:if test="${member.photo ne null}">
				<img class="img-circle miniImg" src="<c:url value="/user/profile/${member.id}/${member.login}"/>/${member.photo}">
			</c:if>
		</td>
	</tr>

	<tr class="miniAlign">
		<td colspan="2">${member.nickname }</td>
	</tr>
	<tr class="miniAlign">
		<td colspan="2"><label class="balance"><fmt:formatNumber value="${member.balance}" type="number"/></label>원</td>
	</tr>
	<tr class="miniAlign">
		<td colspan="2"><input id="chargeCash" type="button" value="충전" class="btn btn-sm btn-danger"></td>
	</tr>
	<tr>
		<td class="minipadding">나의 재능 : </td><td><a href="profile.do"><div id="profileNum">0</div>건</a></td>
	</tr>
	<tr>
		<td class="minipadding">판매중인 재능 : </td><td><a href="selling.do"><div id="sellingNum">0</div>건</a></td>
	</tr>
	<tr>
		<td class="minipadding">구매중인 재능 : </td><td><a href="purchasing.do"><div id="purchasingNum">0</div>건</a></td>
	</tr>
	<tr>
		<td class="minipadding">찜목록 : </td><td><a href="dipsList.do?id=${member.id}"><div id="dipsListNum">0</div>건</a></td>
	</tr>
	<tr>
		<td class="minipadding">쪽지 : </td><td><a href="message.do"><div id="messageNum">0</div>건</a></td>
	</tr>
</table>
</div>
</body>
</html>
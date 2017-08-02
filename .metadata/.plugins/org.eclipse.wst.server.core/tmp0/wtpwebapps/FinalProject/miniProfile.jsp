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
		border:1px solid black;
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
		left: 13%;
		top:30%;
		
		z-index:4;
	}
	#imgSpace{
		height: 50px;
	}
</style>
<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"50873",secure:"50882"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>
<body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-36" data-genuitec-path="/FinalProject/WebContent/miniProfile.jsp">
<div data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-36" data-genuitec-path="/FinalProject/WebContent/miniProfile.jsp">
<img src="images/img_1.jpg" class="img-circle miniImg">
<table id="miniProfile">
	<tr>
		<td id="imgSpace"></td>
	</tr>

	<tr>
		<td>${member.nickName }</td>
	</tr>
	<tr>
		<td><label class="balance"><fmt:formatNumber value="${member.balance}" type="number"/></label>원</td>
	</tr>
	<tr>
		<td><input type="button" value="충전" class="btn btn-sm btn-info"></td>
	</tr>
	<tr>
		<td>나의 재능 : 0건</td>
	</tr>
	<tr>
		<td>판매중인 재능 : 0건</td>
	</tr>
	<tr>
		<td>거래중인 재능 : 0건</td>
	</tr>
	<tr>
		<td>관심 재능 : 0건</td>
	</tr>
	<tr>
		<td>쪽지 : 0건</td>
	</tr>
</table>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	</head>
	<body>
	<style>
	.photo{
		width: 100px;
		height: 100px;
	}
	#memberTable{
		width: 800px;
	}
	#memberTable td{
		border:1px solid black;
		text-align: center;
	}
	
	</style>
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
			
				<div class="col-md-8 col-md-offset-2">
					<h2>멤버 관리</h2>
					<table id="memberTable">
						<tr>
							<td width="10%">체크</td>
							<td width="20%">아이디</td>
							<td width="20%">닉네임</td>
							<td width="20%">사진</td>
							<td width="15%">포인트</td>
							<td width="15%">비고</td>
						</tr>
						<tr>
							<td><input type="checkbox" value=""></td>
							<td>ABC123@naver.com</td>
							<td>ABC</td>
							<td><img class="photo img-rounded" src="images/img_1.jpg"></td>
							<td>10,000</td>
							<td>일반회원</td>
						</tr>
						
					</table>
					<a href="#" class="btn btn-sm btn-info">회원삭제</a>
					<a href="#" class="btn btn-sm btn-info">회원수정</a>
					
					
				</div>
        	</div>
       </div>
	</div>
	
	</body>
</html>
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
		position: relative;
		float: left;
		margin-right: 30px;
		width: 300px;
		height: 300px;
		
	}
	
	</style>
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
			
				<div class="col-md-8 col-md-offset-2">
					<h2>프로필 관리</h2>
					<img src="images/img_29.jpg" alt="Free HTML5 template by FREEHTML5.co" class="img-rounded img-responsive photo">
					
					<p>아이디 : ${member.id}</p>
					<p>닉네임 : ${member.nickName}</p>
					<p>사진 : ${member.photo==null?"사진 없음":member.photo}</p>
					<p>포인트 : ${member.balance} 포인트</p>
					<p>관리자 : ${member.admin}</p>
					
					<p>관심분야 :</p>
					
					<p>판매완료 : 00건</p>
					<p>구매완료 : 00건</p>
					<p>판매평점 : 00점</p>
					<div class="fh5co-spacer fh5co-spacer-sm"></div>
					<p>판매 가능 재능 목록</p>
					<a data-toggle="modal" href="#profileModal" class="btn btn-sm btn-info">정보 수정</a>
					<c:if test="${member.admin==1}">
						<a href="memberList.jsp" class="btn btn-sm btn-info">회원관리</a>
					</c:if>
					
				</div>
        	</div>
       </div>
	</div>

	<!-- 프로필 수정  Modal -->
	<div class="modal fade" id="profileModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">정보 수정</h4>
				</div>
				<div class="modal-body">
					<table id="profileTable">
						<tr>
							<td>사진 : </td><td><input type="file"></td>
						</tr>
						<tr>
							<td>관심 분야 : </td><td>관심분야 선택</td>
						</tr>
					</table>
				</div>
			</div>

		</div>
	</div>
	<!-- Modal -->


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
	<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"50873",secure:"50882"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>
	<body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-34" data-genuitec-path="/FinalProject/WebContent/member/profile.jsp">
	<style data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-34" data-genuitec-path="/FinalProject/WebContent/member/profile.jsp">
	.photo{
		position: relative;
		float: left;
		margin-right: 30px;
		width: 300px;
		height: 300px;
		
	}
	#mainTable{
		display: inline;
	}
	
	</style>
	

	
	
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
			
				<div class="col-md-8 col-md-offset-2">
					<h2>프로필 관리</h2>
					<img src="<c:url value="/user/profile/${member.id}"/>/${member.photo}" alt="Free HTML5 template by FREEHTML5.co" class="img-rounded img-responsive photo">
					<table id="mainTable" class="table">
						<tr>
							<td>아이디 : ${member.id}</td>
						</tr>
						<tr>
							<td>닉네임 : ${member.nickName}</td>
						</tr>
						<tr>
							<td>사진 : ${member.photo==null?"사진 없음":member.photo}</td>
						</tr>
						<tr>
							<td>포인트 : <fmt:formatNumber value="${member.balance}"
									type="number" /> 포인트
							</td>
						</tr>
						<tr>
							<td>관리자 : ${member.admin}</td>
						</tr>
						<tr>
							<td>관심분야 : <button onclick="location.href='dipsList.do?id=${member.id}'">찜목록</button></td>
						</tr>
						<tr><td></td></tr>
					</table>
					<br><br>
					<br><br>
					<table>
						<tr>
							<td>판매완료 : 00건</td>
						</tr>
						<tr>
							<td>구매완료 : 00건</td>
						</tr>
						<tr>
							<td>판매평점 : 00점</td>
						</tr>
						<tr>
							<td>판매 가능 재능 목록</td>
						</tr>
						<tr>
							<td>
								<ul>
									<li>리스트1</li>
									<li>리스트2</li>
								</ul>
							</td>
						</tr>
					</table>
					<div class="fh5co-spacer fh5co-spacer-sm"></div>
					<a data-toggle="modal" href="#profileModal" class="btn btn-sm btn-info">정보 수정</a>
					<c:if test="${member.admin==1}">
						<a href="memberManager.do" class="btn btn-sm btn-info">회원관리</a>
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
					<form action="profileUpdate.do" method="post" enctype="multipart/form-data">
					<table id="profileTable">
						<tr>
							<td>사진 : </td><td><input type="file" name="file"></td>
						</tr>
						<tr>
							<td>관심 분야 : </td><td>관심분야 선택</td>
						</tr>
					</table>
					<input type="submit" value="수정" class="btn-sm btn-info">
					</form>
				</div>
			</div>

		</div>
	</div>
	<!-- Modal -->



</body>
</html>
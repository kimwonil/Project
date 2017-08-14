<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../menu.jsp" %>
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
	#mainTable{
		display: inline;
	}
	textarea{
		resize: none;
	}
	#profileTable{
		margin: 0px auto;
	}
	#profileTable input[type=text]{
		width:256px;
	}
	#profileTable select{
		height: 31px;
	}
	#introduce{
		margin-top: 70px;
	}
	#introduce textarea{
		margin: 10px;
	}
	</style>
	

	
	
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
			
				<div class="col-md-8 col-md-offset-2">
					<h2>프로필 관리</h2>
					<c:if test="${member.photo eq null}">
						<img class="photo" src="<c:url value="/images"/>/noimage.jpg">
					</c:if>
					<c:if test="${member.photo ne null}">
						<img class="photo" src="<c:url value="/user/profile/${member.id}/${member.login}"/>/${member.photo}">
					</c:if>
					<table id="mainTable" class="table">
						<tr>
							<td>아이디 : ${member.id}</td>
						</tr>
						<tr>
							<td>닉네임 : ${member.nickname}</td>
						</tr>
						<tr>
							<td>사진 : ${member.photo}</td>
						</tr>
						<tr>
							<td>포인트 : <fmt:formatNumber value="${member.balance}"
									type="number" /> P
							</td>
						</tr>
<!-- 						<tr> -->
<%-- 							<td>관리자 : ${member.admin}</td> --%>
<!-- 						</tr> -->
						<tr>
							<td>관심분야 : <button onclick="location.href='dipsList.do?id=${member.id}'">찜목록</button></td>
						</tr>
						<tr>
							<td>계좌 : ${member.bank} / ${member.account} </td>
						</tr>
						<tr>
						<td></td>
						</tr>
					</table>
					<br>
					<table id="introduce">
						<tr>
							<td><textarea rows="10" cols="75" readonly="readonly">${member.introduce}</textarea></td>
						</tr>
					</table>
					<table>
						<tr>
							<td>판매중 : </td><td><a href="selling.do"><div>${selling}건</div></a></td>
						</tr>
						<tr>
							<td>구매중 :  </td><td><a href="purchasing.do"><div>${purchase}건</div></a></td>
						</tr>
						<tr>
							<td>판매평점 :  </td><td>00점</td>
						</tr>
						<tr>
							<td colspan="2">판매 가능 재능 목록</td>
						</tr>
						<tr>
							<td colspan="2">
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
							<td width="20%">계좌번호 : </td>
							<td>
								<select name="bank">
									<c:forEach items="${bankList}" var="bankValue">
										<option value="${bankValue.no}" >${bankValue.bank}</option>
									</c:forEach>
								</select>
							<input type="text" name="account" value="${member.account}"></td>
						</tr>
						<tr>
							<td>소개글 : </td>
							<td><textarea rows="10" cols="50" name="introduce">${member.introduce}</textarea></td>
						</tr>
						<tr>
							<td>사진 : </td><td><input type="file" name="file"></td>
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